-- this module exposes the main interface

local jqx = require("nvim-jqx.jqx")
local config = require("nvim-jqx.config")

local function set_qf_maps(ft)
   vim.api.nvim_exec([[autocmd FileType qf nnoremap <buffer> ]]..config.query_key..[[ :lua require("nvim-jqx.jqx").on_keystroke("]]..ft..[[")<CR> ]], false)
end

local function jqx_open()
   local ft = vim.bo.filetype
   if not (ft == 'json' or ft == 'yaml') then
	  print('only json or yaml files')
	  return nil
   end

   if ft == 'json' then
	  if vim.fn.executable("jq") == 0 then print("please install jq"); return nil end
   end

   if ft == 'yaml' then
	  if vim.fn.executable("yq") == 0 then print("please install yq"); return nil end
   end

   if ft == 'json' then vim.cmd('%! jq .') end
   set_qf_maps(ft)
   jqx.populate_qf(ft)
end

return {
   jqx_open = jqx_open,
}
