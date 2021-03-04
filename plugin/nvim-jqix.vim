if exists("g:loaded_jqix")
	finish
endif

nnoremap <Plug>JsonQf :lua require('nvim-jqix').jqix_open()<CR>
command! JsonQf execute 'lua require("nvim-jqix").jqix_open()<CR>'

let g:loaded_jqix = 1
