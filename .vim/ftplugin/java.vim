" Vim filetype plugin
" Language:     Java

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1


augroup java
    au! * <buffer>
    au BufWinEnter <buffer> setlocal foldlevel=0
    au BufWinEnter <buffer> setlocal foldmethod=syntax
augroup END

