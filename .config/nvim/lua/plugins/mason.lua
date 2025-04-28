return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      dependencies = {
        "williamboman/mason.nvim",
      },
    },
    -- init = keymaps.setup.diagnostics,
    config = function()
      local lspconfig = require("lspconfig")
      require("mason-lspconfig").setup({
        ensure_installed = { 
          "arduino_language_server",
          "ast_grep",
          "bashls",
          "clangd",
          "cssls",
          "denols",
          "dockerls",
          "elixirls",
          "gopls",
          "graphql",
          "harper_ls",
          "html",
          "jsonls",
          "pylsp",
          "rust_analyzer",
          "sorbet",
          "sqlls",
          "stylelint_lsp",
          "svelte",
          "terraformls",
          "tflint",
          "ts_ls",
          "vale_ls",
          "vimls",
          "yamlls",
          "zls"
        },
        handlers = {
          function(server_name)
            _opts = {}
            if server_name == "gopls" then
              _opts = {
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
                      "-node_modules" 
                    },
                    semanticTokens = true,
                  },
                },
              }
            elseif server_name == "harper_ls" then 
              _opts = {
                settings = {
                  ["harper-ls"] = {
                    userDictPath = "/home/mrus/.config/nvim/spell/en.utf-8.add",
                    linters = {
                      spell_check = false,
                    }
                  }
                }
              }
            end
            require('lspconfig')[server_name].setup(_opts)
          end,
        },
      })
    end
  },
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 
        "goimports", 
        "gofumpt",
        "gomodifytags", 
        "impl",
      },
      ui = { border = 'single' },
      PATH = 'append',
    },
    config = function(_, opts) require('mason').setup(opts) end,
  },
}

