" Vim syntax plugin
" Language:     Java
"
" Clear default folds
" syn clear javaFold
" syn clear javaBraces
" syn clear javaDocComment

" " Redefine without 'import' keyword so we can define a fold
" syn clear javaExternal
" syn keyword javaExternal native package
" syn region javaFoldImports start="^\s*\(import\s\+.*;\).*$" end="^\s*\(import\s\+.*\)\@!.*$" transparent fold keepend
" 
" " Define block comment regions
" syn region javaDocComment start="^\s*/\*\*" end="^.*\*/" keepend contains=javaCommentTitle,@javaHtml,javaDocTags,javaDocSeeTag,javaTodo,@Spell fold
" syn region javaBlockComment start="^\s*/\*" end="^.*\*/" transparent fold keepend


