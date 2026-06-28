return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    delay = 300,
    icons = { mappings = false },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    wk.add({
      { "<leader>e", group = "explorer" },
      { "<leader>t", group = "terminal" },
      { "<leader>f", group = "find" },
      { "<leader>b", group = "buffer" },
      { "<leader>g", group = "git" },
      { "<leader>c", group = "code" },
    })
  end,
}
