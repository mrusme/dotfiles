return {
  {
    "nvim-telescope/telescope.nvim", 
    branch = "0.1.x",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
    },
    config = function()
      require("telescope").setup({
        extensions = {
          undo = {
          },
        },
      })
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<M-f>', builtin.find_files, 
        { desc = 'Telescope find files' })
      vim.keymap.set('n', '<M-/>', builtin.live_grep, 
        { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<M-b>', builtin.buffers, 
        { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<M-h>', builtin.help_tags, 
        { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<M-g>', builtin.lsp_definitions, 
        { desc = 'Go to definition' })
      vim.keymap.set('n', '<M-i>', builtin.lsp_implementations, 
        { desc = 'Go to definition' })
      vim.keymap.set('n', '<M-r>', builtin.lsp_references, 
        { desc = 'Go to definition' })
      require("telescope").load_extension("undo")
      vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    end,
  }
}
