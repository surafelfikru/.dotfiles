return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    -- DEFAULTS: projects can override via .nvim.lua (exrc) or their own tool config files
    -- (e.g. ruff.toml, stylua.toml, .prettierrc — the tools pick those up automatically)
    formatters_by_ft = {
      lua        = { "stylua" },
      python     = { "ruff_format" },   -- swap to { "black" } per project via .nvim.lua
      rust       = { "rustfmt" },
      go         = { "gofmt" },
      c          = { "clang_format" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      json       = { "prettierd", "prettier", stop_after_first = true },
      html       = { "prettierd", "prettier", stop_after_first = true },
      css        = { "prettierd", "prettier", stop_after_first = true },
    },
    format_on_save = function(bufnr)
      -- opt out globally: vim.g.disable_autoformat = true
      -- opt out per buffer: vim.b.disable_autoformat = true
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 1000, lsp_format = "fallback" }
    end,
  },
}
