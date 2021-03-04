-- this module exposes the main interface

local blast = require("nvim-blast.blast")

local function set_qf_maps()
   vim.api.nvim_exec([[autocmd FileType qf nnoremap <buffer> X :lua require("nvim-blast.blast").on_keystroke()<CR> ]], false)
end

local function blast_open()
   if vim.bo.filetype ~= 'json' then
	  print('not a json file')
	  return nil
   end

   vim.cmd('%! jq .')
   set_qf_maps()
   blast.populate_qf()
end

return {
   blast_open = blast_open,
}
