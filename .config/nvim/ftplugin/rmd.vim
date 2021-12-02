nmap <buffer> <silent> ]] :call <SID>jump_chunk(0)<CR>
nmap <buffer> <silent> [[ :call <SID>jump_chunk(1)<CR>

function s:jump_chunk(backwards)
  call search('^```{r\>', a:backwards ? 'bW' : 'W')
endfunction
