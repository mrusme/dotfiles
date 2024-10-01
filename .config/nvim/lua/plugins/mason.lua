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
        -- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
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
            require('lspconfig')[server_name].setup({})
          end,
        },
      })
    end
  },
  {
    'williamboman/mason.nvim',
    opts = {
      ui = { border = 'single' },
      PATH = 'append',
    },
    config = function(_, opts) require('mason').setup(opts) end,
  },
}

