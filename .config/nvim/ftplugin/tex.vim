setlocal spell

" auto-pairs and vim-surround settings
let b:AutoPairs = {'(':')', '[':']', '{':'}', '$':'$'}
let b:surround_39 = "`\r'" " ys<motion>'
let b:surround_34 = "``\r''" " ys<motion><quote>
nmap <buffer> <F8> ySSl
xmap <buffer> <F8> Sl

augroup ftplugin_tex
  autocmd!
  autocmd User VimtexEventCompileFailed
        \ call ale#other_source#ShowResults(bufnr(), 'vimtex', getqflist())
  autocmd User VimtexEventCompileStarted
        \ call ale#other_source#StartChecking(bufnr(), 'vimtex')
augroup END
