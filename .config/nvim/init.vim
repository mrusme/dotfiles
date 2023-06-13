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
"
" TODO: https://kinbiko.com/posts/2021-08-23-rewriting-vimrc-in-lua/
"
set nocompatible
filetype off


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Plugs                                                                      ║
" ╚════════════════════════════════════════════════════════════════════════════╝

call plug#begin('~/.local/share/nvim/plugged')

Plug 'editorconfig/editorconfig-vim'

Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'jose-elias-alvarez/null-ls.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"Plug 'lambdalisue/fern.vim'
"Plug 'lambdalisue/nerdfont.vim'
"Plug 'lambdalisue/fern-renderer-nerdfont.vim'
"Plug 'lambdalisue/fern-git-status.vim'
"Plug 'lambdalisue/fern-hijack.vim'
"Plug 'lambdalisue/fern-bookmark.vim'
"Plug 'lambdalisue/fern-mapping-git.vim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'ggandor/leap.nvim'
Plug 'ggandor/lightspeed.nvim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'numToStr/Comment.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'godlygeek/tabular'
Plug 'junegunn/goyo.vim'
Plug 'Yggdroot/indentLine'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'itchyny/lightline.vim'
Plug 'wfxr/minimap.vim'
Plug 'jamessan/vim-gnupg'
Plug 'robertbasic/vim-hugo-helper'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-abolish'
Plug 'lervag/wiki.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'simnalamburt/vim-mundo'
Plug 'kyazdani42/nvim-web-devicons'
" Plug 'folke/trouble.nvim'
Plug 'mhartington/formatter.nvim'
Plug 'folke/which-key.nvim'
" Plug 'RRethy/nvim-base16'
" Plug 'danilamihailov/beacon.nvim'

" Syntax / Language integrations
"Plug 'plasticboy/vim-markdown'
Plug 'leafgarland/typescript-vim'
Plug 'elixir-lang/vim-elixir'
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml', {'branch': 'main'}
Plug 'moll/vim-node'
Plug 'docker/docker'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'vim-scripts/dbext.vim'
Plug 'ledger/vim-ledger'
Plug 'chrisbra/Colorizer'

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

" Jeez, who even wants that ...
set mouse=

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

" 2 spaces tab, expand tabs to spaces
set tabstop=2 shiftwidth=2 expandtab

"set listchars=tab:▒░,trail:▓
set listchars=tab:⇥\ ,trail:˽,extends:→

set list

" set number relativenumber
set number

set hlsearch

" highlight the current line
set cursorline

" ignore case when searching ...
set ignorecase

" ... unless the search contains mixed case, then don't ignore
set smartcase

" begin scrolling x lines before bottom
set scrolloff=10

set hidden

set nobackup
set nowritebackup
set noswapfile
set fileformats=unix,dos,mac
set completeopt=menu,menuone,noselect
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,**/node_modules/**

set spelllang=en,ro,es,fr,de,cjk
set spellsuggest=best,9

if exists("+colorcolumn")
  set colorcolumn=80
endif

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
" Auto formatting per syntax
nnoremap <Leader>fj :%!python -m json.tool<CR>

let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<M-d>'
let g:VM_maps['Find Subword Under'] = '<M-d>'
let g:VM_maps["Select Cursor Down"] = '<M-C-Down>'
let g:VM_maps["Select Cursor Up"]   = '<M-C-Up>'

let g:tcomment#replacements_xml={}
let g:vim_markdown_folding_disabled = 1

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
    \ setlocal spell

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

if has('termguicolors')
  set termguicolors
endif
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif
set t_Co=256

colorscheme iceberg
" lua << EOF
" require('base16-colorscheme').setup({
"   base00 = '#161616',
"   base01 = '#262626',
"   base02 = '#393939',
"   base03 = '#525252',
"   base04 = '#6F6F6F',
"   base05 = '#FAFAFA',
"   base06 = '#FAFAFA',
"   base07 = '#FFFFFF',
"   base08 = '#be95ff',
"   base09 = '#3ddbd9',
"   base0A = '#0043ce',
"   base0B = '#33b1ff',
"   base0C = '#ff7eb6',
"   base0D = '#42be65',
"   base0E = '#be95ff',
"   base0F = '#3ddbd9',
" })
" EOF

" OVERRIDES
highlight Normal ctermbg=none guibg=none
highlight NonText ctermbg=none guibg=none
highlight ColorColumn cterm=reverse ctermbg=238 ctermfg=233 
  \ gui=reverse guibg=#3e445e guifg=#0f1117
highlight EndOfBuffer ctermbg=none guibg=none
highlight LineNr ctermbg=none guibg=none


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ indentLine                                                                 ║
" ╚════════════════════════════════════════════════════════════════════════════╝

let g:indentLine_enabled = 1
let g:indentLine_char = '⋮'
let g:indentLine_first_char = '⋮'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 1
let g:indentLine_setConceal = 0


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Neovide                                                                    ║
" ╚════════════════════════════════════════════════════════════════════════════╝

if exists("g:neovide")
  set guifont=FiraCode\ Nerd\ Font:h10
  let g:neovide_cursor_antialiasing=v:true
  ""let g:neovide_fullscreen=v:true
  let g:neovide_refresh_rate=60
  let g:neovide_refresh_rate_idle=5
  let g:neovide_keyboard_layout="qwerty"
  let g:neovide_cursor_animation_length=0.01
  let g:neovide_cursor_trail_length=0.2
  let g:neovide_transparency=0.9
endif


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Lightline                                                                  ║
" ╚════════════════════════════════════════════════════════════════════════════╝

let g:lightline = { 
  \ 'colorscheme': 'iceberg', 
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'readonly', 'filename', 'gitsign', 'modified' ] ],
  \   'right': [ 
  \     [ 'lineinfo' ], [ 'percent' ], 
  \     [ 'indent', 'textwidth', 'fileformat', 
  \       'fileencoding', 'filetype', 'branch' ] 
  \   ]
  \ },
  \ 'component': {
  \   'indent': '%{&expandtab?"spaces":"tabs"}:%{&expandtab?&shiftwidth:&tabstop}',
  \   'textwidth': '%{&textwidth}',
  \   'gitsign': '%{get(b:,"gitsigns_status","")}',
  \   'branch': '%{get(b:,"gitsigns_head","")}',
  \ },
  \ }
set noshowmode


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ nvim-tree                                                                  ║
" ╚════════════════════════════════════════════════════════════════════════════╝

lua <<EOF
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
EOF

noremap <silent> <Leader>d :NvimTreeToggle<CR>


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ EditorConfig                                                               ║
" ╚════════════════════════════════════════════════════════════════════════════╝

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_max_line_indicator = "line"
au FileType gitcommit let b:EditorConfig_disable = 1


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ GitSigns                                                                   ║
" ╚════════════════════════════════════════════════════════════════════════════╝

lua <<EOF
require('gitsigns').setup()
EOF


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ formatter                                                                  ║
" ╚════════════════════════════════════════════════════════════════════════════╝

lua <<EOF
-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    lua = {
      -- "formatter.filetypes.lua" defines default configurations for the
      -- "lua" filetype
      require("formatter.filetypes.lua").stylua,

      -- You can also define your own configuration
      function()
        -- Supports conditional formatting
        if util.get_current_buffer_file_name() == "special.lua" then
          return nil
        end

        -- Full specification of configurations is down below and in Vim help
        -- files
        return {
          exe = "stylua",
          args = {
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
          },
          stdin = true,
        }
      end
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}
EOF

nnoremap <silent> <leader>f :Format<CR>


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ rust.vim                                                                   ║
" ╚════════════════════════════════════════════════════════════════════════════╝

let g:rust_clip_command = 'wl-copy'


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ cmp                                                                        ║
" ╚════════════════════════════════════════════════════════════════════════════╝

lua <<EOF
  local cmp_autopairs = require'nvim-autopairs.completion.cmp'
  local cmp = require'cmp'
  local lspkind = require'lspkind'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<Tab>'] = (function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end),
      ['<S-Tab>'] = (function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    }),
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol',
        maxwidth = 50,
      })
    }
  })

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' },
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.filetype('markdown', {
    enabled = false
  })

  -- Use buffer source for `/` (if enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

  require('lspconfig')['gopls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['denols'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['elixirls'].setup {
    capabilities = capabilities;
    cmd = { "/home/mrus/projects/github/elixir-ls/release/language_server.sh" };
  }
  require('lspconfig')['pylsp'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['rls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['sorbet'].setup {
    capabilities = capabilities;
    cmd = { "bundle", "exec", "srb", "tc", "--lsp" };
  }
  require('lspconfig')['sqlls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['terraformls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['tflint'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['bashls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['cssls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['dockerls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['graphql'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['html'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['jsonls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['stylelint_lsp'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['svelte'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['vimls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['yamlls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['zls'].setup {
    capabilities = capabilities;
    cmd = { "/home/mrus/projects/github/zls/zig-out/bin/zls" };
  }
EOF

highlight link CompeDocumentation NormalFloat
highlight link CmpDocumentation NormalFloat


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ null-ls                                                                    ║
" ╚════════════════════════════════════════════════════════════════════════════╝

lua << EOF
require("null-ls").setup({
  sources = {
    require("null-ls").builtins.diagnostics.vale,
  },
})
EOF


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Treesitter                                                                 ║
" ╚════════════════════════════════════════════════════════════════════════════╝

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { 
    "bash",
    "c", 
    "cmake",
    "comment",
    "cpp",
    "css",
    "dockerfile",
    "eex",
    "elixir",
    "erlang",
    "go", 
    "gomod",
    "graphql",
    "haskell",
    "hcl",
    "html",
    "http",
    "javascript", 
    "json",
    "lua", 
    "make",
    "markdown",
    "nix",
    "regex",
    "ruby",
    "rust",
    "scss",
    "svelte",
    "toml",
    "typescript", 
    "vim",
    "yaml",
    "zig"
  },

  sync_install = false,
  ignore_install = {},

  highlight = {
    enable = true,
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Leap                                                                       ║
" ╚════════════════════════════════════════════════════════════════════════════╝
" Conflicts with a lot of mappings (e.g. x), needs further investigation
" lua require('leap').add_default_mappings()


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Telescope                                                                  ║
" ╚════════════════════════════════════════════════════════════════════════════╝

nnoremap <M-f> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <M-/> <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>lr <cmd>lua require('telescope.builtin').lsp_references()<cr>

nnoremap <M-o> <cmd>lua require('telescope.builtin').fd()<cr>
inoremap <M-o> <cmd>lua require('telescope.builtin').fd()<cr>

" nnoremap <M-f> <cmd>Telescope find_files<cr>
" nnoremap <M-/> <cmd>Telescope live_grep<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" nnoremap <leader>lr <cmd>Telescope lsp_references<cr>
" 
" nnoremap <M-o> <cmd>Telescope fd<CR>
" inoremap <M-o> <cmd>Telescope fd<CR>


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
let g:minimap_highlight_search = 1
let g:minimap_highlight_range = 1
let g:minimap_git_colors = 1

noremap <silent> <C-k><C-m> :MinimapToggle<CR>:MinimapRescan<CR>:MinimapRefresh<CR>


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ lexima                                                                     ║
" ╚════════════════════════════════════════════════════════════════════════════╝

let g:lexima_enable_basic_rules = 1
let g:lexima_enable_newline_rules = 1
let g:lexima_enable_endwise_rules = 1


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Mundo                                                                      ║
" ╚════════════════════════════════════════════════════════════════════════════╝

nnoremap <F5> :MundoToggle<CR>


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ GPG                                                                        ║
" ╚════════════════════════════════════════════════════════════════════════════╝

autocmd User GnuPG setl textwidth=72
let g:GPGFilePattern = '*.\(gpg\|asc\|pgp\)\(.wiki\|.md\)\='



" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ trouble.vim                                                                ║
" ╚════════════════════════════════════════════════════════════════════════════╝

"lua << EOF
"  require("trouble").setup {
"    position = "bottom", -- position of the list can be: bottom, top, left, right
"    height = 10, -- height of the trouble list when position is top or bottom
"    width = 50, -- width of the list when position is left or right
"    icons = true, -- use devicons for filenames
"    mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
"    fold_open = "", -- icon used for open folds
"    fold_closed = "", -- icon used for closed folds
"    group = true, -- group results by file
"    padding = true, -- add an extra new line on top of the list
"    action_keys = { -- key mappings for actions in the trouble list
"        -- map to {} to remove a mapping, for example:
"        -- close = {},
"        close = "q", -- close the list
"        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
"        refresh = "r", -- manually refresh
"        jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
"        open_split = { "<c-x>" }, -- open buffer in new split
"        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
"        open_tab = { "<c-t>" }, -- open buffer in new tab
"        jump_close = {"o"}, -- jump to the diagnostic and close the list
"        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
"        toggle_preview = "P", -- toggle auto_preview
"        hover = "K", -- opens a small popup with the full multiline message
"        preview = "p", -- preview the diagnostic location
"        close_folds = {"zM", "zm"}, -- close all folds
"        open_folds = {"zR", "zr"}, -- open all folds
"        toggle_fold = {"zA", "za"}, -- toggle fold of current file
"        previous = "k", -- preview item
"        next = "j" -- next item
"    },
"    indent_lines = true, -- add an indent guide below the fold icons
"    auto_open = true, -- automatically open the list when you have diagnostics
"    auto_close = false, -- automatically close the list when you have no diagnostics
"    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
"    auto_fold = false, -- automatically fold a file trouble list at creation
"    auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
"    signs = {
"        -- icons / text used for a diagnostic
"        error = "",
"        warning = "",
"        hint = "",
"        information = "",
"        other = "﫠"
"    },
"    use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
"  }
"EOF


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ HugoHelper                                                                 ║
" ╚════════════════════════════════════════════════════════════════════════════╝

let g:hugohelper_update_lastmod_on_write = 1


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Wiki.vim                                                                   ║
" ╚════════════════════════════════════════════════════════════════════════════╝

let g:wiki_root = '~/cloud/notes'
let g:wiki_filetypes = ['md']
let g:wiki_link_extension = '.md'
let g:wiki_link_target_type = 'md'


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ vim-go                                                                     ║
" ╚════════════════════════════════════════════════════════════════════════════╝

" let g:go_fmt_autosave=0
" let g:go_mod_fmt_autosave=0
" let g:go_imports_autosave = 0
" let g:go_asmfmt_autosave=0
" let g:go_def_mapping_enabled = 0
" au FileType go map <C-b> <Plug>(go-build)


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Svelte                                                                     ║
" ╚════════════════════════════════════════════════════════════════════════════╝

let g:svelte_indent_script = 0
let g:svelte_indent_style = 0


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Typescript                                                                 ║
" ╚════════════════════════════════════════════════════════════════════════════╝

let g:typescript_indent_disable = 1


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Dbext                                                                      ║
" ╚════════════════════════════════════════════════════════════════════════════╝

let g:dbext_default_menu_mode = 0


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Which Key                                                                  ║
" ╚════════════════════════════════════════════════════════════════════════════╝

lua << EOF
  require("which-key").setup {
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = { gc = "Comments" },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      -- ["<space>"] = "SPC",
      -- ["<cr>"] = "RET",
      -- ["<tab>"] = "TAB",
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = '<c-d>', -- binding to scroll down inside the popup
      scroll_up = '<c-u>', -- binding to scroll up inside the popup
    },
    window = {
      border = "none", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    },
  }
EOF


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Comment                                                                    ║
" ╚════════════════════════════════════════════════════════════════════════════╝

lua << EOF
require('Comment').setup({
  ---Add a space b/w comment and the line
  padding = true,
  ---Whether the cursor should stay at its position
  sticky = true,
  ---Lines to be ignored while (un)comment
  ignore = nil,
  ---LHS of toggle mappings in NORMAL mode
  toggler = {
    ---Line-comment toggle keymap
    line = 'gcc',
    ---Block-comment toggle keymap
    block = 'gbc',
  },
  ---LHS of operator-pending mappings in NORMAL and VISUAL mode
  opleader = {
    ---Line-comment keymap
    line = 'gc',
    ---Block-comment keymap
    block = 'gb',
  },
  ---LHS of extra mappings
  extra = {
    ---Add comment on the line above
    above = 'gcO',
    ---Add comment on the line below
    below = 'gco',
    ---Add comment at the end of line
    eol = 'gcA',
  },
  ---Enable keybindings
  mappings = {
    ---Operator-pending mapping; 
    ---`gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
    basic = true,
    ---Extra mapping; 
    ---`gco`, `gcO`, `gcA`
    extra = true,
    ---Extended mapping; 
    ---`g>` `g<` `g>[count]{motion}` `g<[count]{motion}`
    extended = false,
  },
  ---Function to call before (un)comment
  pre_hook = nil,
  ---Function to call after (un)comment
  post_hook = nil,
})
EOF
nmap <C-_><C-_> gcc
vmap <C-_><C-_> gc<Esc>


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Reader                                                                     ║
" ╚════════════════════════════════════════════════════════════════════════════╝

function s:vertopen_url()
  normal! "uyiW
  let mycommand = "reader " . @u
  execute "vertical terminal " . mycommand
endfunction
noremap <Plug>vertopen_url : call <SID>vertopen_url()<CR>
nmap gx <Plug>vertopen_url


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Custom commands                                                            ║
" ╚════════════════════════════════════════════════════════════════════════════╝

" Color picker
vnoremap <M-c> c<C-R>=system('yad --color --init-color' . shellescape(@"))<CR><ESC>
nnoremap <M-c> :put =system('yad --color')<CR>
inoremap <M-c> <ESC>:put =system('yad --color')<CR>


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Custom replacements                                                        ║
" ╚════════════════════════════════════════════════════════════════════════════╝

inoreabbrev mariusu マリウス
inoreabbrev mariusucom xn--gckvb8fzb.com

