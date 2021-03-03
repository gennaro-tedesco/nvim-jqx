function! Reload() abort
	lua for k,v in pairs(package.loaded) do if k:match('^nvim%-blast') then package.loaded[k] = nil end end
	lua require('nvim-blast')
endfunction

nnoremap rr :w <Bar> call Reload()<CR>
