local fw = require("nvim-jqix.floating")
local config = require("nvim-jqix.config")

local function get_key_location(key)
   local coord = {
	  row = vim.api.nvim_exec([[g/]]..key..[[/echo line('.')]], true),
	  col = vim.api.nvim_exec([[g/]]..key..[[/execute "normal! ^" | echo col('.')-1]], true)
   }
   return coord
end

local function populate_qf()
   local cmd_lines = {}
   local cur_file = vim.fn.getreg("%")
   for s in vim.fn.system("jq 'keys' "..cur_file):gmatch("[^\r\n]+") do
	  if not (string.find(s, '%[') or string.find(s, '%]')) then
		 local key = s:gsub('%"', ''):gsub('^%s*(.-)%s*$','%1'):gsub(',','')
		 table.insert(cmd_lines, key)
	  end
   end

   local qf_list = {}
   for _, v in pairs(cmd_lines) do
	  table.insert(qf_list, {filename = cur_file, lnum = get_key_location(v).row, col = get_key_location(v).col, text = v})
   end

   vim.fn.setqflist(qf_list, ' ')
   vim.cmd('copen')
end

local function parse_jq_query(key, cur_file)
   local parsed_lines = {key, ''}
   for s in vim.fn.system("jq '.\""..key.."\"' "..cur_file):gmatch("[^\r\n]+") do
	  table.insert(parsed_lines, s)
   end
   return parsed_lines
end

local function on_keystroke()
   local line = vim.api.nvim_get_current_line()
   local words = {}
   for word in line:gmatch("[^|%s]+") do table.insert(words, word) end
   local key, cur_file = words[#words], words[1]
   local results = parse_jq_query(key, cur_file)
   local floating_buf = fw.floating_window(config.geometry)
   vim.api.nvim_buf_set_lines(floating_buf, 0, -1, true, results)
   fw.set_json_opts(floating_buf)
end

return {
   populate_qf = populate_qf,
   on_keystroke = on_keystroke,
}

