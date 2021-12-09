runtime! ftplugin/r.vim

nmap <buffer> <silent> ]] :call b:NextRChunk()<CR>
nmap <buffer> <silent> [[ :call b:PreviousRChunk()<CR>

xmap <buffer> <silent> ic :call <SID>textobj_chunk(1)<CR>
omap <buffer> <silent> ic :call <SID>textobj_chunk(1)<CR>
xmap <buffer> <silent> ac :call <SID>textobj_chunk(0)<CR>
omap <buffer> <silent> ac :call <SID>textobj_chunk(0)<CR>

function! s:textobj_chunk(inner)
  call search('^```{r\>', 'bcW')
  execute 'normal!' (a:inner ? 'jV' : 'V')
  call search('^```\s*$', 'W')
  if a:inner | execute 'normal! k' | endif
endfunction
