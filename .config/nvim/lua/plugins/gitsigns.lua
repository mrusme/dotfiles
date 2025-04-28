return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
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
      current_line_blame = false,
      -- current_line_blame_opts = {
      --   virt_text = true,
      --   virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      --   delay = 000,
      --   ignore_whitespace = false,
      --   virt_text_priority = 100,
      -- },
      -- current_line_blame_formatter = 
      --   '[<author> <author_time:%Y-%m-%d>] <summary>',
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
  }
}

