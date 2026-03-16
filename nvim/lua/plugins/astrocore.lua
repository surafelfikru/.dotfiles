-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        -- 4-space indentation (change to 2 if you prefer)
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        -- per-project LSP config: load .nvim.lua from project root if present
        -- neovim will prompt to trust new files once; managed via :trust
        exrc = true,
        secure = true, -- sandbox: prevents shell/write cmds in untrusted .nvim.lua files
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        -- TODO: move where ever you mapped buffer next and previous here
        -- ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        -- ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        -- TODO: move where ever you mapped buffer close here from tabline
        -- ["<Leader>bd"] = {
        --   function()
        --     require("astroui.status.heirline").buffer_picker(
        --       function(bufnr) require("astrocore.buffer").close(bufnr) end
        --     )
        --   end,
        --   desc = "Close buffer from tabline",
        -- },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
  config = function(_, opts)
    -- Configure lazygit for toggleterm, 
    -- TODO: lazy loading is forcing the logic to be here

    local function toggle_lazydocker()
      local lazydocker_terminal = require("toggleterm.terminal").Terminal:new({
        cmd = "lazydocker",
        display_name = "Lazydocker",
        hidden = true,
        direction = "float",
        close_on_exit = true,
      })
      lazydocker_terminal:toggle()
    end
    
    local function toggle_lazygit()
      local lazygit_terminal = require("toggleterm.terminal").Terminal:new({
        cmd = "lazygit",
        display_name = "Lazygit",
        hidden = true,
        direction = "float",
        close_on_exit = true,
      })
      lazygit_terminal:toggle()
    end
    vim.api.nvim_create_user_command("ToggleLazygit", toggle_lazygit, {desc = "Toggle Lazygit"})
    vim.api.nvim_create_user_command("ToggleLazydocker", toggle_lazydocker, {desc = "Toggle Lazydocker"})
    vim.keymap.set("n", "<leader>lg", "<cmd>ToggleLazygit<CR>", {noremap = true, silent = true})
    vim.keymap.set("n", "<leader>ld", "<cmd>ToggleLazydocker<CR>", {noremap = true, silent = true})
    -- run setup
    require("astrocore").setup(opts)
  end,
}
