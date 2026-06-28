return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason.nvim", config = true },
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- 1. LSP servers to auto-install
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls", "pyright",
        "rust_analyzer", "gopls", "clangd",
        "ts_ls", "html", "cssls", "jsonls",
      },
      -- automatic_enable = true (v2 default) -> calls vim.lsp.enable() per server
    })

    -- 2. External formatters/linters to auto-install via Mason
    require("mason-tool-installer").setup({
      ensure_installed = {
        "stylua",
        "ruff",
        "prettierd",
        "eslint_d",
        "golangci-lint",
        -- clang-format ships with system clang; rustfmt comes with rustup
      },
    })

    -- 3. Advertise completion capabilities to ALL servers
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    -- 4. Per-server overrides (merged onto nvim-lspconfig's base lsp/<name>.lua)
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })
    -- pyright: defaults are fine; it auto-detects an activated venv.

    -- 5. Diagnostics UI
    vim.diagnostic.config({
      virtual_text = true,
      severity_sort = true,
      float = { border = "rounded", source = true },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "E",
          [vim.diagnostic.severity.WARN]  = "W",
          [vim.diagnostic.severity.INFO]  = "I",
          [vim.diagnostic.severity.HINT]  = "H",
        },
      },
    })

    -- 6. Buffer-local keymaps once a server attaches
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local buf = args.buf
        local map = function(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = buf, desc = "LSP: " .. desc })
        end
        local tb = require("telescope.builtin")
        map("gd",          tb.lsp_definitions,      "Goto definition")
        map("gr",          tb.lsp_references,        "References")
        map("gi",          tb.lsp_implementations,   "Goto implementation")
        map("gy",          tb.lsp_type_definitions,  "Type definition")
        map("K",           vim.lsp.buf.hover,         "Hover")
        map("<leader>cr",  vim.lsp.buf.rename,        "Rename")
        map("<leader>ca",  vim.lsp.buf.code_action,   "Code action")
        map("<leader>cd",  vim.diagnostic.open_float, "Line diagnostics")
        map("[d",          function() vim.diagnostic.jump({ count = -1 }) end, "Prev diagnostic")
        map("]d",          function() vim.diagnostic.jump({ count =  1 }) end, "Next diagnostic")
      end,
    })
  end,
}
