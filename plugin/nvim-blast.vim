if exists("g:loaded_blast")
	finish
endif

nnoremap <Plug>BlastList :lua require('nvim-blast').blast_open()<CR>
nmap <leader>b <Plug>BlastList


let g:loaded_blast = 1
