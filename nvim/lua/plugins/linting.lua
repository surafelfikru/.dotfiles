return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- DEFAULTS: projects can override via .nvim.lua (exrc), e.g.:
    --   require("lint").linters_by_ft.python = { "flake8" }
    -- lua/rust/c: rely on LSP diagnostics; add explicit linters here if desired
    lint.linters_by_ft = {
      python     = { "ruff" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      go         = { "golangcilint" },
    }

    local grp = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = grp,
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
