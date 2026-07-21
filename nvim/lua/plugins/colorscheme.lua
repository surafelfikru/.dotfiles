return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      theme = "wave", -- wave (dark), dragon (darker), lotus (light)
      transparent = false,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd "colorscheme kanagawa"
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require("gruvbox").setup(opts)
      -- vim.cmd "colorscheme gruvbox"
    end,
  },
}
