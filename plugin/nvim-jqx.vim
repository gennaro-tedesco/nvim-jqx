if exists("g:loaded_jqx")
	finish
endif

nnoremap <Plug>JqxList :lua require('nvim-jqx').jqx_open()<CR>
command! JqxList execute 'lua require("nvim-jqx").jqx_open()<CR>'

command! -complete=customlist,FileKeys -nargs=? JqxQuery execute 'lua require("nvim-jqx").query_jq("'..<q-args>..'")<CR>'

function! FileKeys(A, L, P) abort
	if &filetype ==# 'json'
		let a = split(system("jq 'keys' " . getreg("%") . " | sed 's/,*$//g' | sed '1d;$d' "), "\n")
		call map(a, {idx, val -> substitute(trim(val), '\"', '', 'g')})
	elseif &filetype == 'yaml'
		let a = split(system("yq eval 'keys' " . getreg("%")), "\n")
		call map(a, {idx, val -> substitute(trim(val), '-', '', 'g')})
	endif
	return filter(a, 'v:val =~ ''\V\^''.a:A')
endfunction

let g:loaded_jqx = 1
