return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          ["<Leader>ld"] = false,
          ["<Leader>w"] = {
              function()
                require("astroui.status.heirline").buffer_picker(
                  function(bufnr) require("astrocore.buffer").close(bufnr) end
                )
              end,
              desc = "Close buffer from tabline",
          },
          -- find grep
          ["<Leader>fg"] = { "<cmd>Telescope live_grep<cr>", desc = "Grep in files" },
          -- set classic buffer cycling
          -- ["<S-l>"] = { function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "Next buffer" },
          -- ["<S-h>"] = { function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end, desc = "Previous buffer" },

          -- bind classic buffer cycling
          ["<S-l>"] = {
            function()
              require("astrocore.buffer").nav(vim.v.count1)   -- next
            end,
            desc = "Next buffer",
          },
          ["<S-h>"] = {
            function()
              require("astrocore.buffer").nav(-vim.v.count1)  -- prev
            end,
            desc = "Previous buffer",
          },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
        },
      },
    },
  },
}
