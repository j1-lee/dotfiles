setlocal spell

" auto-pairs and vim-surround settings
let b:AutoPairs = {'(':')', '[':']', '{':'}', '$':'$'}
let b:surround_39 = "`\r'" " ys<motion>'
let b:surround_34 = "``\r''" " ys<motion><quote>
nmap <buffer> <F8> ySSl
xmap <buffer> <F8> Sl

if exists('*GetFirstError')
  augroup ftplugin_tex
    autocmd!
    autocmd CursorMoved <buffer> call <SID>show_error(line('.'))
    autocmd User VimtexEventCompileFailed call <SID>show_error()
  augroup END
endif

function! s:show_error(...)
  let _ = call('GetFirstError', a:000)
  if empty(_) | return | endif
  let l:type = _.type == 'E' ? 'Error' : 'Warning'
  let l:lnum = _.lnum
  let l:text = substitute(_.text, '\s*\n\s*', ' ', 'g')
  let l:msg = l:type . ' at ' . l:lnum . ': ' . l:text
  let l:msg_trunc = strpart(l:msg, 0, v:echospace - 1)
  let l:msg_trunc = substitute(l:msg_trunc, '[\u80-\uff]\+$', '', '')
  execute 'echohl' l:type . 'Msg'
  echo l:msg_trunc
  if l:msg_trunc != l:msg | echohl NonText | echon '»' | endif
  echohl None
endfunction
