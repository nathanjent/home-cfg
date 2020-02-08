" Vim filetype plugin
" Language:		JSON

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

setlocal foldmethod=syntax
setlocal foldlevel=0

" Format JSON with a command included with Python
if !exists('*s:JSONFormatter')
  function s:JSONFormatter()
    %!python -m json.tool
  endfunction
endif
if !exists(':JSONFormat')
  command JSONFormat call s:JSONFormatter()
endif
