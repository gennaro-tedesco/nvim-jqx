if exists("g:loaded_blast")
	doautocmd QuickFixCmdPost cwindow
else
	cclose
	execute min([ 10, len(getqflist()) ]) 'cwindow'
endif

nnoremap <Plug>BlastList :lua require('nvim-blast').blast_list()<CR>
nmap <leader>b <Plug>BlastList

let g:loaded_blast = 1
