if exists("g:loaded_jqix")
	finish
endif

nnoremap <Plug>Jqix :lua require('nvim-jqix').jqix_open()<CR>
command! Jqix execute 'lua require("nvim-jqix").jqix_open()<CR>'

let g:loaded_jqix = 1
