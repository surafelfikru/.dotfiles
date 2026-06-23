-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    -- opts variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    -- Only insert new sources, do not replace the existing ones
    -- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)
    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- Python formatter: black with 79-char line length
      null_ls.builtins.formatting.black.with {
        extra_args = { "--line-length=79" },
      },
      -- Pylint: use the venv's pylint if available so imports resolve correctly
      null_ls.builtins.diagnostics.pylint.with {
        dynamic_command = function()
          local venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX
          if venv then
            local bin = venv .. "/bin/pylint"
            if vim.fn.executable(bin) == 1 then return bin end
          end
          return "pylint"
        end,
      },
    })
  end,
}
