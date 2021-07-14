--[[ this module exposes the main interface and
user commands that are defined in /plugin/nvim-jqx.vim ]]

local jqx = require("nvim-jqx.jqx")
local config = require("nvim-jqx.config")
local fw = require("nvim-jqx.floating")

local function is_valid_ft(ft)
   if not (ft == 'json' or ft == 'yaml') then
	  print('only json or yaml files')
	  return false
   end

   if ft == 'json' then
	  if vim.fn.executable("jq") == 0 then print("please install jq"); return false end
   end

   if ft == 'yaml' then
	  if vim.fn.executable("yq") == 0 then print("please install yq"); return false end
   end

   return true
end

local function set_qf_maps(ft)
   vim.api.nvim_exec([[autocmd FileType qf nnoremap <buffer> ]]..config.query_key..[[ :lua require("nvim-jqx.jqx").on_keystroke("]]..ft..[[")<CR> ]], false)
end

local function jqx_open(type)
   local ft = vim.bo.filetype
   if not is_valid_ft(ft) then return nil end
   if ft == 'json' then vim.cmd('%! jq .') end

   set_qf_maps(ft)
   jqx.populate_qf(ft, type, config.sort)
end

local function query_jq(q)
   local ft = vim.bo.filetype
   if not is_valid_ft(ft) then return nil end

   -- reads the query from user input
   vim.fn.inputsave()
   local input_query = q=='' and vim.fn.input('enter query: ') or q
   if input_query == '' then vim.cmd('redraw'); print(' '); return nil end
   local cur_file = vim.fn.getreg("%")
   local user_query = ft=='json' and "jq \'."..input_query.."\' "..cur_file or "yq eval \'."..input_query.."\' "..cur_file
   vim.fn.inputrestore()

   -- parsing query results
   local query_results = {}
   for s in vim.fn.system(user_query):gmatch("[^\r\n]+") do
	  table.insert(query_results, s)
   end
   vim.cmd('redraw')
   print(' ')
   local floating_buf = fw.floating_window(config.geometry)

   table.insert(query_results, 1, fw.centre_string(user_query))
   table.insert(query_results, 2, '')
   vim.api.nvim_buf_set_lines(floating_buf, 0, -1, true, query_results)
   fw.set_fw_opts(floating_buf)
   vim.cmd('execute "normal! gg"')
end

return {
   jqx_open = jqx_open,
   query_jq = query_jq,
}
