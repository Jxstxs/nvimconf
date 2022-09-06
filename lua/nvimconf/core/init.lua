-- Load Nvim Options and Keys
require("nvimconf.core.options")
require("nvimconf.core.keymap")

-- Check for Safe Import
local status, _import = pcall(require, "import")
-- if not found install plugins
if not status then
	require("nvimconf.modules.plugins")
	require("packer").sync()
	return
end

-- Configure Import
_import.config(require("nvimconf.modules.import"))
local import = _import.import

-- Theme
import("catppuccin", require("nvimconf.modules.colorscheme"))
vim.cmd [[colorscheme catppuccin]]

-- Ui Stuff
import("bufferline", require("nvimconf.modules.bufferline"))
import("indent_blankline", require("nvimconf.modules.indent"))
import("hlargs", require("nvimconf.modules.hlargs"))
import("dressing", require("nvimconf.modules.dressing"))

-- Rnvimr
import("nvimconf.modules.rnvimr")

-- Key Stuff
-- import("keystack", require("nvimconf.modules.keystack"))
import("legendary", require("nvimconf.modules.legendary"))
import("which-key", require("nvimconf.modules.whichkey"))

-- Git Stuff
import("nvimconf.modules.lazygit")
import("git-worktree", require("nvimconf.modules.worktree"))

-- Plugins
import("nvimconf.modules.plugins")
-- Lsp Stuff
-- import("mason", require("nvimconf.modules.lsp").manson)
-- import("manson-lspconfig", require("nvimconf.modules.lsp").manson_lspconfig)
-- import("lspconfig", require("nvimconf.modules.lsp").lspconfig)
-- import("lspsaga", require("nvimconf.modules.lsp").lspsaga)

-- Cmp Stuff
-- import("cmp", require("lua.nvimconf.modules.cmp"))

