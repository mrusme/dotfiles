return {
  {
    "maxmx03/fluoromachine.nvim",
    lazy = false,
    priority = 1000,
    config = function ()
      local fm = require "fluoromachine"

      fm.setup {
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
      }

      vim.cmd.colorscheme "fluoromachine"
    end
  }
}
