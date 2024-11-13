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
    let g:coc_config_home=split(&runtimepath, ',')[0]

    " There is no jobs support on Windows
    nmap <C-z> <Nop>
endif

" A defaults theme to allow theming in terminal application instead
colorscheme dim
    
" Basic settings {{{
set autoindent              " Indent according to previous line.
set expandtab               " Use spaces instead of tabs.
set tabstop     =4          " Spaces per tab
set softtabstop =4          " Tab key indents by 4 spaces.
set shiftwidth  =4          " >> indents by 4 spaces.
set shiftround              " >> indents to next multiple of 'shiftwidth'.

set hidden                  " Switch between buffers without having to save first.
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
set synmaxcol   =2048        " Only highlight the first 200 columns.
set termguicolors

set list                    " Show non-printable characters.

set number                  " Include the line number column
set cpoptions   +=n         " Wrapped lines use line number column; example->--------------------------------------------------------------------------------------------------------------------------->

set foldenable              " Enable folding
set foldlevelstart=5        " Open folds to this level for new buffer
set foldnestmax=10          " 10 nested fold max

set noshowmatch             " Showmatch significantly slows down omnicomplete when the first match contains parentheses.
set belloff=all             " Turn off bell for listed events

if has('textprop')
    set completeopt=longest,menuone,preview,popuphidden
    set completepopup=highlight:Pmenu,border:off
else
    set completeopt=longest,menuone,preview
    set previewheight=5
endif

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

" Vimspector {{{
let g:vimspector_enable_mappings = 'HUMAN'
" }}}

" FZF Subversion Files {{{
command! -bang -nargs=* SvnFiles
  \ call fzf#vim#grep(
  \   'svn ls --depth=infinity'.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
" }}}

" lsp {{{

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

if has('vim9script')
packadd lsp

if executable('jdtls')
    if !empty($LOMBOK_JAR)
        let lombok_arg = '--jvm-arg=-javaagent:' . $LOMBOK_JAR
    else
        let lombok_arg = ''
    endif

    call LspAddServer([#{
            \ name: 'Eclipse JDT Language Server',
            \ filetype: 'java',
            \ path: 'jdtls',
            \ args: [
            \   '--validate-java-version',
            \   '--jvm-arg=-Dlog.level=ALL',
            \   '--jvm-arg=-Dlog.protocol=true',
            \   lombok_arg,
            \   '-data ' . getcwd(),
            \ ],
            \ }])
endif

if executable('typescript-language-server')
    call LspAddServer([#{
            \ name: 'Typescript Language Server',
            \ filetype: ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'],
            \ path: 'typescript-language-server',
            \ args: ['--stdio'],
            \ }])
endif

if executable('yaml-language-server')
    call LspAddServer([#{
            \ name: 'Yaml Language Server',
            \ filetype: 'yaml',
            \ path: 'yaml-language-server',
            \ args: ['--stdio'],
            \ }])
endif

if executable('sql-language-server')
    call LspAddServer([#{
            \ name: 'SQL Language Server',
            \ filetype: 'sql',
            \ path: 'sql-language-server',
            \ args: ['up', '--method=stdio'],
            \ }])
endif

if executable('lua-language-server')
    call LspAddServer([#{
            \ name: 'Lua Language Server',
            \ filetype: 'lua',
            \ path: 'lua-language-server',
            \ args: [],
            \ }])
endif

" Gotos
nmap <silent> gd :<C-u>LspGotoDefinition<CR>
nmap <leader>gc  :<C-u>LspGotoDeclaration<CR>
nmap <leader>gi  :<C-u>LspGotoImpl<CR>
nmap <leader>gy  :<C-u>LspGotoTypeDef<CR>
nmap <leader>gr  :<C-u>LspShowReferences<CR>
nmap <leader>go  :<C-u>LspOutline<CR>

" Peeks
nmap <leader>pd  :<C-u>LspPeekDefinition<CR>
nmap <leader>pc  :<C-u>LspPeekDeclaration<CR>
nmap <leader>pi  :<C-u>LspPeekImpl<CR>
nmap <leader>py  :<C-u>LspPeekTypeDef<CR>
nmap <leader>pr  :<C-u>LspPeekReferences<CR>
nmap <leader>po  :<C-u>LspDocumentSymbol<CR>
nmap <silent> K :<C-u>LspHover<CR>

xmap <leader>a  :<C-u>LspCodeAction<CR>
nmap <leader>a  :<C-u>LspCodeAction<CR>
xmap <leader>c  :<C-u>LspCodeLens<CR>
nmap <leader>c  :<C-u>LspCodeLens<CR>

nmap <leader>rn  :<C-u>LspRename<CR>

nnoremap <silent><nowait> <space>a  :<C-u>LspDiag show<cr>

endif
" }}}

" }}}

silent! helptags ALL

finish " break here

" vim:ts=4:sw=4:ai:foldmethod=marker:foldlevel=0
