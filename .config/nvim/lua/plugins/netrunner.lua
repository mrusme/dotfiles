return {
  {
    dir = vim.fn.stdpath("config") .. "/netrunner",
    name = "netrunner",
    lazy = false,
    priority = 1000,
    config = function()
      local nr = require("netrunner")

      nr.setup({
        transparent = true,
        terminal_colors = true,
        -- overrides = function(colors)
        --     return {}
        -- end,
      })

      vim.cmd.colorscheme("netrunner")
    end,
  },
}
