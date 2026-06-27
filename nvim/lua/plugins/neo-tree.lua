return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree position=float toggle<cr>", desc = "Explorer (center float)" },
    { "<leader>er", "<cmd>Neotree position=right toggle<cr>", desc = "Explorer (right)" },
    { "<leader>el", "<cmd>Neotree position=left toggle<cr>", desc = "Explorer (left)" },
  },
  opts = {
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      hijack_netrw_behavior = "open_current",
    },
    window = {
      position = "float",
    },
  },
}
