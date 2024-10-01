return {
  {
    "mhartington/formatter.nvim",
    config = function()
      local util = require "formatter.util"
      require("formatter").setup {
        logging = false,
        log_level = vim.log.levels.WARN,
        filetype = {
          css = {
            require("formatter.filetypes.css").prettier,
          },
          go = {
            require("formatter.filetypes.go").gofmt,
            require("formatter.filetypes.go").goimports,
          },
          html = {
            require("formatter.filetypes.html").prettier,
          },
          json = {
            require("formatter.filetypes.json").prettier,
          },
          markdown = {
            require("formatter.filetypes.markdown").denofmt,
          },
          ruby = {
            require("formatter.filetypes.ruby").rubocop,
          },
          rust = {
            require("formatter.filetypes.rust").rustfmt,
          },
          svelte = {
            require("formatter.filetypes.svelte").prettier,
          },
          terraform = {
            require("formatter.filetypes.terraform").terraformfmt,
          },
          typescript = {
            require("formatter.filetypes.typescript").denofmt,
          },
          xhtml = {
            require("formatter.filetypes.xhtml").tidy,
          },
          xml = {
            require("formatter.filetypes.xml").tidy,
          },
          yaml = {
            require("formatter.filetypes.yaml").pyaml,
          },
          zig = {
            require("formatter.filetypes.zig").zigfmt,
          },
          ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace
          }
        }
      }
      vim.keymap.set('n', '<Leader>f', ':Format<CR>', {silent = true})
    end
  }
}
