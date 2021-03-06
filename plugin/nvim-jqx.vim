if exists("g:loaded_jqx")
	finish
endif

nnoremap <Plug>JqxList :lua require('nvim-jqx').jqx_open()<CR>
command! JqxList execute 'lua require("nvim-jqx").jqx_open()<CR>'

command! JqxQuery execute 'lua require("nvim-jqx.jqx").query_jq()<CR>'

let g:loaded_jqx = 1
