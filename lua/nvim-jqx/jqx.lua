local fw = require("nvim-jqx.floating")
local config = require("nvim-jqx.config")

local function has_value(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end


local function get_key_location(key, ft)
   if ft == 'json' then
	  return {
		 row = vim.api.nvim_exec([[g/^\s*"]]..key..[[/echo line('.')]], true),
		 col = vim.api.nvim_exec([[g/^\s*"]]..key..[[/execute "normal! ^" | echo col('.')-1]], true)
	  }
   elseif ft == 'yaml' then
	  return {
		 row = vim.api.nvim_exec([[g/^]]..key..[[/echo line('.')]], true),
		 col = vim.api.nvim_exec([[g/^]]..key..[[/execute "normal! ^" | echo col('.')]], true)
	  }
   end
end

local function populate_qf(ft, type, sort)
   local cmd_lines = {}
   local cur_file = vim.fn.getreg("%")
   if ft == 'json' then
	  local json_types = {'string', 'number', 'boolean', 'array', 'object', 'null'}
	  if has_value(json_types, type) then
		 for s in vim.fn.system("jq -c 'to_entries[] | if (.value|type == \""..type.."\") then .key else empty end' "..cur_file):gmatch("[^\r\n]+") do
			local key = s:gsub('%"', ''):gsub('^%s*(.-)%s*$','%1'):gsub(',','')
			table.insert(cmd_lines, key)
		 end
	  else
		 local get_keys = sort and "jq 'keys[]' "..cur_file or "jq 'keys_unsorted[]' "..cur_file
		 for s in vim.fn.system(get_keys):gmatch("[^\r\n]+") do
			local key = s:gsub('%"', ''):gsub('^%s*(.-)%s*$','%1'):gsub(',','')
			table.insert(cmd_lines, key)
		 end
	  end

   elseif ft == 'yaml' then
	  for s in vim.fn.system("yq eval 'keys' "..cur_file):gmatch("[^\r\n]+") do
		 local key = s:gsub('^-%s+', '')
		 table.insert(cmd_lines, key)
	  end
   end

   local qf_list = {}
   for _, v in pairs(cmd_lines) do
	  table.insert(qf_list, {filename = cur_file, lnum = get_key_location(v, ft).row, col = get_key_location(v, ft).col, text = v})
   end

   vim.fn.setqflist(qf_list, ' ')
   vim.cmd('copen')
end

local function parse_jq_query(key, cur_file, ft)
   local parsed_lines = {}
   if ft == 'json' then
	  for s in vim.fn.system("jq '.\""..key.."\"' "..cur_file):gmatch("[^\r\n]+") do
		 table.insert(parsed_lines, s)
	  end
   elseif ft == 'yaml' then
	  for s in vim.fn.system("yq eval '.\""..key.."\"' "..cur_file):gmatch("[^\r\n]+") do
		 table.insert(parsed_lines, s)
	  end
   end
   return parsed_lines
end

local function on_keystroke(ft)
   local line = vim.api.nvim_get_current_line()
   local words = {}
   for word in line:gmatch("[^|]+") do table.insert(words, word:match("^%s*(.+)")) end
   local key, cur_file = words[#words], words[1]
   local results = parse_jq_query(key, cur_file, ft)
   local floating_buf = fw.floating_window(config.geometry)

   table.insert(results, 1, fw.centre_string(key))
   table.insert(results, 2, '')
   vim.api.nvim_buf_set_lines(floating_buf, 0, -1, true, results)
   fw.set_fw_opts(floating_buf, ft)
   vim.cmd('execute "normal! gg"')
end

return {
   populate_qf = populate_qf,
   on_keystroke = on_keystroke,
}

