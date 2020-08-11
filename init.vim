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

" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Plugs                                                                      ║
" ╚════════════════════════════════════════════════════════════════════════════╝

call plug#begin('~/.local/share/nvim/plugged')

Plug 'ayu-theme/ayu-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'leafgarland/typescript-vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
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

call plug#end()


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ NerdTree                                                                   ║
" ╚════════════════════════════════════════════════════════════════════════════╝

" Open NERDTree with vim
let sbv_open_nerdtree_to_start=1
" Open Nerd Panel with a new tab
let sbv_open_nerdtree_with_new_tab=1
" Enabled / Disabled placeholder chars
let sbv_display_placeholder=1
" Charactere placeholder for tabulation [2 char]
let sbv_tab_placeholder='»·'
" Charactere placeholder for space [1 char]
let sbv_space_placeholder='·'
" Enabled / Disabled space space for access in your vimrc
let sbv_quick_access_config=0
" Enabled / Disabled swap file
let sbv_swap_file=0
" Enabled / Disabled Shortcut
let sbv_smart_shortcut=1
" Indentation type [tab || space]
let sbv_indentation_type="space"
" Indentation length
let sbv_indentation_length=2
" Relative numbers
let sbv_enable_numbers=1


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Theme                                                                      ║
" ╚════════════════════════════════════════════════════════════════════════════╝

set termguicolors
" let ayucolor="dark"
colorscheme tech49

" function! ChangeColorscheme(scheme)
" 	let g:ayucolor=a:scheme
" 	colorscheme ayu
" endfunction

" map <C-v>.1 :call ChangeColorscheme("light")<CR>
" map <C-v>.2 :call ChangeColorscheme("mirage")<CR>
" map <C-v>.3 :call ChangeColorscheme("dark")<CR>

let g:indentLine_enabled = 1
let g:indentLine_char = '⋮'
let g:indentLine_first_char = '⋮'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 1
" let g:indentLine_color_term = 116
" let g:indentLine_bgcolor_term = 0

" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ NERDTree                                                                   ║
" ╚════════════════════════════════════════════════════════════════════════════╝
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * call s:actionForOpen(sbv_open_nerdtree_to_start)
function! s:actionForOpen(openNerdTree)
	let filename = expand('%:t')
	if !empty(a:openNerdTree)
		NERDTree
	endif
	if !empty(filename)
		wincmd l
	endif
endfunction
autocmd BufCreate * call s:addingNewTab(sbv_open_nerdtree_with_new_tab)
function! s:addingNewTab(openNerdTree)
	let filename = expand('%:t')
	if winnr('$') < 2 && exists('t:NERDTreeBufName') == 0
		if !empty(a:openNerdTree)
			NERDTree
		endif
		if !empty(filename)
			wincmd l
		endif
	endif
endfunction
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
function! s:CloseIfOnlyNerdTreeLeft()
	if exists("t:NERDTreeBufName")
		if bufwinnr(t:NERDTreeBufName) != -1
			if winnr("$") == 1
				q
			endif
		endif
	endif
endfunction
map <C-v><C-n> :NERDTreeToggle<CR>


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
" ║ Typescript                                                                 ║
" ╚════════════════════════════════════════════════════════════════════════════╝

" typescript-vim
let g:typescript_indent_disable = 1


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Various                                                                    ║
" ╚════════════════════════════════════════════════════════════════════════════╝

set encoding=utf-8
set number
set backspace=2
set showmatch
set showmode
syntax on
syntax enable
set clipboard=unnamed

map <C-v><C-c> :qa!<CR>
map <C-v><C-s> :w<CR>
map <C-v><C-S> :w!<CR>
map <C-v><C-q> :wq<CR>

map <C-v><Left> <C-W>h
map <C-v><Up> <C-W>j
map <C-v><Down> <C-W>k
map <C-v><Right> <C-W>l

let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-l>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_start_key='<C-L>'

let g:vim_markdown_folding_disabled = 1

autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md setlocal textwidth=80
autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
autocmd BufRead,BufNewFile aliases.local,zshrc.local,*/zsh/configs/* set filetype=sh
autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
autocmd BufRead,BufNewFile vimrc.local set filetype=vim

nnoremap <silent> <C-T> :Files<CR>

