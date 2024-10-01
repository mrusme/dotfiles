return {
  {
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
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
          additional_vim_regex_highlighting = false,
        },
      })
    end
  }
}
