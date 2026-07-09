return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<C-\\>", mode = { "n", "t" }, desc = "Toggle float terminal" },
    { "<leader>tf", mode = { "n", "t" }, desc = "Toggle float terminal" },
    { "<leader>tr", mode = { "n", "t" }, desc = "Toggle right terminal" },
    { "<leader>tl", mode = { "n", "t" }, desc = "Toggle left terminal" },
    { "<C-]>", mode = { "n", "t" }, desc = "Toggle right terminal" },
    { "<leader>gg", desc = "Lazygit" },
  },
  config = function()
    require("toggleterm").setup {
      shade_terminals = false,
      float_opts = { border = "curved" },
    }

    local Terminal = require("toggleterm.terminal").Terminal

    local float_term = Terminal:new { direction = "float", hidden = true }

    local right_term = Terminal:new {
      direction = "vertical",
      size = function() return math.floor(vim.o.columns * 0.5) end,
      hidden = true,
      on_open = function(term)
        vim.schedule(function()
          if vim.api.nvim_win_is_valid(term.window) then
            vim.api.nvim_win_set_width(term.window, math.floor(vim.o.columns * 0.5))
          end
        end)
      end,
    }

    local left_term = Terminal:new {
      direction = "vertical",
      size = function() return math.floor(vim.o.columns * 0.5) end,
      on_open = function() vim.cmd "wincmd H" end,
      hidden = true,
    }

    local lazygit = Terminal:new {
      cmd = "lazygit",
      direction = "float",
      hidden = true,
      close_on_exit = true,
      float_opts = { border = "curved" },
      on_open = function(_) vim.cmd "startinsert" end,
    }

    local map = vim.keymap.set
    map({ "n", "t" }, "<C-\\>", function() float_term:toggle() end)
    map({ "n", "t" }, "<leader>tf", function() float_term:toggle() end)
    map({ "n", "t" }, "<leader>tr", function() right_term:toggle() end)
    map({ "n", "t" }, "<leader>tl", function() left_term:toggle() end)
    map({ "n", "t" }, "<C-]>", function() right_term:toggle() end)
    -- From terminal mode, <C-h/j/k/l> leaves terminal mode AND moves to the
    -- adjacent window in one keypress. Without this, focus stays in the
    -- terminal in insert mode, where <leader> maps (gg, ee, ...) aren't bound
    -- and the keys get typed into the shell instead of triggering the mapping.
    map("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Go to left window" })
    -- map("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Go to lower window" })
    -- map("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Go to upper window" })
    -- map("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Go to right window" })
    map("n", "<leader>gg", function() lazygit:toggle() end, { desc = "Lazygit" })
  end,
}
