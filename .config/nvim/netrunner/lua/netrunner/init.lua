local palette = require("netrunner.palette")
local highlights = require("netrunner.highlights")

local M = {}

M.config = {
  -- Keep the terminal background visible, the way the Ghostty theme is
  -- used with background-opacity. Floats stay opaque either way.
  transparent = true,
  terminal_colors = true,
  -- Returns a table of highlight groups that replace the ones below.
  overrides = function(colors)
    return {}
  end,
}

local function set_terminal_colors(c)
  vim.g.terminal_color_0 = c.panel
  vim.g.terminal_color_1 = c.red_dk
  vim.g.terminal_color_2 = c.green_dk
  vim.g.terminal_color_3 = c.amber_mid
  vim.g.terminal_color_4 = c.blue_mid
  vim.g.terminal_color_5 = c.violet
  vim.g.terminal_color_6 = c.cyan
  vim.g.terminal_color_7 = c.text_dk
  vim.g.terminal_color_8 = c.muted
  vim.g.terminal_color_9 = c.bad
  vim.g.terminal_color_10 = c.ok
  vim.g.terminal_color_11 = c.amber
  vim.g.terminal_color_12 = c.blue
  vim.g.terminal_color_13 = c.violet_lt
  vim.g.terminal_color_14 = c.cyan_lt
  vim.g.terminal_color_15 = c.text
end

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

function M.load()
  if vim.g.colors_name then
    vim.cmd("highlight clear")
  end
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  vim.o.background = "dark"
  vim.g.colors_name = "netrunner"

  local groups = highlights.get(palette, M.config)

  local overrides = M.config.overrides
  if type(overrides) == "function" then
    overrides = overrides(palette)
  end
  for group, spec in pairs(overrides or {}) do
    groups[group] = spec
  end

  for group, spec in pairs(groups) do
    vim.api.nvim_set_hl(0, group, spec)
  end

  if M.config.terminal_colors then
    set_terminal_colors(palette)
  end
end

M.colors = palette

return M
