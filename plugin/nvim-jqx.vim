if exists("g:loaded_jqx")
	finish
endif

nnoremap <Plug>JqxList :lua require('nvim-jqx').jqx_open()<CR>
command! -complete=customlist,TypeKeys -nargs=? JqxList execute 'lua require("nvim-jqx").jqx_open("'..<q-args>..'")'

command! -complete=customlist,FileKeys -nargs=? JqxQuery execute 'lua require("nvim-jqx").query_jq("'..<q-args>..'")<CR>'

function! TypeKeys(A, L, P) abort
	if &filetype ==# 'json'
		return ['string', 'number', 'boolean', 'array', 'object', 'null']
	endif
endfunction

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

augroup JqxAutoClose
	autocmd!
	autocmd WinLeave * call s:JqxClose()
augroup END

function s:JqxClose() abort
	for i in range(1, winnr('$'))
        if getbufvar(winbufnr(i), '&filetype') ==? 'jqx'
			close
		endif
    endfor
endfunction

let g:loaded_jqx = 1
