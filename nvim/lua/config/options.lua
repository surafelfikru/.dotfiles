vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- NVM installs node outside the system PATH; inject the active version's bin dir
-- so Mason can find node/npm when spawning installer subprocesses.
do
  local nvm_dir = vim.fn.expand("~/.config/nvm")
  local alias_file = nvm_dir .. "/alias/default"
  local f = io.open(alias_file, "r")
  if f then
    local alias = f:read("*l"):gsub("%s+", "")
    f:close()
    -- resolve partial alias (e.g. "22") to the highest matching installed version
    local versions = vim.fn.glob(nvm_dir .. "/versions/node/v" .. alias .. "*", false, true)
    table.sort(versions)
    local resolved = versions[#versions]
    if resolved then
      local node_bin = resolved .. "/bin"
      vim.env.PATH = node_bin .. ":" .. vim.env.PATH
    end
  end
end

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true

opt.splitbelow = true
opt.splitright = true

opt.undofile = true
opt.clipboard = "unnamedplus"

opt.updatetime = 250
opt.timeoutlen = 300

opt.exrc = true        -- load .nvim.lua in project root (Neovim prompts :trust once)

opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
