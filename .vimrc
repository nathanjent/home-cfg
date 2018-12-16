" Nathan's vimrc file.
"
" Maintainer:   Nathan Jent <nathanjent@gmail.com>

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

source $VIMRUNTIME/defaults.vim

colorscheme industry

let s:is_win = has('win32') || has('win64')

if s:is_win
    set runtimepath^=$HOME/.vim
    set runtimepath+=$HOME/.vim/after
    set packpath^=$HOME/.vim
    set packpath+=$HOME/.vim/after
endif
    
" Basic settings {{{
set autoindent              " Indent according to previous line.
set expandtab               " Use spaces instead of tabs.
set tabstop     =4          " Spaces per tab
set softtabstop =4          " Tab key indents by 4 spaces.
set shiftwidth  =4          " >> indents by 4 spaces.
set shiftround              " >> indents to next multiple of 'shiftwidth'.

set hidden                  " Switch between buffers without having to save first.
set showmatch               " Highlight matching [{()}]
if !s:is_win
    set laststatus  =2          " Always show statusline.
endif
set display     =lastline   " Show as much as possible of the last line.

set showmode                " Show current mode in command-line.

set incsearch               " Highlight while searching with / or ?.
set hlsearch                " Keep matches highlighted.

set ttyfast                 " Faster redrawing.
set lazyredraw              " Only redraw when necessary.

set splitbelow              " Open new windows below the current window.
set splitright              " Open new windows right of the current window.

"set cursorline              " Highlight the current line
set wrapscan                " Searches wrap around end-of-file.
set report      =0          " Always report changed lines.
set synmaxcol   =200        " Only highlight the first 200 columns.

set list                    " Show non-printable characters.

set number                  " Include the line number column
set cpoptions+=n            " Wrapped lines use line number column; example->--------------------------------------------------------------------------------------------------------------------------->

set foldenable              " Enable folding
set foldlevelstart=5        " Open folds to this level for new buffer
set foldnestmax=10          " 10 nested fold max

set noshowmatch             " Showmatch significantly slows down omnicomplete when the first match contains parentheses.
set completeopt=longest,menuone,preview
set splitbelow              " New split window below current
if s:is_win
    set wrapmargin=1        "Number of characters from the right where wrapping starts
endif
" }}}

" Sometimes utf-8 is required {{{
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:? ,extends:?,precedes:?,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif
" }}}

" Highlight repeated lines {{{
command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()
function! HighlightRepeats() range
  let lineCounts = {}
  let lineNum = a:firstline
  while lineNum <= a:lastline
    let lineText = getline(lineNum)
    if lineText != ""
      let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
    endif
    let lineNum = lineNum + 1
  endwhile
  exe 'syn clear Repeat'
  for lineText in keys(lineCounts)
    if lineCounts[lineText] >= 2
      exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
    endif
  endfor
endfunction
" }}}

let s:vimfiles = expand('$HOME/.vim')

" Tool Plugins {{{
packadd! nerdtree
packadd! nerdtree-git-plugin
packadd! editorconfig-vim
let g:EditorConfig_exec_path = s:vimfiles . '/pack/submodules/start/editorconfig-vim/plugin/editor-core-py/main.py'
" }}}

" Snip tools {{{
packadd! vim-snippets
packadd! ultisnips
let g:UltiSnipsExpandTrigger='<c-e>' " <tab> conflicts with YouCompleteMe
" let g:UltiSnipsJumpForwardTrigger='<c-b>'
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}

" Syntax Plugins {{{
packadd! vim-polyglot " Support for many languages
if s:is_win
    packadd! windows-powershell-syntax-plugin " Support for Powershell
endif
" }}}

finish " break here temporarily

"Vim-Plug plugin management {{{
" Download Vim-Plug if not available {{{
let s:vim_plug_file = s:vimfiles . '/autoload/plug.vim'
if !filereadable(s:vim_plug_file)
    execute '!curl -fLo ' . s:vim_plug_file . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    echo 'Vim-Plug installed. Installing plugins'
    autocmd VimEnter * PlugInstall
endif
" }}}

let s:vim_plugged = s:vimfiles . '/plugged'
call plug#begin(s:vim_plugged)
    Plug 'sheerun/vim-polyglot' " Syntax support for many languages

    Plug 'vim-scripts/editorconfig-vim' " Editor Config {{{
        let g:EditorConfig_exec_path = s:vimfiles . '/plugged/editorconfig-vim/plugin/editor-core-py/main.py'
    "}}}

    "Plug 'craigemery/vim-autotag' " Autogenerate tags {{{
        let g:autotagExcludeSuffixes    = "orig.swp"     " suffixes to not ctags on
    "}}}

    Plug 'majutsushi/tagbar' " Show functions and fields from live generated tags

    "Plug 'vim-pandoc/vim-pandoc-syntax' " Syntax support for markdown, has some extra features

    Plug 'scrooloose/nerdtree', { 'on': 'NERDTree' } " Browse files in vim

    Plug 'Xuyuanp/nerdtree-git-plugin' " Display GIT symbols in Nerdtree {{{
        if s:is_win
            let g:NERDTreeIndicatorMapCustom = {
                \ "Modified"  : "|*|",
                \ "Staged"    : "|S|",
                \ "Untracked" : "|_|",
                \ "Renamed"   : "|R|",
                \ "Unmerged"  : "|~|",
                \ "Deleted"   : "|-|",
                \ "Dirty"     : "|+|",
                \ "Clean"     : "|=|",
                \ 'Ignored'   : '|I|',
                \ "Unknown"   : "| |"
                \ }
        endif
    "}}}

    Plug 'OrangeT/vim-csharp' " Syntax support for C# things
    Plug 'OmniSharp/omnisharp-vim' " C# language server {{{
        let g:OmniSharp_selector_ui = 'ctrlp'
        let g:OmniSharp_timeout = 5
        set previewheight=8

        augroup omnisharp_commands
            autocmd!
            " Show type information automatically when the cursor stops moving
            autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

            " Goto commands
            autocmd FileType cs nnoremap <buffer> <Leader>gd :OmniSharpGotoDefinition<CR>
            autocmd FileType cs nnoremap <buffer> <Leader>gi :OmniSharpFindImplementations<CR>
            autocmd FileType cs nnoremap <buffer> <Leader>gr :OmniSharpFindUsages<CR>

            " Information commands
            autocmd FileType cs nnoremap <buffer> <Leader>gt :OmniSharpTypeLookup<CR>
            autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
            autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>
            autocmd FileType cs nnoremap <buffer> <Leader>d :OmniSharpDocumentation<CR>

            " Refactoring commands
            autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpCodeFormat<CR>
            autocmd FileType cs nnoremap <buffer> <Leader>i :OmniSharpFixUsings<CR>
            autocmd FileType cs nnoremap <buffer> <Leader>r :OmniSharpRename<CR>
            autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
            autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

            " Navigate up and down by method/property/field
            autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
            autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
        augroup end
    "}}}

    " YouCompleteMe polyglot code-completion engine {{{
    if or(has('python_compiled'), has('python3_compiled'))
        Plug 'Valloric/YouCompleteMe', { 
                    \ 'do' : 'python ./install.py --clang-completer --rust-completer --java-completer --go-completer'
                    \ }
        nnoremap <leader>y :YcmDiags<cr>
        nnoremap <F5> :YcmForceCompileAndDiagnostics<cr>

        " Goto commands
        nnoremap <leader>gd :YcmCompleter GoTo<cr>
        nnoremap <leader>g :YcmCompleter GoTo<cr>
        nnoremap <leader>gr :YcmCompleter GoToReferences<cr>

        " Information commands
        nnoremap <leader>gt :YcmCompleter GetType<cr>
        nnoremap <leader>d :YcmCompleter GetDoc<cr>

        " Refactoring commands
        nnoremap <leader>fm :YcmCompleter Format<cr>
        nnoremap <leader>f :YcmCompleter FixIt<cr>
        nnoremap <leader>i :YcmCompleter OrganizeImports<cr>
        nnoremap <leader>r :YcmCompleter RefactorRename 

        " YouCompleteMe requires UTF-8
        set encoding=utf-8
    endif
    "}}}
    
    Plug 'w0rp/ale' " Asynchronous Linting Engine {{{
             let g:ale_linters = {
                         \'cs': ['OmniSharp']
                         \}

            "             \'rust': ['rls']
            "             \}
            " let g:ale_fixers = {
            "             \'rust': ['rustfmt']
            "             \}
        "}}}
            
    "Plug 'vim-syntastic/syntastic' " Syntax helper
    
    Plug 'Shougo/neocomplete.vim' " Autocomplete

    " Snip tools {{{
        Plug 'honza/vim-snippets'

        Plug 'SirVer/ultisnips' " Insert snippets of code {{{
            let g:UltiSnipsExpandTrigger='<c-e>' " <tab> conflicts with YouCompleteMe
            " let g:UltiSnipsJumpForwardTrigger='<c-b>'
            " let g:UltiSnipsJumpBackwardTrigger="<c-z>"
            " If you want :UltiSnipsEdit to split your window.
            let g:UltiSnipsEditSplit="vertical"
        " }}}

        "Plug 'garbas/vim-snipmate' " Insert snippets of code {{{
        "    Plug 'tomtom/tlib_vim'
        "    Plug 'MarcWeber/vim-addon-mw-utils'
        "" }}}
    " }}}

    Plug 'tpope/vim-dispatch' " Async script running

    Plug 'kien/ctrlp.vim' " File search {{{
        let g:ctrlp_match_window = 'bottom,order:ttb'
        let g:ctrlp_switch_buffer = 0
        let g:ctrlp_working_path_mode = 0
        let g:ctrlp_user_command = 'rg %s -l --hidden -g ""'
    "}}}

    Plug 'stephpy/vim-yaml' " YAML syntax

    "lh-vim {{{ Refactoring support for C, C++, Java, Pascal, VimL
        " Plug 'LucHermitte/lh-vim-lib' 
        " Plug 'LucHermitte/lh-tags'
        " Plug 'LucHermitte/lh-dev'
        " Plug 'LucHermitte/lh-brackets'
        " Plug 'LucHermitte/vim-refactor'
    " }}}

    if s:is_win
        Plug 'dylon/vim-antlr' " Syntax support for Antlr

        Plug 'vim-scripts/Windows-PowerShell-Syntax-Plugin' " Syntax support for Powershell
    else
        Plug 'peter-edge/vim-capnp'

        Plug 'hsanson/vim-android' " Gradle/Android support

        Plug 'Shougo/vimproc.vim', { 'do' : 'make' } " Asynchronous library

        Plug 'idanarye/vim-vebugger' " Vim debugger frontend {{{
            let g:vebugger_leader='<leader>d'
        "}}}
    endif
call plug#end() "}}}

" vim:ts=4:sw=4:ai:foldmethod=marker:foldlevel=0
