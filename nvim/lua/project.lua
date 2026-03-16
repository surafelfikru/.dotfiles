-- project.lua — per-project LSP helper
-- Require this from a .nvim.lua in any project root:
--
--   local project = require("project")
--
-- Then call the helpers below to override LSP behavior for that codebase only.
-- Global defaults in astrolsp.lua are unaffected for all other projects.

local M = {}

--- Override settings for an LSP server in this project.
--- Merges into the server's existing global config — only keys you specify change.
---
--- @param server string  Server name, e.g. "rust_analyzer", "lua_ls"
--- @param config table   lspconfig-compatible config (cmd, settings, root_dir, etc.)
---
--- Examples:
---   -- Use nightly rust-analyzer binary
---   project.lsp("rust_analyzer", {
---     cmd = { vim.fn.expand("~/.rustup/toolchains/nightly/bin/rust-analyzer") },
---   })
---
---   -- Reduce memory usage on a large codebase
---   project.lsp("rust_analyzer", {
---     settings = {
---       ["rust-analyzer"] = {
---         cargo  = { allFeatures = false },
---         lru    = { capacity = 64 },
---       },
---     },
---   })
function M.lsp(server, config)
  vim.lsp.config(server, config)
end

--- Disable LSP features for all clients that attach in this session.
--- Runs on every LspAttach so it covers servers that start after this file loads.
---
--- @param opts { codelens?: boolean, inlay_hints?: boolean, semantic_tokens?: boolean }
---
--- Example:
---   project.features({ codelens = false, semantic_tokens = false })
function M.features(opts)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client then return end

      if opts.codelens == false then
        client.server_capabilities.codeLensProvider = nil
      end

      if opts.semantic_tokens == false then
        client.server_capabilities.semanticTokensProvider = nil
      end

      if opts.inlay_hints == false then
        vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
      end
    end,
  })
end

--- Disable format-on-save for every buffer in this session.
--- Useful for legacy codebases where you don't want autoformat running.
---
--- Example:
---   project.no_format_on_save()
function M.no_format_on_save()
  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
      vim.b.autoformat = false
    end,
  })
end

return M
