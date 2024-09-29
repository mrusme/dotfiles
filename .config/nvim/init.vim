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

Plug 'nvim-tree/nvim-tree.lua'
Plug 'ggandor/leap.nvim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'numToStr/Comment.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Plug 'wfxr/minimap.vim'
Plug 'jamessan/vim-gnupg'
Plug 'mrusme/vim-hugo-helper'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-abolish'
Plug 'nvim-lua/plenary.nvim'
Plug 'folke/trouble.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'debugloop/telescope-undo.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'mhartington/formatter.nvim'
Plug 'folke/which-key.nvim'

" Syntax / Language integrations

" Plug 'leafgarland/typescript-vim'
Plug 'elixir-lang/vim-elixir'
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml', {'branch': 'main'}
" Plug 'moll/vim-node'
Plug 'docker/docker'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
" Plug 'vim-scripts/dbext.vim'
Plug 'ledger/vim-ledger'
Plug 'chrisbra/Colorizer'
Plug 'Glench/Vim-Jinja2-Syntax'


" ---------------- TODO --------------------

" Plug 'ibhagwan/fzf-lua'
" Plug 'frankroeder/parrot.nvim'

" Plug 'stevearc/dressing.nvim'
" Plug 'MunifTanjim/nui.nvim'
" Plug 'HakonHarnes/img-clip.nvim'
" Plug 'echasnovski/mini.nvim'
" Plug 'MeanderingProgrammer/render-markdown.nvim'
" Plug 'zbirenbaum/copilot.lua'
" Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make', 'on': 'AvanteAsk' }

" ------------------------------------------

" Colorscheme
Plug 'maxmx03/fluoromachine.nvim'

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

set splitbelow

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

set undofile 
set undodir=~/.cache/nvim/undo

set spelllang=en,ro,es,fr,de,cjk
set spellsuggest=best,9
let g:spellfile_URL = 'https://ftp.nluug.nl/vim/runtime/spell'

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

if has('termguicolors')
  set termguicolors
endif
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif
set t_Co=256

lua << EOF
require('fluoromachine').setup({
  glow = true,
  brightness = 0.05,
  theme = 'retrowave',
  transparent = true,
  overrides = {
    ['@type'] = { italic = false, bold = false },
    ['@function'] = { italic = false, bold = false },
    ['@comment'] = { italic = false, bold = false },
    ['@keyword'] = { italic = false, bold = false },
    ['@constant'] = { italic = false, bold = false },
    ['@variable'] = { italic = false, bold = false },
    ['@field'] = { italic = false, bold = false },
    ['@parameter'] = { italic = false, bold = false },
    ['@number'] = { italic = false, bold = false },
  }
})
EOF
colorscheme fluoromachine

" OVERRIDES
" highlight Normal ctermbg=none guibg=none
" highlight NonText ctermbg=none guibg=none
" highlight ColorColumn cterm=reverse ctermbg=200 ctermfg=233 
"   \ gui=reverse guibg=#3e445e guifg=#0f1117
" highlight EndOfBuffer ctermbg=none guibg=none
" highlight LineNr ctermbg=none guibg=none


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Neovide                                                                    ║
" ╚════════════════════════════════════════════════════════════════════════════╝

if exists("g:neovide")
  set guifont=Berkeley\ Mono:h11:#e-subpixelantialias
  let g:neovide_cursor_antialiasing=v:true
  ""let g:neovide_fullscreen=v:true
  let g:neovide_scale_factor = 1.0
  let g:neovide_refresh_rate=144
  let g:neovide_refresh_rate_idle=5
  let g:neovide_keyboard_layout="qwerty"
  let g:neovide_cursor_smooth_blink = v:true
  let g:neovide_cursor_animation_length=0.01
  let g:neovide_cursor_trail_length=0.2
  let g:neovide_transparency=0.9
endif


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Lualine                                                                    ║
" ╚════════════════════════════════════════════════════════════════════════════╝

lua <<EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'%{&expandtab?"spaces":"tabs"}:%{&expandtab?&shiftwidth:&tabstop}', '%{&textwidth}', 'fileformat', 'encoding', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
EOF


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ nvim-tree                                                                  ║
" ╚════════════════════════════════════════════════════════════════════════════╝

lua <<EOF
-- TODO: Disable following two lines to download spell files
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
require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = false,
  numhl      = true,
  linehl     = false,
  word_diff  = false,
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = '[<author> <author_time:%Y-%m-%d>] <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}
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
  -- require('lspconfig')['elixirls'].setup {
  --   capabilities = capabilities;
  --   cmd = { "/home/mrus/projects/github/elixir-ls/release/language_server.sh" };
  -- }
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
  -- require('lspconfig')['dockerls'].setup {
  --   capabilities = capabilities
  -- }
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
  require('lspconfig')['ts_ls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['vimls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['yamlls'].setup {
    capabilities = capabilities
  }
  -- require('lspconfig')['zls'].setup {
  --   capabilities = capabilities;
  --   cmd = { "/home/mrus/projects/github/zls/zig-out/bin/zls" };
  -- }
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
    -- "dockerfile",
    "eex",
    -- "elixir",
    -- "erlang",
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

lua << EOF
  require("telescope").setup({
    extensions = {
      undo = {
      },
    },
  })
  local builtin = require('telescope.builtin')

  vim.keymap.set("n", "<M-f>", builtin.find_files, {noremap = true})
  vim.keymap.set("n", "<M-/>", builtin.live_grep, {noremap = true})
  vim.keymap.set("n", "<leader>fb", builtin.buffers, {noremap = true})
  vim.keymap.set("n", "<leader>fh", builtin.help_tags, {noremap = true})
  vim.keymap.set("n", "<leader>lr", builtin.lsp_references, {noremap = true})
  vim.keymap.set("n", "<M-o>", builtin.fd, {noremap = true})
  vim.keymap.set("i", "<M-o>", builtin.fd, {noremap = true})

  require("telescope").load_extension("undo")
  vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
EOF



" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Minimap                                                                    ║
" ╚════════════════════════════════════════════════════════════════════════════╝

" let g:minimap_width = 10
" let g:minimap_auto_start = 0
" let g:minimap_auto_start_win_enter = 0
" let g:minimap_block_filetypes = ['fern', 'fugitive', 'nerdtree', 'tagbar' ]
" let g:minimap_block_buftypes = [
" \'fern', 'nofile', 'nowrite', 'quickfix', 'terminal', 'prompt'
" \]
" let g:minimap_highlight_search = 1
" let g:minimap_highlight_range = 1
" let g:minimap_git_colors = 1
"
" noremap <silent> <C-k><C-m> :MinimapToggle<CR>:MinimapRescan<CR>:MinimapRefresh<CR>



" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ GPG                                                                        ║
" ╚════════════════════════════════════════════════════════════════════════════╝

autocmd User GnuPG setl textwidth=72
let g:GPGFilePattern = '*.\(gpg\|asc\|pgp\)\(.wiki\|.md\)\='



" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ trouble.vim                                                                ║
" ╚════════════════════════════════════════════════════════════════════════════╝

lua << EOF
  require("trouble").setup {}
EOF


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ HugoHelper                                                                 ║
" ╚════════════════════════════════════════════════════════════════════════════╝

let g:hugohelper_update_lastmod_on_write = 1


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
nmap <C-/><C-/> gcc
vmap <C-/><C-/> gc<Esc>


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ vim-ledger                                                                 ║
" ╚════════════════════════════════════════════════════════════════════════════╝
let g:ledger_maxwidth = 80
let g:ledger_fillstring = '    -'
let g:ledger_detailed_first = 0
let g:ledger_fold_blanks = 0


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
" ║ parrot.vim                                                                 ║
" ╚════════════════════════════════════════════════════════════════════════════╝
" lua << EOF
" require("parrot").setup({
" providers = {
"   anthropic = {
"     api_key = os.getenv "ANTHROPIC_API_KEY",
"   },
"   -- ollama = {},
"   -- github = {
"   --   api_key = os.getenv "GITHUB_TOKEN",
"   -- },
" },
" })
" EOF

" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ avante.vim                                                                 ║
" ╚════════════════════════════════════════════════════════════════════════════╝

" lua << EOF
" require('img-clip').setup ({
" })
" require('copilot').setup ({
" })
" -- require('render-markdown').setup ({
" -- })
" require('avante_lib').load()
" require('avante').setup ({
" })
" EOF


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Custom commands                                                            ║
" ╚════════════════════════════════════════════════════════════════════════════╝

" Color picker
" yad requires X11 libraries, disabling for now
" vnoremap <M-c> c<C-R>=system('yad --color --init-color' . shellescape(@"))<CR><ESC>
"
" https://github.com/hyprwm/hyprpicker
nnoremap <M-c> :put =system('hyprpicker')<CR>
inoremap <M-c> <ESC>:put =system('hyprpicker')<CR>


" ╔════════════════════════════════════════════════════════════════════════════╗
" ║ Custom replacements                                                        ║
" ╚════════════════════════════════════════════════════════════════════════════╝

inoreabbrev mariusu マリウス
inoreabbrev mariusucom xn--gckvb8fzb.com

