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
          "ast_grep",
          "gopls",
          "clangd",
          "denols",
          "elixirls",
          "pylsp",
          "rust_analyzer",
          "sorbet",
          "sqlls",
          "terraformls",
          "tflint",
          "bashls",
          "cssls",
          "dockerls",
          "graphql",
          "html",
          "jsonls",
          "stylelint_lsp",
          "svelte",
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

