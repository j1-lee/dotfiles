syntax region rmdrChunkNoEval keepend matchgroup=rmdCodeDelim
      \ start="^\s*```\s*{\s*r\>.*eval\s*=\s*FALSE.*$" end="^\s*```\ze\s*$"

highlight link rmdCodeDelim Decorator
highlight link rmdrChunkNoEval Comment
