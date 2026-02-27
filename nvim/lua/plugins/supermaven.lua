return {
  "supermaven-inc/supermaven-nvim",
  init = function()
    -- steal the global flag from the three keys Supermaven is going to create
    vim.keymap.set("i", "<Tab>",  function() end, { desc = "supermaven-accept" })
    vim.keymap.set("i", "<C-]>", function() end, { desc = "supermaven-clear" })
    vim.keymap.set("i", "<C-j>", function() end, { desc = "supermaven-word" })
  end,

  config = function()
    require("supermaven-nvim").setup {
      keymaps = {
        accept_suggestion = "<Tab>",
        clear_suggestion  = "<C-]>",
        accept_word       = "<C-j>",
      },
      disable_keymaps = false,   -- keep Supermaven’s maps (now non-global)
      -- any other options you like …
    }
  end,
}
