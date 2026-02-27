return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  position = "float",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, but recommended
  },
  lazy = false, -- neo-tree will lazily load itself
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, position = "float" })
      end,
      desc = "Toggle explorer (floating)"
    },
  },
}

