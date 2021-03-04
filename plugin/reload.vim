function! Reload() abort
	lua for k,v in pairs(package.loaded) do if k:match('^nvim%-jqix') then package.loaded[k] = nil end end
	lua require('nvim-jqix')
endfunction

nnoremap rr :w <Bar> call Reload()<CR>
