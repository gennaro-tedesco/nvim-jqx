if exists("g:loaded_blast")
	finish
endif

nnoremap <Plug>BlastList :lua require('nvim-blast').blast_open()<CR>
command! BlastList execute 'lua require("nvim-blast").blast_open()<CR>'

let g:loaded_blast = 1
