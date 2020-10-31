" leader
let mapleader = " "
let maplocalleader = ";"

" pane navigation easier
map <leader>jj <C-w>j	
map <leader>kk <C-w>k
map <leader>hh <C-w>h
map <leader>ll <C-w>l
" map gwh :split<enter>
" map gwv :vsplit<enter>
map L $
map H 0

map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" Save recording macro to <s-q> and free q
nnoremap Q q
nnoremap q <Nop>

" easy save and/or quit
map q :q<ENTER>
map <Leader>q :q!<ENTER>
map <Leader>w :w!<ENTER>

" goyo enable
map <Leader>gy :Goyo<ENTER>

" Go to previous after following link
map <Leader>gp :b#<ENTER>

"Some commonly opened files
set splitright
map <Leader>es :UltiSnipsEdit<ENTER>
map <Leader>ec :vsplit ~/.config/nvim/init.vim<ENTER>
map <leader>eb :vsplit ~/dox/bibliography.bib<ENTER>

" Fugitive Git commands
map <localleader>gs :Gwrite<ENTER>  " s for stage
map <localleader>gd :Gvdiffsplit!<ENTER>  " Gdiff on a vertical split
map <localleader>gb :Git blame<ENTER>
map <localleader>gc :Git commit<ENTER>
map <localleader>go :Git checkout 
" To resolve conflict
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

""""""""""""""""""""""""
" General configuration
""""""""""""""""""""""""
set updatetime=100      " update time in ms for git changes(default:4s)
set mouse=a             " Mouse enabled for all modes
set tabstop =4		    " show tabstop as 4 spaces
set shiftwidth =4	    " autoindent size
set expandtab		    " insert 4 spaces on <tab>
filetype plugin on
set clipboard+=unnamedplus " Use system clipboard
set number              " Show line number
set relativenumber      " Count relative to line at cursor
set ignorecase          " Case insensitive search
set smartcase           " smart (case sensitivity) search
set inccommand=nosplit  " show incrementally effect of a command(eg. substitute)
set title titlelen=35   " Set the title of terminal
set titlestring=%t%(\ %M%)%(\ (%{expand(\'%:~:.:h\')})%)%(\ %a%)
set conceallevel=2      " Conceal things whenever available like md, tex
" Enable folding
set foldmethod=indent
set foldlevel=99


" Save undo history across sessions
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir
" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" Move cursor to the last left positionn
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif


"""""""""""""""""""""""""
" Vim-Plug Plugin Manager
"""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')

    " General
    Plug 'junegunn/goyo.vim'             " Distraction free writing
    Plug 'ryvnf/readline.vim'            " Readline shortcuts in command mode
    Plug 'tpope/vim-rsi'            " Readline shortcuts in command mode
    Plug 'tpope/vim-surround'            " Easily manipulate surrounding brackets/quotes
    Plug 'godlygeek/tabular'             " Tabularize things
    Plug 'vim-airline/vim-airline'       " Statusbar theme
    Plug 'jiangmiao/auto-pairs'          " One shouldn't have to worry about it
    Plug 'romainl/vim-cool'              " Turn off highlight after search
    Plug 'machakann/vim-highlightedyank' " Highlight the yanked portion
		let g:highlightedyank_highlight_duration = 200
    Plug 'scrooloose/nerdcommenter'      " Consider  tomtom/tcomment_vim 
		" Align line-wise comment delimiters flush left instead of following code indentation
		let g:NERDDefaultAlign = 'left'
		let g:NERDSpaceDelims = 1
		" Enable trimming of trailing whitespace when uncommenting
		let g:NERDTrimTrailingWhitespace = 1
		let g:NERDToggleCheckAllLines = 1
	Plug 'Shougo/deoplete.nvim'
		let g:deoplete#enable_at_startup = 1
        " Check this below for other completion sources
        " https://github.com/Shougo/deoplete.nvim/wiki/Completion-Sources
	Plug 'SirVer/ultisnips'
		let g:UltiSnipsExpandTrigger='<tab>'
		let g:UltiSnipsJumpForwardTrigger='<tab>'
		let g:UltiSnipsJumpBackwardTrigger='<s+tab>'
		" smap <S+tab> :call UltiSnips#JumpBackwards()<ENTER>
		let g:UltiSnipsSnippetDirectories=["UltiSnips"]
        let g:UltiSnipsEditSplit='vertical'
    " wal sets the colorscheme
    Plug 'dylanaraps/wal.vim'

    " Git plugin
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'   " indicate and work with hunks

    " async lint engine
    " proselint installed. check usage!
    " Plug 'dense-analysis/ale'
    " Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }

    " Python stuffs
    " Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
    Plug 'davidhalter/jedi-vim'     " to jump to code
        " disable autocompletion, cause we use deoplete for completion
        let g:jedi#completions_enabled = 0
        " open the go-to function in split, not another buffer
        let g:jedi#use_splits_not_buffers = "right"
    " Plug 'deoplete-plugins/deoplete-jedi'
    " Plug 'zchee/deoplete-jedi'
    " Plug 'neomake/neomake'

    " LATEX plugins below
    Plug 'lervag/vimtex'
    
	" C/C++ completion
	Plug 'Shougo/deoplete-clangx'

    " Code formatter
    Plug 'sbdchd/neoformat'

    " Filetype support
    Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
        let g:vim_markdown_math = 1
        let g:vim_markdown_frontmatter = 1
        let g:vim_markdown_strikethrough = 1
        let g:vim_markdown_no_extensions_in_markdown = 1
call plug#end()

" Telling deoplete to use vimtex as completion engine
call deoplete#custom#var('omni', 'input_patterns', {
        \ 'tex': g:vimtex#re#deoplete
        \})

" Disable custom warnings based on regexp
let g:vimtex_quickfix_ignore_filters = [
      \ 'Marginpar on page',
      \ 'Overfull',
      \ 'Empty bib'
      \]

" Plugin keybinds
" Comment toggle with C-/
" C-/ registers as C-_ for some reason
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>

" Format using Neoformat
" Neoformat checks for the right formatter backend depending on the file
" types. for latex, `latexindent` comes with texlive-core provides formatting.
" For python files it's `yapf` developed by Google open source. :h neoformat
nmap <leader>f :Neoformat<enter>

" Colorscheme wal (set by pywal)
colorscheme wal

" Highlight color of matching pairs look ugly
" This is set from colorscheme wal. overriding it here
" hi MatchParen cterm=bold ctermbg=1 ctermfg=8
hi MatchParen cterm=bold ctermbg=1 ctermfg=white
" Highlight yank region
hi HighlightedyankRegion cterm=reverse gui=reverse

let g:vimtex_view_method='zathura'
let g:vimtex_compiler_progname='nvr'
let g:tex_flavor='latex'
" let conceallevel=1
" let g:tex_conceal='abdmg'

" Autocmd's bufwrite hooks
au BufWritePost *dunstrc :silent !killall dunst ; dunst& disown 
au BufWritePost *init.vim :source %
au BufWinLeave *.config/directories :!generate_shortcuts
" autocmd BufNewFile *.tex itemplate<tab>
