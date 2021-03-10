if exists("g:loaded_jqx")
	finish
endif

nnoremap <Plug>JqxList :lua require('nvim-jqx').jqx_open()<CR>
command! JqxList execute 'lua require("nvim-jqx").jqx_open()<CR>'

command! -complete=customlist,FileWords -nargs=? JqxQuery execute 'lua require("nvim-jqx").query_jq("'..<q-args>..'")<CR>'

function! FileWords(A, L, P) abort
	let a = split(system("jq 'keys' " . getreg("%") . " | sed 's/,*$//g' | sed '1d;$d' "), "\n")
	call map(a, {idx, val -> substitute(trim(val), '\"', '', 'g')})
	return filter(a, 'v:val =~ ''\V\^''.a:A')
endfunction

let g:loaded_jqx = 1
