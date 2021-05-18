" ╔════════════════════════════════════════════════════════════════════════════╗
" ║                                                                            ║
" ║                           ██╗   ██╗██╗███╗   ███╗                          ║
" ║                           ██║   ██║██║████╗ ████║                          ║
" ║                           ██║   ██║██║██╔████╔██║                          ║
" ║                           ╚██╗ ██╔╝██║██║╚██╔╝██║                          ║
" ║                            ╚████╔╝ ██║██║ ╚═╝ ██║                          ║
" ║                             ╚═══╝  ╚═╝╚═╝     ╚═╝                          ║
" ║                                                                            ║
" ║      xn--gckvb8fzb.com * github.com/mrusme * marius@xn--gckvb8fzb.com      ║
" ║                                                                            ║
" ╚════════════════════════════════════════════════════════════════════════════╝

set nocompatible
filetype off


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Plugs                                                                      ║
" ╚════════════════════════════════════════════════════════════════════════════╝

call plug#begin('~/.local/share/nvim/plugged')

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
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
"Plug 'reedes/vim-pencil'
Plug 'wincent/command-t'
Plug 'junegunn/goyo.vim'
Plug 'Yggdroot/indentLine'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'wfxr/minimap.vim'
Plug 'jamessan/vim-gnupg'
Plug 'glepnir/dashboard-nvim'
Plug 'robertbasic/vim-hugo-helper'
Plug 'cohama/lexima.vim'
"Plug 'vimwiki/vimwiki'

"Plug 'plasticboy/vim-markdown'
Plug 'leafgarland/typescript-vim'
Plug 'elixir-lang/vim-elixir'
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'moll/vim-node'
Plug 'docker/docker'

call plug#end()


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Configuration                                                              ║
" ╚════════════════════════════════════════════════════════════════════════════╝

filetype plugin indent on
filetype plugin on

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

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

inoremap <C-U> <C-G>u<C-U>

noremap  <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <Esc>:update<CR>

inoremap <C-c> <Esc>

map <C-f> /

vnoremap <Tab> >
vnoremap <S-Tab> <

nnoremap <Tab> >0
nnoremap <S-Tab> <0

vmap <C-m> gc

vmap <C-w> S

vmap <C-x> d
vmap <C-v> p
vmap <C-c> y

nnoremap d "_d
vnoremap d "_d

nnoremap <silent> <C-\> :Files<CR>

nnoremap <C-z>  :undo<CR>
inoremap <C-z>  <Esc>:undo<CR>
nnoremap <C-y>  :redo<CR>
inoremap <C-y>  <Esc>:redo<CR>

nnoremap <C-[>  :tabprevious<CR>
inoremap <C-[>  <Esc>:tabprevious<CR>i
nnoremap <C-]>  :tabnext<CR>
inoremap <C-]>  <Esc>:tabnext<CR>i
nnoremap <C-t>  :tabnew<CR>
inoremap <C-t>  <Esc>:tabnew<CR>i
nnoremap <C-x>  :tabclose<CR>
inoremap <C-x>  <Esc>:tabclose<CR>i

map \ :
let mapleader = ','
nnoremap <Leader>p :set paste<CR>
nnoremap <Leader>o :set nopaste<CR>
noremap  <Leader>g :GitGutterToggle<CR>

noremap <C-q> :qa!<CR>

let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-l>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_start_key='<C-L>'

let g:tcomment#replacements_xml={}
let g:vim_markdown_folding_disabled = 1

autocmd BufRead,BufNewFile
  \ *.md set filetype=markdown
autocmd BufRead,BufNewFile
  \ *.{md,txt} setlocal textwidth=80
autocmd BufRead,BufNewFile
  \ .{jscs,jshint,eslint}rc set filetype=json
autocmd BufRead,BufNewFile
  \ aliases.local,zshrc.local,.zshrc,*/zsh/configs/* set filetype=sh
autocmd BufRead,BufNewFile
  \ gitconfig.local,.gitconfig set filetype=gitconfig
autocmd BufRead,BufNewFile
  \ tmux.conf.local,tmux.conf,.tmux.conf set filetype=tmux
autocmd BufRead,BufNewFile
  \ vimrc.local,.vimrc,init.vim set filetype=vim


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Theme                                                                      ║
" ╚════════════════════════════════════════════════════════════════════════════╝

if has('termguicolors')
  set termguicolors
endif
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif
set t_Co=256

colorscheme vap0r
let g:lightline = { 'colorscheme': 'vap0r' }

let g:indentLine_enabled = 1
let g:indentLine_char = '⋮'
let g:indentLine_first_char = '⋮'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 1
let g:indentLine_setConceal = 0
let g:indentLine_fileTypeExclude = ['dashboard']

" OVERRIDES
highlight Normal ctermbg=none
highlight Normal guibg=none
highlight NonText ctermbg=none
highlight NonText guibg=none
highlight EndOfBuffer ctermbg=none guibg=none
highlight LineNr ctermbg=none guibg=none


set guifont=FiraCode\ Nerd\ Font:h13
let g:neovide_cursor_antialiasing=v:true
""let g:neovide_fullscreen=v:true
let g:neovide_refresh_rate=60
let g:neovide_keyboard_layout="qwerty"


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Neovide                                                                    ║
" ╚════════════════════════════════════════════════════════════════════════════╝

let g:neovide_cursor_animation_length=0.01
let g:neovide_cursor_trail_length=0.2


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

let g:fern#disable_default_mappings   = 0
let g:fern#disable_drawer_auto_quit   = 0
let g:fern#disable_viewer_hide_cursor = 1

noremap <silent> <C-k><C-b> :Fern . -drawer -width=35 -toggle<CR>
noremap <silent> <Leader>d :Fern . -drawer -width=35 -toggle<CR>
noremap <silent> <Leader>f :Fern . -drawer -reveal=% -width=35<CR>
noremap <silent> <Leader>. :Fern %:h -drawer -width=35<CR>

noremap <silent> <C-k><C-B> :Fern bookmark:/// -drawer -width=35 -toggle<CR>
noremap <silent> <Leader>b :Fern bookmark:/// -drawer -width=35 -toggle<CR>

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
" ║ EditorConfig                                                               ║
" ╚════════════════════════════════════════════════════════════════════════════╝
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ rust.vim                                                                   ║
" ╚════════════════════════════════════════════════════════════════════════════╝
let g:rust_clip_command = 'pbcopy'


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Ale                                                                        ║
" ╚════════════════════════════════════════════════════════════════════════════╝
let g:ale_linters_explicit = 1
let g:ale_linters = {
  \ 'asm':        ['gcc'],
  \ 'c':          ['clang', 'clang-format', 'clangcheck', 'clangd',
  \                'clang-tidy', 'gcc'],
  \ 'cpp':        ['clang', 'clang-format', 'clangcheck', 'clangd',
  \                'clang-tidy', 'gcc'],
  \ 'css':        ['prettier', 'stylelint'],
  \ 'dockerfile': ['hadolint'],
  \ 'elixir':     ['elixir-ls', 'mix', 'credo'],
  \ 'erlang':     ['dialyzer', 'erlc'],
  \ 'go':         ['golangci-lint', 'golint', 'gofmt'],
  \ 'haskell':    ['ghc', 'stack-build'],
  \ 'hcl':        ['terraform-fmt'],
  \ 'html':       ['alex', 'prettier'],
  \ 'javascript': ['prettier'],
  \ 'json':       ['prettier', 'spectral', 'jq'],
  \ 'latex':      ['alex', 'textlint'],
  \ 'less':       ['prettier', 'stylelint'],
  \ 'llvm':       ['llc'],
  \ 'lua':        ['luac'],
  \ 'mail':       ['alex'],
  \ 'make':       ['checkmake'],
  \ 'markdown':   ['prettier', 'alex', 'markdownlint', 'remark-lint',
  \                'textlint'],
  \ 'openapi':    ['prettier'],
  \ 'python':     ['pyls'],
  \ 'ruby':       ['prettier', 'ruby'],
  \ 'rust':       ['rustc', 'analyzer', 'rustfmt'],
  \ 'sass':       ['stylelint'],
  \ 'scss':       ['prettier', 'stylelint'],
  \ 'sh':         ['shellcheck'],
  \ 'sql':        ['sqlint'],
  \ 'svelte':     ['prettier'],
  \ 'terraform':  ['terraform', 'terraform-lsp', 'tflint'],
  \ 'typescript': ['prettier', 'deno', 'tslint'],
  \ 'vim':        ['vimls'],
  \ 'vue':        ['prettier'],
  \ 'yaml':       ['prettier', 'spectral']
\}

let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_set_signs = 1
let g:ale_set_highlights = 1

let g:ale_open_list = 0
let g:ale_list_window_size = 3
let g:ale_keep_list_window_open = 0
" let g:ale_list_vertical = 1
" let g:ale_set_loclist = 0
let g:ale_sign_error = '●'
let g:ale_sign_warning = '·'

nmap <silent> <C-e> <Plug>(ale_next_wrap)

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_warnings = l:counts.total - l:all_errors

    let l:errors_recap =
      \ l:all_errors == 0 ? '' : printf('%d⨉ ', all_errors)
    let l:warnings_recap =
      \ l:all_warnings == 0 ? '' : printf('%d⚠ ', all_warnings)
    return (errors_recap . warnings_recap)
endfunction

set statusline+=%=
set statusline+=\ %{LinterStatus()}
let g:ale_enabled = 1


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Deoplete                                                                   ║
" ╚════════════════════════════════════════════════════════════════════════════╝
let g:deoplete#enable_at_startup = 1
let b:deoplete_ignore_sources = ['buffer']

autocmd FileType markdown
  \ call deoplete#custom#buffer_option('auto_complete', v:false)

call deoplete#custom#option('sources', {'_': ['ale']})


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Pencil                                                                     ║
" ╚════════════════════════════════════════════════════════════════════════════╝
"augroup pencil
"  autocmd!
"  autocmd FileType markdown,mkd call pencil#init({
"    \ 'wrap': 'hard', 'autoformat': 1})
"  autocmd FileType text         call pencil#init({
"    \ 'wrap': 'hard', 'autoformat': 1})
"augroup END

"let g:pencil#textwidth = 80
"let g:pencil#cursorwrap = 1


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Minimap                                                                    ║
" ╚════════════════════════════════════════════════════════════════════════════╝
let g:minimap_width = 10
let g:minimap_auto_start = 0
let g:minimap_auto_start_win_enter = 0
let g:minimap_block_filetypes = ['fern', 'fugitive', 'nerdtree', 'tagbar' ]
let g:minimap_block_buftypes = [
\'fern', 'nofile', 'nowrite', 'quickfix', 'terminal', 'prompt'
\]

noremap <silent> <C-k><C-m> :MinimapToggle<CR>


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Vimwiki                                                                    ║
" ╚════════════════════════════════════════════════════════════════════════════╝
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [
  \{ 'path': '~/Cloud/Notes', 'path_html': '~/Cloud/Notes/.export',
  \  'syntax': 'markdown', 'ext': '.md' }
\]


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ GPG                                                                        ║
" ╚════════════════════════════════════════════════════════════════════════════╝
autocmd User GnuPG setl textwidth=72
let g:GPGFilePattern = '*.\(gpg\|asc\|pgp\)\(.wiki\|.md\)\='


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Dashboard                                                                  ║
" ╚════════════════════════════════════════════════════════════════════════════╝
let g:dashboard_default_executive ='fzf'
let g:dashboard_preview_command = 'cat'
"let g:dashboard_preview_pipeline = 'lolcat'
let g:dashboard_preview_file = '~/.config/nvim/motd'
let g:dashboard_preview_file_width = 80
let g:dashboard_preview_file_height = 33
let g:dashboard_custom_section = {
\ 'a': {'description': [
        \ ' New file                              SPC n f'
      \ ], 'command': 'DashboardNewFile'},
\ 'b': {'description': [
        \ ' Recent files                          SPC r f'
      \ ], 'command': 'DashboardFindHistory'},
\ 'c': {'description': [
        \ ' Find file                             SPC f f'
      \ ], 'command': 'DashboardFindFile'},
\ 'd': {'description': [
        \ 'ﰍ Find word                             SPC f w'
      \ ], 'command': 'DashboardFindWord'},
\ }
let g:dashboard_custom_footer = ['']


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ HugoHelper                                                                 ║
" ╚════════════════════════════════════════════════════════════════════════════╝
let g:hugohelper_update_lastmod_on_write = 1



" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Go                                                                         ║
" ╚════════════════════════════════════════════════════════════════════════════╝
let g:go_def_mapping_enabled = 0


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Typescript                                                                 ║
" ╚════════════════════════════════════════════════════════════════════════════╝

" typescript-vim
let g:typescript_indent_disable = 1
