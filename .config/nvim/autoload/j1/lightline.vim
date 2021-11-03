function! j1#lightline#configure()
  let g:lightline = {'colorscheme': 'nord'}
  let g:lightline.subseparator = {'left': '', 'right': ''}
  let g:lightline.active = {
        \ 'left'  : [['mode'], ['filename', 'readonly', 'modified']],
        \ 'right' : [['lineinfo'], ['filetype'], ['errors', 'fileinfo']]
        \ }
  let g:lightline.inactive = {
        \ 'left'  : [['filename']],
        \ 'right' : [['lineinfo']]
        \ }
  let g:lightline.tabline = {'left': [['tabs']], 'right': []}
  let g:lightline.tab = {'active': ['filename'], 'inactive': ['filename']}
  let g:lightline.component = {
        \ 'mode'     : "%{winwidth(0) >= 40 ? lightline#mode() : ''}",
        \ 'readonly' : "%{&readonly && &modifiable ? '×' : ''}",
        \ 'modified' : "%{&modified ? '+' : ''}",
        \ 'filetype' : "%{winwidth(0) >= 40 ? &filetype : ''}",
        \ 'lineinfo' : "%l/%L%{
        \   winwidth(0) >= 40
        \     ? printf(' %3d%%', line('.') * 100 / line('$')) : ''
        \ }",
        \ 'fileinfo' : "%{
        \   (&fenc == 'utf-8' || &fenc == '') && &ff == 'unix'
        \     ? '' : &fileencoding . '[' . &fileformat . ']'
        \ }",
        \ 'errors'   : "%{
        \   index(['tex', 'python'], &filetype) >= 0
        \     ? get(j1#lightline#locate_error(), 'status', '') : ''
        \ }",
        \ }
endfunction

" locate first error/warning
function! j1#lightline#locate_error(...)
  let l:filter = 'v:val.bufnr == bufnr()'
  if a:0 | let l:filter .= '&& v:val.lnum == a:1' | endif
  let l:list = filter(getqflist() + getloclist(0), l:filter)
  for l:type in ['E', 'W']
    let l:err = get(filter(copy(l:list), 'v:val.type == l:type'), 0, {})
    if !empty(l:err)
      let l:err.status = l:err.type . ':' . l:err.lnum
      break
    endif
  endfor
  return l:err
endfunction
