return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Live grep" },
    { "<leader>fm", function() require("telescope.builtin").marks() end,      desc = "Find marks" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        preview = {
          treesitter = false,
        },
      },
    })
    telescope.load_extension("fzf")
  end,
}
