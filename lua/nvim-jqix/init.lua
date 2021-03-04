-- this module exposes the main interface

local jqix = require("nvim-jqix.jqix")
local config = require("nvim-jqix.config")

local function set_qf_maps()
   vim.api.nvim_exec([[autocmd FileType qf nnoremap <buffer> ]]..config.query_key..[[ :lua require("nvim-jqix.jqix").on_keystroke()<CR> ]], false)
end

local function jqix_open()
   if vim.bo.filetype ~= 'json' then
	  print('not a json file')
	  return nil
   end

   vim.cmd('%! jq .')
   set_qf_maps()
   jqix.populate_qf()
end

return {
   jqix_open = jqix_open,
}
