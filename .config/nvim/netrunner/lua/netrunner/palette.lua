--[[
 Netrunner, matching ~/.config/ghostty/themes/netrunner.conf

 The first five blocks are the scheme as published. Everything below the
 `ANSI fill-ins` comment is derived, because the scheme has no magenta, no
 cyan and no dimmed variants, and a terminal needs all sixteen.
]]

return {
  -- [ Ground ]
  void = "#05060a",
  panel = "#0b0e16",
  panel_hi = "#121726",
  line = "#1c2233",
  line_hi = "#2b344d",

  -- [ Identity: the logo ramp, dark to highlight ]
  blue_dk = "#303888",
  blue = "#6e86e0",
  blue_lt = "#a8bcf0",
  blue_hi = "#e8f8f8",

  -- [ Action: the cover halftone ]
  amber_dk = "#8a6a3a",
  amber = "#e0a868",
  amber_lt = "#ffd79a",

  -- [ Text ]
  text = "#e8f0f8",
  muted = "#7a85a6",

  -- [ Status ]
  ok = "#48b878",
  warn = "#e0a868",
  bad = "#e05a6a",

  -- [ ANSI fill-ins, same values as the Ghostty palette ]
  red_dk = "#b84856",
  green_dk = "#389060",
  amber_mid = "#c08e52",
  blue_mid = "#4f5fb4",
  violet = "#8a68c8",
  violet_lt = "#b492ec",
  cyan = "#4e93a8",
  cyan_lt = "#86c8dc",
  text_dk = "#c6d0e0",

  -- [ Derived: gutter gray, and grounds tinted for diffs and diagnostics ]
  dim = "#4d5772",
  bg_add = "#0d2119",
  bg_change = "#101a33",
  bg_delete = "#2a1017",
  bg_text = "#183a2a",
  bg_search = "#3a2c14",
  bg_error = "#2a1017",
  bg_warn = "#2b2114",
  bg_info = "#101a33",
  bg_hint = "#0e2430",
}
