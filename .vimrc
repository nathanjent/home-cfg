" Nathan's vimrc file.
"
" Maintainer:   Nathan Jent <nathanjent@gmail.com>

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

source $VIMRUNTIME/defaults.vim

let s:is_win = has('win32') || has('win64')
let s:is_python = has('python_compiled') || has('python3_compiled')

if s:is_win
    " Use same vim folder on Windows
    set runtimepath^=$HOME/.vim
    set runtimepath+=$HOME/.vim/after
    set packpath^=$HOME/.vim
    set packpath+=$HOME/.vim/after
    nmap <C-z> <Nop>
endif

colorscheme dim
    
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
    set laststatus  =2      " Always show statusline.
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
if has('textprop')
    set completeopt=longest,menuone,preview,popuphidden
    set completepopup=highlight:Pmenu,border:off
else
    set completeopt=longest,menuone,preview
    set previewheight=5
endif

set splitbelow              " New split window below current
if s:is_win
    set wrapmargin=1        "Number of characters from the right where wrapping starts
endif

filetype plugin indent on

" Put all swp files in same directory
silent call mkdir($HOME . "/.vim/swapfiles", "p")
set directory^=$HOME/.vim/swapfiles//
" }}}

" Sometimes utf-8 is required {{{
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:? ,extends:?,precedes:?,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif
" }}}

let s:vimfiles = expand('$HOME/.vim')

" Netrw Nerdtree like settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 20
let g:netrw_dirhistmax = 0

" Plugins {{{
" EditorConfig {{{
packadd! editorconfig-vim
let g:EditorConfig_exclude_patterns = ['scp://.*']
" }}}

if s:is_python
    packadd! nvim-yarp

    set encoding=utf-8 " Required for plugin
    packadd! vim-hug-neovim-rpc
endif

if has('nvim') || has('patch-8.0.902')
    packadd! vim-signify
    set updatetime=100
endif

packadd! vim-snippets
packadd! vim-polyglot " Support for many languages

" CoC {{{
packadd! coc.nvim
let g:coc_global_extensions=[
            \ 'coc-json',
            \ 'coc-tsserver',
            \ 'coc-html',
            \ 'coc-css',
            \ 'coc-java',
            \ 'coc-java-debug',
            \ 'coc-rust-analyzer',
            \ 'coc-yaml',
            \ 'coc-highlight',
            \ 'coc-snippets',
            \ 'coc-fsharp',
            \ 'coc-svg',
            \ 'coc-vimlsp',
            \ 'coc-xml',
            \ 'coc-markdownlint',
            \ ]

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup cocnvimgroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,java,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader><Space>  <Plug>(coc-codeaction)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList --number-select diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" }}}

" Omnisharp {{{
" Use the stdio OmniSharp-roslyn server
let g:OmniSharp_server_stdio = 1

" Set the type lookup function to use the preview window instead of echoing it
"let g:OmniSharp_typeLookupInPreview = 1

" Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 5
"
" Fetch full documentation during omnicomplete requests.
" By default, only Type/Method signatures are fetched. Full documentation can
" still be fetched when you need it with the :OmniSharpDocumentation command.
let g:omnicomplete_fetch_full_documentation = 1

" Update semantic highlighting on BufEnter, InsertLeave and TextChanged
let g:OmniSharp_highlight_types = 2

augroup omnisharp_commands
    autocmd!

    " Show type information automatically when the cursor stops moving.
    " Note that the type is echoed to the Vim command line, and will overwrite
    " any other messages in this space including e.g. ALE linting messages.
    autocmd CursorHold *.cs OmniSharpTypeLookup

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
    autocmd FileType cs nmap <silent> <buffer> <Leader>fu <Plug>(omnisharp_find_usages)
    autocmd FileType cs nmap <silent> <buffer> gr <Plug>(omnisharp_find_usages)
    autocmd FileType cs nmap <silent> <buffer> <Leader>fi <Plug>(omnisharp_find_implementations)
    autocmd FileType cs nmap <silent> <buffer> gi <Plug>(omnisharp_find_implementations)
    autocmd FileType cs nmap <silent> <buffer> <Leader>pd <Plug>(omnisharp_preview_definition)
    autocmd FileType cs nmap <silent> <buffer> <Leader>pi <Plug>(omnisharp_preview_implementations)
    autocmd FileType cs nmap <silent> <buffer> <Leader>tl <Plug>(omnisharp_type_lookup)
    autocmd FileType cs nmap <silent> <buffer> K <Plug>(omnisharp_documentation)
    autocmd FileType cs nmap <silent> <buffer> <Leader>fs <Plug>(omnisharp_find_symbol)
    autocmd FileType cs nmap <silent> <buffer> <Leader>fx <Plug>(omnisharp_fix_usings)
    autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
    autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

    " Navigate up and down by method/property/field
    autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
    autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
    " Find all code errors/warnings for the current solution and populate the quickfix window
    autocmd FileType cs nmap <silent> <buffer> <Leader>cc <Plug>(omnisharp_global_code_check)
    " Contextual code actions (uses fzf, CtrlP or unite.vim selector when available)
    autocmd FileType cs nmap <silent> <buffer> <Leader>ca <Plug>(omnisharp_code_actions)
    autocmd FileType cs nmap <silent> <buffer> <Leader><Space> <Plug>(omnisharp_code_actions)
    autocmd FileType cs xmap <silent> <buffer> <Leader>ca <Plug>(omnisharp_code_actions)
    autocmd FileType cs xmap <silent> <buffer> <Leader><Space> <Plug>(omnisharp_code_actions)
    " Repeat the last code action performed (does not use a selector)
    autocmd FileType cs nmap <silent> <buffer> <Leader>ca. <Plug>(omnisharp_code_action_repeat)
    autocmd FileType cs xmap <silent> <buffer> <Leader>ca. <Plug>(omnisharp_code_action_repeat)

    autocmd FileType cs nmap <silent> <buffer> <Leader>cf <Plug>(omnisharp_code_format)

    autocmd FileType cs nmap <silent> <buffer> <Leader>rn <Plug>(omnisharp_rename)

    autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
    autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
    autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END

" Enable snippet completion
let g:OmniSharp_want_snippet=1

" Diagnostic overrides
let g:OmniSharp_diagnostic_overrides = {
            \ 'CS1591': {'type': 'None'},
            \}
let g:OmniSharp_diagnostic_showid = 1
let g:OmniSharp_diagnostic_exclude_paths = [
            \ 'obj\\',
            \ '[Tt]emp\\',
            \ '\.nuget\\',
            \ '\<AssemblyInfo\.cs\>'
            \]
" }}}

" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'
" }}}
if s:is_win
    " Support for Powershell
    packadd! windows-powershell-syntax-plugin
endif
" }}}

silent! helptags ALL

finish " break here

" vim:ts=4:sw=4:ai:foldmethod=marker:foldlevel=0
