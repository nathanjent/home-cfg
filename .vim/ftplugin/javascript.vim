" Vim filetype plugin file
" Language:	Javascript

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" Simple re-format for minified Javascript
if !exists('*s:UnMinify')
  function s:UnMinify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
  endfunction
endif
if !exists(':UnMinify')
  command UnMinify call s:UnMinify()
endif
