function! Reload() abort
	lua for k,v in pairs(package.loaded) do if k:match('^nvim%-jqx') then package.loaded[k] = nil end end
	lua require('nvim-jqx')
endfunction

nnoremap rr :w <Bar> call Reload()<CR>
