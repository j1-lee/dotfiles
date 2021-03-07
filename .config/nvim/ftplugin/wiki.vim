setlocal spell spelllang+=cjk,es

nmap <buffer> <silent> _ :call <SID>toggle_acento()<CR>

augroup ftplugin_wiki
  autocmd!
  autocmd BufWritePost <buffer> silent MakiExportHtml
augroup END

function! s:toggle_acento()
  let l:line = getline('.')
  let l:charcol = strchars(strpart(l:line, 0, col('.')))
  let l:left = strcharpart(l:line, 0, l:charcol - 1)
  let l:middle = tr(strcharpart(l:line, l:charcol - 1, 1),
        \ 'aeiounáéíóúñAEIOUNÁÉÍÓÚÑ?!¿¡',
        \ 'áéíóúñaeiounÁÉÍÓÚÑAEIOUN¿¡?!'
        \ )
  let l:right = strcharpart(l:line, l:charcol)
  call setline('.', l:left . l:middle . l:right)
endfunction
