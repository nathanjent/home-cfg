" Define folds for XML Comments
syn region  csXmlComment        start="^\s*///" end="^\%\(\s*///\)\@!" transparent fold keepend
syn region  csXmlComment        start="^\s*//[^\/]\?" end="^\%\(\s*//[^\/]\?\)\@!" transparent fold keepend

" Redefine without 'using' keyword so we can define a fold
syn clear csUnspecifiedStatement
syn keyword csUnspecifiedStatement  as base checked event fixed in is lock nameof operator out params ref sizeof stackalloc this unchecked unsafe
syn region  csUsing             start="^\s*using\s\+.*;\s*" end="^\(\s*using\s\+.*;\s*\)\@!" transparent fold keepend
