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

Plug 'neovim/nvim-lspconfig'
Plug 'editorconfig/editorconfig-vim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-bookmark.vim'
Plug 'lambdalisue/fern-mapping-git.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'gcmt/breeze.vim'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
"Plug 'reedes/vim-pencil'
Plug 'wincent/command-t'
Plug 'junegunn/goyo.vim'
Plug 'Yggdroot/indentLine'
Plug 'terryma/vim-multiple-cursors'
Plug 'itchyny/lightline.vim'
Plug 'wfxr/minimap.vim'
Plug 'jamessan/vim-gnupg'
Plug 'glepnir/dashboard-nvim'
Plug 'robertbasic/vim-hugo-helper'
Plug 'cohama/lexima.vim'
"Plug 'vimwiki/vimwiki'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

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

set clipboard=unnamed,unnamedplus

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
set timeoutlen=500

set incsearch

set laststatus=2
set ruler
set showcmd
set wildmenu

set autoread

set tabstop=2 shiftwidth=2 expandtab
"set listchars=tab:▒░,trail:▓
set listchars=tab:\ \ ,trail:˽,extends:→
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

noremap  <C-s> :update<CR>
vnoremap <C-s> <C-C>:update<CR>
inoremap <C-s> <Esc>:update<CR>

"inoremap <C-c> <Esc>

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

"nnoremap d "_d
"vnoremap d "_d

nnoremap <silent> <C-\> :Files<CR>

nnoremap <C-z>  :undo<CR>
inoremap <C-z>  <Esc>:undo<CR>
nnoremap <C-y>  :redo<CR>
inoremap <C-y>  <Esc>:redo<CR>

inoremap <C-v>  <Esc>V

inoremap <C-a>  <Esc>ggVG
inoremap <M-C-m> <C-O>o

nnoremap <M-[>  :tabprevious<CR>
inoremap <M-[>  <Esc>:tabprevious<CR>i
nnoremap <M-]>  :tabnext<CR>
inoremap <M-]>  <Esc>:tabnext<CR>i
nnoremap <M-t>  :tabnew<CR>
inoremap <M-t>  <Esc>:tabnew<CR>i
nnoremap <M-w>  :tabclose<CR>
inoremap <M-w>  <Esc>:tabclose<CR>i

nnoremap <M-1>  :tabn 1<CR>
inoremap <M-1>  <Esc>:tabn 1<CR>i
nnoremap <M-2>  :tabn 2<CR>
inoremap <M-2>  <Esc>:tabn 2<CR>i
nnoremap <M-3>  :tabn 3<CR>
inoremap <M-3>  <Esc>:tabn 3<CR>i
nnoremap <M-4>  :tabn 4<CR>
inoremap <M-4>  <Esc>:tabn 4<CR>i
nnoremap <M-5>  :tabn 5<CR>
inoremap <M-5>  <Esc>:tabn 5<CR>i
nnoremap <M-6>  :tabn 6<CR>
inoremap <M-6>  <Esc>:tabn 6<CR>i
nnoremap <M-7>  :tabn 7<CR>
inoremap <M-7>  <Esc>:tabn 7<CR>i
nnoremap <M-8>  :tabn 8<CR>
inoremap <M-8>  <Esc>:tabn 8<CR>i
nnoremap <M-9>  :tabn 9<CR>
inoremap <M-9>  <Esc>:tabn 9<CR>i
nnoremap <M-0>  :tabn 10<CR>
inoremap <M-0>  <Esc>:tabn 10<CR>i

map \ :
let mapleader = ','
nnoremap <Leader>p :set paste<CR>
nnoremap <Leader>o :set nopaste<CR>
noremap  <Leader>g :GitGutterToggle<CR>

noremap <C-q><C-q> :qa!<CR>
inoremap <C-q><C-q> <Esc>:qa!<CR>
noremap <C-q> :qa<CR>
inoremap <C-q> <Esc>:qa<CR>

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
au FileType gitcommit let b:EditorConfig_disable = 1


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ rust.vim                                                                   ║
" ╚════════════════════════════════════════════════════════════════════════════╝
let g:rust_clip_command = 'wl-copy'


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ compe                                                                      ║
" ╚════════════════════════════════════════════════════════════════════════════╝
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true

let g:lexima_no_default_rules = v:true
call lexima#set_default_rules()
inoremap <silent><expr> <CR>      compe#confirm(lexima#expand('<LT>CR>', 'i'))
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

lua << EOF
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
       return true
    else
        return false
    end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm({ 'keys': '<CR>', 'select': v:true })", { expr = true })
EOF

highlight link CompeDocumentation NormalFloat

autocmd FileType markdown
  \ call compe#setup({'enabled': v:false}, 0)


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ LSP                                                                        ║
" ╚════════════════════════════════════════════════════════════════════════════╝
lua << EOF
require'lspconfig'.gopls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.denols.setup{}
require'lspconfig'.elixirls.setup{
    cmd = { "/home/mrus/projects/github/elixir-ls/release/language_server.sh" };
}
require'lspconfig'.pylsp.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.rls.setup{}
require'lspconfig'.sorbet.setup{}
require'lspconfig'.sqls.setup{}
require'lspconfig'.terraformls.setup{}
require'lspconfig'.tflint.setup{}

require'lspconfig'.bashls.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.graphql.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.stylelint_lsp.setup{}
require'lspconfig'.svelte.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.vimls.setup{}
require'lspconfig'.yamlls.setup{}
EOF


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ lspsaga                                                                    ║
" ╚════════════════════════════════════════════════════════════════════════════╝
nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>

nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>

nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>

nnoremap <silent>gr <cmd>lua require('lspsaga.rename').rename()<CR>

nnoremap <silent> gd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>

nnoremap <silent><leader>cc <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>
nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>

nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR> -- or open_float_terminal('lazygit')<CR>
tnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>

highlight link LspSagaFinderSelection Search


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Telescope                                                                  ║
" ╚════════════════════════════════════════════════════════════════════════════╝
nnoremap <M-f> <cmd>Telescope find_files<cr>
nnoremap <M-/> <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>lr <cmd>Telescope lsp_references<cr>

nnoremap <M-o> <cmd>Telescope fd<CR>
inoremap <M-o> <cmd>Telescope fd<CR>


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
au FileType go map <C-b> <Plug>(go-build)


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Typescript                                                                 ║
" ╚════════════════════════════════════════════════════════════════════════════╝
let g:typescript_indent_disable = 1

