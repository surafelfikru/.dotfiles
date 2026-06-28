return {
  "saghen/blink.cmp",
  version = "1.*",   -- prebuilt fuzzy-matcher binary; no Rust toolchain build needed
  event = "InsertEnter",
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = {
    -- <C-y> accept  |  <C-n>/<C-p> navigate  |  <C-space> open menu  |  <C-e> dismiss
    keymap = { preset = "default" },
    appearance = { nerd_font_variant = "mono" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    completion = {
      menu = {
        border = "rounded",
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        treesitter_highlighting = false,
        window = { border = "rounded" },
      },
    },
    signature = {
      enabled = true,
      window = {
        border = "rounded",
        treesitter_highlighting = false,
      },
    },
  },
  config = function(_, opts)
    require("blink.cmp").setup(opts)

    vim.schedule(function()
      local function set_border_hl()
        vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder",          { link = "FloatBorder" })
        vim.api.nvim_set_hl(0, "BlinkCmpDocBorder",           { link = "FloatBorder" })
        vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { link = "FloatBorder" })
      end
      set_border_hl()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = set_border_hl })
    end)
  end,
}
