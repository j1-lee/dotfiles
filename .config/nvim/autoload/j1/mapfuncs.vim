" toggle vimrc
function! j1#mapfuncs#toggle_vimrc()
  let l:w = bufwinnr($MYVIMRC)
  if l:w > 0
    execute (winnr('$') > 1) ? l:w . 'close' : 'enew'
  else
    if winnr('$') == 1 && bufname() == '' && !&modified
      execute 'edit' $MYVIMRC
    else
      execute 'vsplit' $MYVIMRC
    endif
  endif
endfunction

" toggle quickfix
function! j1#mapfuncs#toggle_qf()
  for l:w in range(1, winnr('$'))
    if getwinvar(l:w, '&buftype') == 'quickfix'
      execute (winnr('$') == 1) ? 'enew' : 'cclose'
      return
    endif
  endfor
  copen
endfunction

" jump between errors
function! j1#mapfuncs#jump_qf(where)
  try | execute 'c' . a:where | catch /E553/ | cc | catch /E42/ | endtry
endfunction

" execute line/selection as vimscript
function! j1#mapfuncs#run_vimscript(visual)
  let l:lines = a:visual ? getline("'<", "'>") : [getline('.')]
  echo join(l:lines, "\n")
  if confirm('Execute this Vimscript?', "&Yes\n&No", 2) != 1 | return | endif
  let l:tempname = tempname()
  call writefile(l:lines, l:tempname)
endfunction
