return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<C-\\>", mode = { "n", "t" }, desc = "Toggle float terminal" },
    { "<leader>tf", mode = { "n", "t" }, desc = "Toggle float terminal" },
    { "<leader>tr", mode = { "n", "t" }, desc = "Toggle right terminal" },
    { "<leader>tl", mode = { "n", "t" }, desc = "Toggle left terminal" },
  },
  config = function()
    require("toggleterm").setup({
      shade_terminals = false,
      float_opts = { border = "curved" },
    })

    local Terminal = require("toggleterm.terminal").Terminal

    local float_term = Terminal:new({ direction = "float", hidden = true })

    local right_term = Terminal:new({
      direction = "vertical",
      size = function() return math.floor(vim.o.columns * 0.5) end,
      hidden = true,
    })

    local left_term = Terminal:new({
      direction = "vertical",
      size = function() return math.floor(vim.o.columns * 0.5) end,
      on_open = function() vim.cmd("wincmd H") end,
      hidden = true,
    })

    local map = vim.keymap.set
    map({ "n", "t" }, "<C-\\>",    function() float_term:toggle() end)
    map({ "n", "t" }, "<leader>tf", function() float_term:toggle() end)
    map({ "n", "t" }, "<leader>tr", function() right_term:toggle() end)
    map({ "n", "t" }, "<leader>tl", function() left_term:toggle() end)

    -- exit terminal insert mode with <Esc>
    map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
  end,
}
