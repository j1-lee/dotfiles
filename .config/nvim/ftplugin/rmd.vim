set colorcolumn=121,122

nmap <buffer> <silent> ]] :call b:NextRChunk()<CR>
nmap <buffer> <silent> [[ :call b:PreviousRChunk()<CR>
nmap <buffer> <silent> K :call RAction('help')<CR>
