return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  opts = {
    keymaps = {
      accept_suggestion = "<Tab>",
      clear_suggestion = "<C-]>",
      accept_word = "<C-j>",
    },
    -- blink.cmp owns the completion menu; keep Supermaven as inline ghost text only
    disable_inline_completion = false,
    disable_keymaps = false,
  },
}
