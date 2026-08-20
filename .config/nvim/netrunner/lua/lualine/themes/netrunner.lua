--[[
 Picked up automatically by lualine's `theme = "auto"`, because the module
 name matches vim.g.colors_name.
]]

local c = require("netrunner.palette")

return {
  normal = {
    a = { fg = c.void, bg = c.blue, gui = "bold" },
    b = { fg = c.blue_lt, bg = c.line },
    c = { fg = c.muted, bg = c.panel },
  },
  insert = {
    a = { fg = c.void, bg = c.ok, gui = "bold" },
    b = { fg = c.ok, bg = c.line },
  },
  visual = {
    a = { fg = c.void, bg = c.amber, gui = "bold" },
    b = { fg = c.amber_lt, bg = c.line },
  },
  replace = {
    a = { fg = c.void, bg = c.bad, gui = "bold" },
    b = { fg = c.bad, bg = c.line },
  },
  command = {
    a = { fg = c.void, bg = c.amber_lt, gui = "bold" },
    b = { fg = c.amber_lt, bg = c.line },
  },
  terminal = {
    a = { fg = c.void, bg = c.cyan_lt, gui = "bold" },
    b = { fg = c.cyan_lt, bg = c.line },
  },
  inactive = {
    a = { fg = c.muted, bg = c.panel, gui = "bold" },
    b = { fg = c.dim, bg = c.panel },
    c = { fg = c.dim, bg = c.panel },
  },
}
