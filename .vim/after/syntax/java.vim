" Clear defaults
syntax clear javaFold
syntax clear javaBraces
syntax clear javaDocComment
syntax clear javaExternal

" Redefine javaExternal as separate case from imports
syn keyword javaExternal    native package
syn region foldImports start="^\s*import" end="^\s*$" transparent fold keepend

" Block comment regions
syn region javaDocComment start="^\s*/\*\*" end="^.*\*/" keepend contains=javaCommentTitle,@javaHtml,javaDocTags,javaDocSeeTag,javaTodo,@Spell fold
syn region javaBlockComment start="^\s*/\*" end="^.*\*/" transparent fold keepend
