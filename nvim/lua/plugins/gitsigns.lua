return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- <leader>gg is lazygit (toggleterm); keep all gitsigns maps off that.
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local function map(mode, lhs, rhs, desc, opts)
        opts = vim.tbl_extend("force", { buffer = bufnr, desc = desc }, opts or {})
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      -- hunk navigation
      map("n", "]g", function() gs.nav_hunk("next") end, "Next hunk")
      map("n", "[g", function() gs.nav_hunk("prev") end, "Prev hunk")

      -- actions under <leader>g
      map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
      map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
      map("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage hunk")
      map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset hunk")
      map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
      map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
      map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
      map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
      map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
      map("n", "<leader>gd", gs.diffthis, "Diff this")
      map("n", "<leader>gt", gs.toggle_current_line_blame, "Toggle line blame")
    end,
  },
}
