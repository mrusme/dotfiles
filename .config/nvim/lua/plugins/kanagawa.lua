return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local kg = require("kanagawa")

      kg.setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = false },
        functionStyle = {},
        keywordStyle = { italic = false },
        statementStyle = { bold = false },
        typeStyle = {},
        transparent = true,
        dimInactive = false,
        terminalColors = true,
        colors = {
            -- palette = {},
            theme = { 
              wave = {}, 
              lotus = {}, 
              dragon = {}, 
              all = {
                ui = {
                  bg_gutter = "none"
                }
              } 
            },
        },
        -- overrides = function(colors)
        --     return {}
        -- end,
        theme = "dragon",
        background = {
            dark = "wave",
            light = "lotus"
        },
      })

      vim.cmd.colorscheme("kanagawa")
    end,
  },
}

