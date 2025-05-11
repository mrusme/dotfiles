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

vim.cmd("filetype plugin indent on")
vim.cmd("filetype plugin on")

vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.o.termguicolors = true

-- Jeez, who even wants that ...
vim.opt.mouse = ""

vim.opt.clipboard = { "unnamed", "unnamedplus" }

vim.opt.encoding = "utf-8"
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.showmatch = true
vim.opt.showmode = true
vim.opt.smarttab = true
vim.opt.complete:remove({ "i" })
vim.opt.nrformats:remove({ "octal" })
vim.opt.shiftround = true
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 50
vim.opt.timeoutlen = 500

vim.opt.splitbelow = true

vim.opt.incsearch = true

vim.opt.laststatus = 2
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.wildmenu = true

vim.opt.autoread = true

-- 2 spaces tab, expand tabs to spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.shortmess:append("s", "W", "I", "c", "C", "F", "S")

-- vim.opt.listchars=tab:▒░,trail:▓
vim.opt.listchars:append({ tab = "⇥ ", trail = "˽", extends = "→" })

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
vim.opt.fileformats = { "unix", "dos", "mac" }
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.wildignore:append({
  "*/.git/*",
  "*/.hg/*",
  "*/.svn/*",
  "**/node_modules/**",
})

vim.opt.undofile = true
vim.opt.undodir = vim.fs.normalize("~/.cache/nvim/undo")

vim.opt.colorcolumn = "80"

vim.opt.spelllang = { "en", "ro", "es", "fr", "de", "cjk" }
vim.opt.spellsuggest = { "best", 9 }

vim.g.spellfile_URL = "https://ftp.nluug.nl/vim/runtime/spell"

vim.opt.fillchars = {
  vert = "🮘",
}

--[[
 ╔════════════════════════════════════════════════════════════════════════════╗
 ║ LSP                                                                        ║
 ╚════════════════════════════════════════════════════════════════════════════╝
]]

-- [ CSS ]------------------------------------------------------------------- --
vim.lsp.config("cssls", {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_markers = { "package.json", ".git" },
})
vim.lsp.enable("cssls")

-- [ SOY ]------------------------------------------------------------------- --
local function denols_handler(err, result, ctx, config)
  if not result or vim.tbl_isempty(result) then
    return nil
  end

  local client = vim.lsp.get_client_by_id(ctx.client_id)
  for _, res in pairs(result) do
    local uri = res.uri or res.targetUri
    if uri:match("^deno:") then
      virtual_text_document(uri, client)
      res["uri"] = uri
      res["targetUri"] = uri
    end
  end

  lsp.handlers[ctx.method](err, result, ctx, config)
end
vim.lsp.config("denols", {
  cmd = { "deno", "lsp" },
  cmd_env = { NO_COLOR = true },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = { "deno.json", "deno.jsonc", ".git" },
  settings = {
    deno = {
      enable = true,
      suggest = {
        imports = {
          hosts = {
            ["https://deno.land"] = true,
          },
        },
      },
    },
  },
  handlers = {
    ["textDocument/definition"] = denols_handler,
    ["textDocument/typeDefinition"] = denols_handler,
    ["textDocument/references"] = denols_handler,
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(0, "LspDenolsCache", function()
      client:exec_cmd({
        command = "deno.cache",
        arguments = { {}, vim.uri_from_bufnr(bufnr) },
      }, { bufnr = bufnr }, function(err, _result, ctx)
        if err then
          local uri = ctx.params.arguments[2]
          vim.api.nvim_err_writeln(
            "cache command failed for " .. vim.uri_to_fname(uri)
          )
        end
      end)
    end, {
      desc = "Cache a module and all of its dependencies.",
    })
  end,
})
vim.lsp.enable("denols")

-- [ GO ]-------------------------------------------------------------------- --
vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.mod", "go.work", ".git" },
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        fieldalignment = true,
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = {
        "-.git",
        "-.vscode",
        "-.idea",
        "-.vscode-test",
        "-node_modules",
      },
    },
  },
})
vim.lsp.enable("gopls")

-- [ Harper ]---------------------------------------------------------------- --
vim.lsp.config("harper_ls", {
  cmd = { "harper-ls", "--stdio" },
  filetypes = {
    "gitcommit",
    "html",
    "markdown",
    "toml",
  },
  root_markers = { ".git" },
})
vim.lsp.enable("harper_ls")

-- [ HTML ]------------------------------------------------------------------ --
vim.lsp.config("html", {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "templ" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    provideFormatter = true,
  },
  root_markers = {
    ".git",
  },
})
vim.lsp.enable("html")

-- [ Hugo ]------------------------------------------------------------------ --
vim.lsp.config("djlsp", {
  cmd = { "djlsp" },
  filetypes = { "html", "htmldjango" },
  root_markers = {
    "config/_default/config.toml",
    "config/_default/config.yaml",
    ".git",
  },
})
vim.lsp.enable("djlsp")

-- [ JSON ]------------------------------------------------------------------ --
vim.lsp.config("jsonls", {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  init_options = {
    provideFormatter = true,
  },
  root_markers = {
    ".git",
  },
})
vim.lsp.enable("jsonls")

-- [ Lua ]------------------------------------------------------------------- --
vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        },
      },
    },
  },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
})
vim.lsp.enable("lua_ls")

-- [ Python ]---------------------------------------------------------------- --
vim.lsp.config("pylsp", {
  cmd = { "pylsp" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    ".git",
  },
})
vim.lsp.enable("pylsp")

-- [ Rust ]------------------------------------------------------------------ --
vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "cargo.toml", ".git" },
})
vim.lsp.enable("rust_analyzer")

-- [ Ruby ]------------------------------------------------------------------ --
vim.lsp.config("sorbet", {
  cmd = { "srb", "tc", "--lsp" },
  filetypes = { "ruby" },
  root_markers = { "Gemfile", ".git" },
})
vim.lsp.enable("sorbet")

-- [ SQL ]------------------------------------------------------------------- --
vim.lsp.config("sqlls", {
  cmd = { "sql-language-server", "up", "--method", "stdio" },
  filetypes = { "sql", "mysql" },
  root_markers = { ".git" },
})
vim.lsp.enable("sqlls")

-- [ Tailwind ]-------------------------------------------------------------- --
vim.lsp.config("tailwindcss", {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "aspnetcorerazor",
    "astro",
    "astro-markdown",
    "blade",
    "clojure",
    "django-html",
    "htmldjango",
    "edge",
    "eelixir",
    "elixir",
    "ejs",
    "erb",
    "eruby",
    "gohtml",
    "gohtmltmpl",
    "haml",
    "handlebars",
    "hbs",
    "html",
    "htmlangular",
    "html-eex",
    "heex",
    "jade",
    "leaf",
    "liquid",
    "markdown",
    "mdx",
    "mustache",
    "njk",
    "nunjucks",
    "php",
    "razor",
    "slim",
    "twig",
    "css",
    "less",
    "postcss",
    "sass",
    "scss",
    "stylus",
    "sugarss",
    "javascript",
    "javascriptreact",
    "reason",
    "rescript",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
    "templ",
  },
  settings = {
    tailwindCSS = {
      classAttributes = {
        "class",
        "className",
        "class:list",
        "classList",
        "ngClass",
      },
      includeLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
        htmlangular = "html",
        templ = "html",
      },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      validate = true,
    },
  },
  root_markers = {
    "config/tailwind.config.js",
    "tailwind.config.js",
    ".git",
  },
})
vim.lsp.enable("tailwindcss")

-- [ Terraform ]------------------------------------------------------------- --
vim.lsp.config("terraformls", {
  cmd = { "terraform-ls", "serve" },
  filetypes = { "terraform", "terraform-vars" },
  root_markers = { ".terraform", ".git" },
})
vim.lsp.enable("terraformls")

-- [ YAML ]------------------------------------------------------------------ --
vim.lsp.config("yamlls", {
  cmd = { "yaml-language-server", "--stdio" },
  settings = {
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
  },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  root_markers = { ".git" },
})
vim.lsp.enable("yamlls")

-- [ Zig ]------------------------------------------------------------------- --
vim.lsp.config("zls", {
  cmd = { "zls" },
  filetypes = { "zig" },
  root_markers = { "build.zig", ".git" },
})
vim.lsp.enable("zls")

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

--[[
 ╔════════════════════════════════════════════════════════════════════════════╗
 ║ Keymapping                                                                 ║
 ╚════════════════════════════════════════════════════════════════════════════╝
]]

vim.keymap.set(
  "n",
  "<C-L>",
  ":nohlsearch<CR><C-L>",
  { silent = true, desc = "Clear search" }
)

vim.keymap.set("n", "<C-s>", ":update<CR>", { silent = true, desc = "Save" })
vim.keymap.set(
  "v",
  "<C-s>",
  "<C-C>:update<CR>",
  { silent = true, desc = "Save" }
)
vim.keymap.set(
  "i",
  "<C-s>",
  "<Esc>:update<CR>",
  { silent = true, desc = "Save" }
)

vim.keymap.set("n", "<Tab>", ">>", { silent = true, desc = "Indent" })
vim.keymap.set(
  "v",
  "<Tab>",
  ">gv",
  { silent = true, remap = true, desc = "Indent" }
)
vim.keymap.set("n", "<S-Tab>", "<<", { silent = true, desc = "Unindent" })
vim.keymap.set(
  "v",
  "<S-Tab>",
  "<gv",
  { silent = true, remap = true, desc = "Unindent" }
)

vim.keymap.set("n", "<C-a>", "ggVG", { silent = true, desc = "Select all" })
vim.keymap.set(
  "i",
  "<C-a>",
  "<Esc>ggVG",
  { silent = true, desc = "Select all" }
)

vim.keymap.set(
  "n",
  "<M-[>",
  ":tabprevious<CR>",
  { silent = true, desc = "Previous tab" }
)
vim.keymap.set(
  "i",
  "<M-[>",
  "<Esc>:tabprevious<CR>i",
  { silent = true, desc = "Previous tab" }
)
vim.keymap.set(
  "n",
  "<M-]>",
  ":tabnext<CR>",
  { silent = true, desc = "Next tab" }
)
vim.keymap.set(
  "i",
  "<M-]>",
  "<Esc>:tabnext<CR>i",
  { silent = true, desc = "Next tab" }
)

vim.keymap.set("n", "<M-t>", ":tabnew<CR>", { silent = true, desc = "New tab" })
vim.keymap.set(
  "i",
  "<M-t>",
  "<Esc>:tabnew<CR>i",
  { silent = true, desc = "New tab" }
)

vim.keymap.set(
  "n",
  "<M-w>",
  ":tabclose<CR>",
  { silent = true, desc = "Close tab" }
)
vim.keymap.set(
  "i",
  "<M-w>",
  "<Esc>:tabclose<CR>i",
  { silent = true, desc = "Close tab" }
)

vim.keymap.set("n", "<M-1>", ":tabn 1<CR>", { silent = true, desc = "Tab 1" })
vim.keymap.set(
  "i",
  "<M-1>",
  "<Esc>:tabn 1<CR>i",
  { silent = true, desc = "Tab 1" }
)
vim.keymap.set("n", "<M-2>", ":tabn 2<CR>", { silent = true, desc = "Tab 2" })
vim.keymap.set(
  "i",
  "<M-2>",
  "<Esc>:tabn 2<CR>i",
  { silent = true, desc = "Tab 2" }
)
vim.keymap.set("n", "<M-3>", ":tabn 3<CR>", { silent = true, desc = "Tab 3" })
vim.keymap.set(
  "i",
  "<M-3>",
  "<Esc>:tabn 3<CR>i",
  { silent = true, desc = "Tab 3" }
)
vim.keymap.set("n", "<M-4>", ":tabn 4<CR>", { silent = true, desc = "Tab 4" })
vim.keymap.set(
  "i",
  "<M-4>",
  "<Esc>:tabn 4<CR>i",
  { silent = true, desc = "Tab 4" }
)
vim.keymap.set("n", "<M-5>", ":tabn 5<CR>", { silent = true, desc = "Tab 5" })
vim.keymap.set(
  "i",
  "<M-5>",
  "<Esc>:tabn 5<CR>i",
  { silent = true, desc = "Tab 5" }
)
vim.keymap.set("n", "<M-6>", ":tabn 6<CR>", { silent = true, desc = "Tab 6" })
vim.keymap.set(
  "i",
  "<M-6>",
  "<Esc>:tabn 6<CR>i",
  { silent = true, desc = "Tab 6" }
)
vim.keymap.set("n", "<M-7>", ":tabn 7<CR>", { silent = true, desc = "Tab 7" })
vim.keymap.set(
  "i",
  "<M-7>",
  "<Esc>:tabn 7<CR>i",
  { silent = true, desc = "Tab 7" }
)
vim.keymap.set("n", "<M-8>", ":tabn 8<CR>", { silent = true, desc = "Tab 8" })
vim.keymap.set(
  "i",
  "<M-8>",
  "<Esc>:tabn 8<CR>i",
  { silent = true, desc = "Tab 8" }
)
vim.keymap.set("n", "<M-9>", ":tabn 9<CR>", { silent = true, desc = "Tab 9" })
vim.keymap.set(
  "i",
  "<M-9>",
  "<Esc>:tabn 9<CR>i",
  { silent = true, desc = "Tab 9" }
)
vim.keymap.set("n", "<M-0>", ":tabn 10<CR>", { silent = true, desc = "Tab 10" })
vim.keymap.set(
  "i",
  "<M-0>",
  "<Esc>:tabn 10<CR>i",
  { silent = true, desc = "Tab 10" }
)

vim.keymap.set(
  "n",
  "<C-q><C-q>",
  ":qa!<CR>",
  { silent = true, desc = "Force quit" }
)
vim.keymap.set(
  "i",
  "<C-q><C-q>",
  "<Esc>:qa!<CR>",
  { silent = true, desc = "Force quit" }
)

vim.keymap.set("n", "<C-q>", ":qa<CR>", { silent = true, desc = "Quit" })
vim.keymap.set("i", "<C-q>", "<Esc>:qa<CR>", { silent = true, desc = "Quit" })

vim.keymap.set(
  "n",
  "<Leader>`",
  "gq}<CR>",
  { silent = true, desc = "Reformat current paragraph" }
)
vim.keymap.set(
  "n",
  "<Leader>~",
  "gqG<CR>",
  { silent = true, desc = "Reformat to EOF" }
)

-- https://github.com/hyprwm/hyprpicker
vim.keymap.set(
  "n",
  "<M-c>",
  ":put =system('hyprpicker')<CR>",
  { silent = true, desc = "Color picker" }
)
vim.keymap.set(
  "i",
  "<M-c>",
  "<ESC>:put =system('hyprpicker')<CR>",
  { silent = true, desc = "Color picker" }
)

--[[
 ╔════════════════════════════════════════════════════════════════════════════╗
 ║ Replacements                                                               ║
 ╚════════════════════════════════════════════════════════════════════════════╝
]]

vim.cmd.inoreabbrev({ "<buffer>", "mariusu", "マリウス" })
vim.cmd.inoreabbrev({ "<buffer>", "mariusucom", "xn--gckvb8fzb.com" })

--[[
 ╔════════════════════════════════════════════════════════════════════════════╗
 ║ Autocmds                                                                   ║
 ╚════════════════════════════════════════════════════════════════════════════╝
]]

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Save window position on exit
autocmd("BufWinLeave", {
  pattern = "*.*",
  command = "mkview",
})
-- Restore window position
autocmd("BufWinEnter", {
  pattern = "*.*",
  command = "silent! loadview",
})

-- Set textwidth=80 for types and enable spell
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.{md,txt}",
  command = "setlocal tw=80 colorcolumn=80 fo=awqtc comments+=nb:> spell"
    .. " tabstop=2 shiftwidth=2 expandtab",
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.{jscs,jshint,eslint}rc",
  command = "set filetype=json",
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "aliases.local,zshrc.local,.zshrc,*/zsh/configs/*",
  command = "set filetype=sh",
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "gitconfig.local,.gitconfig",
  command = "set filetype=gitconfig",
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "tmux.conf.local,tmux.conf,.tmux.conf",
  command = "set filetype=tmux",
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "vimrc.local,.vimrc,init.vim",
  command = "set filetype=vim",
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "{neomutt-*,*.eml}",
  command = "setlocal tw=72 colorcolumn=72 fo=awq comments+=nb:> spell"
    .. " | match ErrorMsg '\\s\\+$'",
})

--[[
 ╔════════════════════════════════════════════════════════════════════════════╗
 ║ Theme                                                                      ║
 ╚════════════════════════════════════════════════════════════════════════════╝
]]

--[[
 OVERRIDES

 highlight Normal ctermbg=none guibg=none
 highlight NonText ctermbg=none guibg=none
 highlight ColorColumn cterm=reverse ctermbg=200 ctermfg=233
   \ gui=reverse guibg=#3e445e guifg=#0f1117
 highlight EndOfBuffer ctermbg=none guibg=none
 highlight LineNr ctermbg=none guibg=none
]]

vim.api.nvim_set_hl(
  0,
  "CmpDocumentation",
  { link = "NormalFloat", default = true }
)
vim.api.nvim_set_hl(
  0,
  "CompeDocumentation",
  { link = "NormalFloat", default = true }
)

--[[
╔════════════════════════════════════════════════════════════════════════════╗
║ Reader: https://github.com/mrusme/reader                                   ║
╚════════════════════════════════════════════════════════════════════════════╝
TODO: Make plugin, load via lazy
]]

vim.cmd([[
function s:reader_url()
  normal! "uyiW
  let mycommand = "reader -o " . @u
  execute "new | r!" . mycommand
endfunction
noremap <Plug>reader_url : call <SID>reader_url()<CR>
nmap gx <Plug>reader_url
]])
