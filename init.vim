" ╔════════════════════════════════════════════════════════════════════════════╗
" ║                                                                            ║
" ║                           ██╗   ██╗██╗███╗   ███╗                          ║
" ║                           ██║   ██║██║████╗ ████║                          ║
" ║                           ██║   ██║██║██╔████╔██║                          ║
" ║                           ╚██╗ ██╔╝██║██║╚██╔╝██║                          ║
" ║                            ╚████╔╝ ██║██║ ╚═╝ ██║                          ║
" ║                             ╚═══╝  ╚═╝╚═╝     ╚═╝                          ║
" ║                                                                            ║
" ║         * github.com/mrusme * twitter.com/mrusme * mrus@mrus.me *          ║
" ║                                                                            ║
" ╚════════════════════════════════════════════════════════════════════════════╝

set nocompatible
filetype off


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Plugs                                                                      ║
" ╚════════════════════════════════════════════════════════════════════════════╝

call plug#begin('~/.local/share/nvim/plugged')

"Plug 'ayu-theme/ayu-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-bookmark.vim'
Plug 'lambdalisue/fern-mapping-git.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'tpope/vim-surround'
Plug 'gcmt/breeze.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tomtom/tcomment_vim'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
"Plug 'Valloric/YouCompleteMe'
Plug 'godlygeek/tabular'
Plug 'leafgarland/typescript-vim'
"Plug 'plasticboy/vim-markdown'
"Plug 'reedes/vim-pencil'
Plug 'elixir-lang/vim-elixir'
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'docker/docker'
Plug 'moll/vim-node'
Plug 'heavenshell/vim-syntax-flowtype'
Plug 'wincent/command-t'
Plug 'junegunn/goyo.vim'
Plug 'Yggdroot/indentLine'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'cocopon/iceberg.vim'
Plug 'wfxr/minimap.vim'

call plug#end()


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Configuration                                                              ║
" ╚════════════════════════════════════════════════════════════════════════════╝

filetype plugin indent on
filetype plugin on


""""""""
if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

set clipboard=unnamed

set encoding=utf-8
set autoindent
set number
set backspace=indent,eol,start
set showmatch
set showmode
set smarttab
set complete-=i
set nrformats-=octal
set shiftround
set ttimeout
set ttimeoutlen=50

set incsearch

set laststatus=2
set ruler
set showcmd
set wildmenu

set autoread

set tabstop=2 shiftwidth=2 expandtab
set listchars=tab:▒░,trail:▓
set list

set number
set hlsearch
set ignorecase
set smartcase

map Q gq

set hidden

set nobackup
set nowritebackup
set noswapfile
set fileformats=unix,dos,mac
set completeopt=menuone,longest,preview
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

inoremap <C-U> <C-G>u<C-U>

noremap  <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <Esc>:update<CR>

inoremap <C-c> <Esc>

map <C-f> /

vnoremap <Tab> >
vnoremap <S-Tab> <

vmap <C-m> gc

vmap <C-w> S

vmap <C-x> d
vmap <C-v> p
vmap <C-c> y

nnoremap <C-z>  :undo<CR>
inoremap <C-z>  <Esc>:undo<CR>
nnoremap <C-y>  :redo<CR>
inoremap <C-y>  <Esc>:redo<CR>

nnoremap <C-b>  :tabprevious<CR>
inoremap <C-b>  <Esc>:tabprevious<CR>i
nnoremap <C-n>  :tabnext<CR>
inoremap <C-n>  <Esc>:tabnext<CR>i
nnoremap <C-t>  :tabnew<CR>
inoremap <C-t>  <Esc>:tabnew<CR>i
nnoremap <C-k>  :tabclose<CR>
inoremap <C-k>  <Esc>:tabclose<CR>i

map \ :
let mapleader = ','
nnoremap <Leader>p :set paste<CR>
nnoremap <Leader>o :set nopaste<CR>
noremap  <Leader>g :GitGutterToggle<CR>

" map <C-v><C-c> :qa!<CR>
" map <C-v><C-s> :w<CR>
" map <C-v><C-S> :w!<CR>
" map <C-v><C-q> :wq<CR>
"
" map <C-v><Left> <C-W>h
" map <C-v><Up> <C-W>j
" map <C-v><Down> <C-W>k
" map <C-v><Right> <C-W>l

let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-l>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_start_key='<C-L>'

let g:tcomment#replacements_xml={}
let g:vim_markdown_folding_disabled = 1

autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md setlocal textwidth=80
autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
autocmd BufRead,BufNewFile aliases.local,zshrc.local,*/zsh/configs/* set filetype=sh
autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
autocmd BufRead,BufNewFile vimrc.local set filetype=vim

nnoremap <silent> <C-T> :Files<CR>


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Theme                                                                      ║
" ╚════════════════════════════════════════════════════════════════════════════╝

set termguicolors
colorscheme iceberg

let g:lightline = { 'colorscheme': 'iceberg' }

let g:indentLine_enabled = 1
let g:indentLine_char = '⋮'
let g:indentLine_first_char = '⋮'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 1

" OVERRIDES
highlight Normal ctermbg=none
highlight Normal guibg=none
highlight NonText ctermbg=none
highlight NonText guibg=none
highlight EndOfBuffer ctermbg=none guibg=none
highlight LineNr ctermbg=none guibg=none


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Fern                                                                       ║
" ╚════════════════════════════════════════════════════════════════════════════╝

" fern-renderer-nerdfont
let g:fern#renderer = "nerdfont"

" fern-git-status
" Disable listing ignored files/directories
let g:fern_git_status#disable_ignored = 0
" Disable listing untracked files
let g:fern_git_status#disable_untracked = 0
" Disable listing status of submodules
let g:fern_git_status#disable_submodules = 0
" Disable listing status of directories
let g:fern_git_status#disable_directories = 0

" glyph-palette
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

let g:fern#disable_default_mappings   = 1
let g:fern#disable_drawer_auto_quit   = 1
let g:fern#disable_viewer_hide_cursor = 1

noremap <silent> <Leader>d :Fern . -drawer -width=35 -toggle<CR><C-w>=
noremap <silent> <Leader>f :Fern . -drawer -reveal=% -width=35<CR><C-w>=
noremap <silent> <Leader>. :Fern %:h -drawer -width=35<CR><C-w>=

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> m <Plug>(fern-action-mark:toggle)j
  nmap <buffer> N <Plug>(fern-action-new-file)
  nmap <buffer> K <Plug>(fern-action-new-dir)
  nmap <buffer> D <Plug>(fern-action-remove)
  nmap <buffer> V <Plug>(fern-action-move)
  nmap <buffer> R <Plug>(fern-action-rename)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> <nowait> d <Plug>(fern-action-hidden:toggle)
  nmap <buffer> <nowait> < <Plug>(fern-action-leave)
  nmap <buffer> <nowait> > <Plug>(fern-action-enter)
endfunction

augroup FernEvents
  autocmd!
  autocmd FileType fern call FernInit()
augroup END


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Deoplete                                                                   ║
" ╚════════════════════════════════════════════════════════════════════════════╝
let g:deoplete#enable_at_startup = 1
let b:deoplete_ignore_sources = ['buffer']
autocmd FileType markdown
  \ call deoplete#custom#buffer_option('auto_complete', v:false)


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Pencil                                                                     ║
" ╚════════════════════════════════════════════════════════════════════════════╝
"augroup pencil
"  autocmd!
"  autocmd FileType markdown,mkd call pencil#init({'wrap': 'hard', 'autoformat': 1})
"  autocmd FileType text         call pencil#init({'wrap': 'hard', 'autoformat': 1})
"augroup END

"let g:pencil#textwidth = 80
"let g:pencil#cursorwrap = 1

" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Syntastic                                                                  ║
" ╚════════════════════════════════════════════════════════════════════════════╝
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Minimap                                                                    ║
" ╚════════════════════════════════════════════════════════════════════════════╝
let g:minimap_width = 10
let g:minimap_auto_start = 0
let g:minimap_auto_start_win_enter = 0

" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Typescript                                                                 ║
" ╚════════════════════════════════════════════════════════════════════════════╝

" typescript-vim
let g:typescript_indent_disable = 1
