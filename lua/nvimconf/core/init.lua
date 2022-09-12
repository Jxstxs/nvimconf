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
-- Safely Requires an Module and shows some Extra Information
local import = _import.import

-- Impatient Loading for fast times
import("impatient", require("nvimconf.modules.impatient"))

-- Theme
import("catppuccin", require("nvimconf.modules.colorscheme"))
--
-- Autocommands
import("nvimconf.modules.autocommands")

-- Filemanager
import("nvim-tree", require("nvimconf.modules.filemanager.nvim-tree"))
import("nvimconf.modules.filemanager.rnvimr")

-- Git
import("gitsigns", require("nvimconf.modules.git.gitsigns"))
import("git-worktree", require("nvimconf.modules.git.worktree"))
import("nvimconf.modules.git.lazygit")

-- Keymap
import("keystack", require("nvimconf.modules.keymap.keystack"))
import("which-key", require("nvimconf.modules.keymap.whichkey"))

-- Lsp
import("mason", require("nvimconf.modules.lsp.mason"))
import("mason-lspconfig", require("nvimconf.modules.lsp.mason-lspconfig"))
import("lspconfig", require("nvimconf.modules.lsp.lspconfig"))
import("lspsaga", require("nvimconf.modules.lsp.lspsaga"))

-- Syntax
import("nvim-treesitter", require("nvimconf.modules.syntax.treesitter"))
import("hlargs", require("nvimconf.modules.syntax.hlargs"))
import("nvimconf.modules.syntax.markdown")

-- Ui
import("bufferline", require("nvimconf.modules.ui.bufferline"))
import("indent_blankline", require("nvimconf.modules.ui.indent"))
import("dressing", require("nvimconf.modules.ui.dressing"))
import("telescope", require("nvimconf.modules.ui.telescope"))
import("alpha", require("nvimconf.modules.ui.alpha"))
import("project_nvim", require("nvimconf.modules.ui.project"))
import("lualine", require("nvimconf.modules.ui.lualine"))
import("treesitter-context", require("nvimconf.modules.ui.ts-context"))

-- Writing
import("nvim-autopairs", require("nvimconf.modules.writing.autopairs"))
import("nvim-ts-autotag", require("nvimconf.modules.writing.autotag"))
import("Comment", require("nvimconf.modules.writing.comment"))
import("cmp", require("nvimconf.modules.writing.cmp"))
import("copilot", require("nvimconf.modules.writing.copilot"))

-- Plugins
import("nvimconf.modules.plugins")
