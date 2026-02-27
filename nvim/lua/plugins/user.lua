---@type LazySpec
return {
  {
    -- blink completion
    "saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@param opts blink.cmp.Config
    opts =  function(_, opts)
      local keymap = {
        -- disable default keymaps possibly Conflicting with other plugins
        ['<Tab>'] = false,
        ['<Up>'] = false,
        ['<Down>'] = false,  -- TODO: not removed, conflicting with supermaven
        ['<C-j>'] = false,  -- TODO: not removed, conflicting with supermaven
        -- set new mappings
        ['<CR>'] = { 'select_and_accept', 'fallback' }
      }

      opts.keymap = vim.tbl_deep_extend('force', opts.keymap or {}, keymap)
    end,
  }
}
