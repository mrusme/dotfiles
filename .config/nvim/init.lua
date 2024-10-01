--[[
 ╔════════════════════════════════════════════════════════════════════════════╗
 ║                                                                            ║
 ║                           ██╗   ██╗██╗███╗   ███╗                          ║
 ║                           ██║   ██║██║████╗ ████║                          ║
 ║                           ██║   ██║██║██╔████╔██║                          ║
 ║                           ╚██╗ ██╔╝██║██║╚██╔╝██║                          ║
 ║                            ╚████╔╝ ██║██║ ╚═╝ ██║                          ║
 ║                             ╚═══╝  ╚═╝╚═╝     ╚═╝                          ║
 ║                                                                            ║
 ║      xn--gckvb8fzb.com * github.com/mrusme * marius@xn--gckvb8fzb.com      ║
 ║                                                                            ║
 ╚════════════════════════════════════════════════════════════════════════════╝
]]

require("config.lazy")

vim.cmd('filetype plugin indent on')
vim.cmd('filetype plugin on')

-- Jeez, who even wants that ...
vim.opt.mouse = ""

vim.opt.clipboard = {"unnamed", "unnamedplus"}

vim.opt.encoding = "utf-8"
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.backspace={"indent", "eol", "start"}
vim.opt.showmatch = true
vim.opt.showmode = true
vim.opt.smarttab = true
vim.opt.complete:remove{"i"}
vim.opt.nrformats:remove{"octal"}
vim.opt.shiftround = true
vim.opt.ttimeout = true
vim.opt.ttimeoutlen=50
vim.opt.timeoutlen=500

vim.opt.splitbelow = true

vim.opt.incsearch = true

vim.opt.laststatus=2
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.wildmenu =true

vim.opt.autoread = true

-- 2 spaces tab, expand tabs to spaces
vim.opt.tabstop = 2 
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2 
vim.opt.expandtab = true

-- vim.opt.listchars=tab:▒░,trail:▓
vim.opt.listchars:append{tab = "⇥ ", trail = "˽", extends = "→"}

vim.opt.list = true

-- vim.opt.number relativenumber
vim.opt.number = true

vim.opt.hlsearch = true

-- highlight the current line
vim.opt.cursorline = true

-- ignore case when searching ...
vim.opt.ignorecase = true

-- ... unless the search contains mixed case, then don't ignore
vim.opt.smartcase = true

-- begin scrolling x lines before bottom
vim.opt.scrolloff = 10

vim.opt.hidden = true

vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.fileformats = {"unix", "dos", "mac"}
vim.opt.completeopt = {"menu", "menuone", "noselect"}
vim.opt.wildignore:append{"*/.git/*", "*/.hg/*", "*/.svn/*", "**/node_modules/**"}

vim.opt.undofile = true
vim.opt.undodir = "~/.cache/nvim/undo"

vim.opt.colorcolumn = "80"

vim.opt.spelllang = {"en", "ro", "es", "fr", "de", "cjk"}
vim.opt.spellsuggest = {"best", 9}

vim.g.spellfile_URL = 'https://ftp.nluug.nl/vim/runtime/spell'


--[[
 ╔════════════════════════════════════════════════════════════════════════════╗
 ║ Neovide                                                                    ║
 ╚════════════════════════════════════════════════════════════════════════════╝
]]
if vim.g.neovide then
  vim.o.guifont = "Berkeley Mono:h11:#e-subpixelantialias"
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_keyboard_layout = "qwerty"
  vim.g.neovide_cursor_smooth_blink = true
  vim.g.neovide_cursor_animation_length = 0.01
  vim.g.neovide_cursor_trail_length = 0.2
  vim.g.neovide_transparency = 0.9
end

vim.cmd([[
" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Key mappings                                                               ║
" ╚════════════════════════════════════════════════════════════════════════════╝

if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

inoremap <C-U> <C-G>u<C-U>

noremap  <C-s> :update<CR>
vnoremap <C-s> <C-C>:update<CR>
inoremap <C-s> <Esc>:update<CR>

"inoremap <C-c> <Esc>

"map <C-f> /

vnoremap <Tab> >
vnoremap <S-Tab> <

"nnoremap <Tab> >0
"nnoremap <S-Tab> <0

vmap <C-m> gc

vmap <C-w> S

vmap <C-x> d
vmap <C-v> p
vmap <C-c> y

"nnoremap d "_d
"vnoremap d "_d

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
"let mapleader = ','

nnoremap <Leader>p :set paste<CR>
nnoremap <Leader>o :set nopaste<CR>

" Double press Ctrl+q to force quit, discarding changes
noremap <C-q><C-q> :qa!<CR>
inoremap <C-q><C-q> <Esc>:qa!<CR>

" Single press Ctrl+q to quit, get notified of changes
noremap <C-q> :qa<CR>
inoremap <C-q> <Esc>:qa<CR>

" Reformat current paragraph
noremap <Leader>` gq}<CR>
" Reformat everything to EOF
noremap <Leader>~ gqG<CR>


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Autocmd                                                                    ║
" ╚════════════════════════════════════════════════════════════════════════════╝

" save window position on exit
autocmd BufWinLeave
  \ *.* mkview

" restore window position
autocmd BufWinEnter
  \ *.* silent! loadview

" set markdown filetype
autocmd BufRead,BufNewFile
  \ *.md set filetype=markdown

" set textwidth=80 for types and enable spell
autocmd BufRead,BufNewFile
  \ *.{md,txt} 
    \ setlocal tw=80 | 
    \ setlocal colorcolumn=80 |
    \ setlocal fo=awqtc | 
    \ setlocal comments+=nb:> | 
    \ setlocal spell |
    \ setlocal tabstop=2 shiftwidth=2 expandtab

" set json filetyep
autocmd BufRead,BufNewFile
  \ .{jscs,jshint,eslint}rc set filetype=json

" set sh filetype
autocmd BufRead,BufNewFile
  \ aliases.local,zshrc.local,.zshrc,*/zsh/configs/* set filetype=sh

" set gitconfig filetyep
autocmd BufRead,BufNewFile
  \ gitconfig.local,.gitconfig set filetype=gitconfig

" set tmux filetype
autocmd BufRead,BufNewFile
  \ tmux.conf.local,tmux.conf,.tmux.conf set filetype=tmux

" set vim filetype
autocmd BufRead,BufNewFile
  \ vimrc.local,.vimrc,init.vim set filetype=vim

" set neomutt settings
autocmd BufRead,BufNewFile
  \ {neomutt-*,*.eml} 
    \ setlocal tw=72 | 
    \ setlocal colorcolumn=72 |
    \ setlocal fo=awq | 
    \ setlocal comments+=nb:> | 
    \ setlocal spell |
    \ match ErrorMsg '\s\+$'


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Theme                                                                      ║
" ╚════════════════════════════════════════════════════════════════════════════╝

" if has('termguicolors')
"   set termguicolors
" endif
" if (has('nvim'))
"   let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
" endif
" set t_Co=256

" OVERRIDES
" highlight Normal ctermbg=none guibg=none
" highlight NonText ctermbg=none guibg=none
" highlight ColorColumn cterm=reverse ctermbg=200 ctermfg=233 
"   \ gui=reverse guibg=#3e445e guifg=#0f1117
" highlight EndOfBuffer ctermbg=none guibg=none
" highlight LineNr ctermbg=none guibg=none


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ cmp                                                                        ║
" ╚════════════════════════════════════════════════════════════════════════════╝

highlight link CompeDocumentation NormalFloat
highlight link CmpDocumentation NormalFloat


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ neo-tree                                                                   ║
" ╚════════════════════════════════════════════════════════════════════════════╝

noremap <silent> <Leader>d :Neotree toggle<CR>


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ formatter                                                                  ║
" ╚════════════════════════════════════════════════════════════════════════════╝

nnoremap <silent> <leader>f :Format<CR>


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ GPG                                                                        ║
" ╚════════════════════════════════════════════════════════════════════════════╝

autocmd User GnuPG setl textwidth=72
let g:GPGFilePattern = '*.\(gpg\|asc\|pgp\)\(.wiki\|.md\)\='


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Comment                                                                    ║
" ╚════════════════════════════════════════════════════════════════════════════╝

nmap <C-/><C-/> gcc
vmap <C-/><C-/> gc<Esc>


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Reader                                                                     ║
" ╚════════════════════════════════════════════════════════════════════════════╝

function s:reader_url()
  normal! "uyiW
  let mycommand = "reader -o " . @u
  execute "new | r!" . mycommand
endfunction
noremap <Plug>reader_url : call <SID>reader_url()<CR>
nmap gx <Plug>reader_url


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Custom commands                                                            ║
" ╚════════════════════════════════════════════════════════════════════════════╝

" https://github.com/hyprwm/hyprpicker
nnoremap <M-c> :put =system('hyprpicker')<CR>
inoremap <M-c> <ESC>:put =system('hyprpicker')<CR>


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Custom replacements                                                        ║
" ╚════════════════════════════════════════════════════════════════════════════╝

inoreabbrev mariusu マリウス
inoreabbrev mariusucom xn--gckvb8fzb.com
]])
