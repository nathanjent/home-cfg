" Vim filetype plugin
" Language:		C#

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1


augroup csharp
    au! * <buffer>
    au BufWinEnter <buffer> setlocal foldlevel=0
    au BufWinEnter <buffer> setlocal foldmethod=syntax
augroup END

