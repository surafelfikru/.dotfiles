return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "lua", "vim", "vimdoc", "query",
      "bash", "python", "rust", "go", "c",
      "javascript", "typescript", "tsx",
      "json", "yaml", "toml",
      "html", "css",
      "markdown", "markdown_inline",
      "gitcommit", "gitignore", "dockerfile",
    })

    -- enable tree-sitter highlighting for any buffer whose parser is installed
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
