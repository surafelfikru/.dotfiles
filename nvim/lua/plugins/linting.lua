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
        -- Only run linters whose executable is actually installed, so a missing
        -- tool (e.g. ruff) degrades silently instead of erroring on every event.
        local names = lint.linters_by_ft[vim.bo.filetype] or {}
        local available = {}
        for _, name in ipairs(names) do
          local linter = lint.linters[name]
          local cmd = type(linter) == "table" and linter.cmd or nil
          if type(cmd) == "function" then cmd = cmd() end
          if type(cmd) == "string" and vim.fn.executable(cmd) == 1 then
            table.insert(available, name)
          end
        end
        if #available > 0 then
          lint.try_lint(available)
        end
      end,
    })
  end,
}
