return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",
    },
    config = function()
      -- TODO: Disable following two lines to download spell files
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
      require("neo-tree").setup({
        use_libuv_file_watcher = true,
        enable_git_status = false,
        enable_diagnostics = false,
        sort_by = "case_sensitive",
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
        window = {
          position = "left",
          width = 30,
        },
      })
      vim.keymap.set(
        "n",
        "<Leader>,",
        ":Neotree toggle<CR>",
        { silent = true, desc = "NeoTree toggle" }
      )
    end,
  },
}
