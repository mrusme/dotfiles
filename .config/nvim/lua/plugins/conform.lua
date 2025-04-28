return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        css = { "prettier" },
        go = { "gofumpt", "goimports" },
        html = { "prettier" },
        javascript = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "deno_fmt" },
        ruby = { "rubyfmt", "rubocop" },
        rust = { "rustfmt", lsp_format = "fallback" },
        sh = { "shfmt" },
        svelte = { "prettier" },
        templ = { "gofumpt", "templ" },
        terraform = { "tofu_fmt" },
        typescript = { "deno_fmt" },
        zig = { "zigfmt" },
        ["_"] = { "trim_whitespace" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = {
        timeout_ms = 500,
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  }
}
