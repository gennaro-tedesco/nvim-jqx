-- this module exposes the main interface

local jqx = require("nvim-jqx.jqx")
local config = require("nvim-jqx.config")

local function set_qf_maps()
   vim.api.nvim_exec([[autocmd FileType qf nnoremap <buffer> ]]..config.query_key..[[ :lua require("nvim-jqx.jqx").on_keystroke()<CR> ]], false)
end

local function jqx_open()
   if vim.bo.filetype ~= 'json' then
	  print('not a json file')
	  return nil
   end

   vim.cmd('%! jq .')
   set_qf_maps()
   jqx.populate_qf()
end

return {
   jqx_open = jqx_open,
}
