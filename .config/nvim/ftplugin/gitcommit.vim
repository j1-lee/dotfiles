setlocal colorcolumn=73,74

augroup ftplugin_gitcommit
  autocmd!
  autocmd BufWinEnter <buffer> call cursor(1, 1) | startinsert!
  autocmd InsertEnter <buffer> call <SID>choose_type()
augroup END

let s:types_info = [
      \ 'none      None of the following items',
      \ 'feat      A new feature',
      \ 'fix       A bug fix',
      \ 'docs      Documentation only changes',
      \ 'style     Changes that do not affect the meaning of the code',
      \ 'refactor  A code change that neither fixes a bug nor adds a feature',
      \ 'perf      A code change that improves performance',
      \ 'test      Adding missing tests or correcting existing tests',
      \ 'chore     Other changes that do not modify src or test files',
      \ 'revert    Reverts a previous commit',
      \ ]
let s:types = map(copy(s:types_info), 'split(v:val, "  ")[0]')
let s:types_info = join(map(s:types_info, 'v:key . " " . v:val'), "\n")

function! s:choose_type()
  if line('.') > 1 || getline(1) != '' | return | endif
  while 1
    redraw
    echohl Question
    let l:type = input(s:types_info . "\n\n" . 'Choose a type: ')
    echohl None
    if l:type =~ '^[0-9]\?$'
      let l:type = s:types[str2nr(l:type)]
      break
    elseif index(s:types, l:type) >= 0
      break
    endif
  endwhile
  if l:type != 'none' | call setline(1, l:type . ': ') | endif
  let v:char = 1
  startinsert!
endfunction
