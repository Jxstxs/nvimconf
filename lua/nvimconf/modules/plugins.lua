local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack"
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path .. "packer-test/start/packer.nvim",
	})
	vim.cmd([[packadd packer.nvim]])
end

local status, packer = pcall(require, "packer")
if not status then
	return
end

-- Configure Packer
packer.init(require("nvimconf.modules.packer"))

return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	-- All time Loved by everyone
	use({ "nvim-lua/plenary.nvim", commit = "4b66054e75356ac0b909bbfee9c682e703f535c2" })
	use({ "kyazdani42/nvim-web-devicons" }) -- no need for commit wont change

	-- Safe imports
	use({ "miversen33/import.nvim", commit = "cd3be6736a78aa07357d97efa71e7ab5e542532b" })

	-- Theme
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- File Management / Ranger
	use({ "kevinhwang91/rnvimr" })

    -- Lsp Stuff
    use({ "neovim/nvim-lspconfig", commit = "0fafc3ef648bd612757630097c96b725a36a0476" })
    use({ "williamboman/mason.nvim", commit = "b109b498650fae746b3f10d09fa08cd9cc8ad674" })
    use({ "williamboman/mason-lspconfig.nvim", commit = "980f83609cd58e2069dda89a05367f81a48bdf2f" })
    use({ "glepnir/lspsaga.nvim", commit = "551811a33f26040ae217d27f212a9b88165e4633" })

    -- Cmp Stuff
    use({ "hrsh7th/nvim-cmp", commit = "33fbb2c3d2c512bd79ea03cf11fea405cbe618a9" })
    use({ "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" })
    use({ "f3fora/cmp-spell", commit = "5602f1a0de7831f8dad5b0c6db45328fbd539971" })
    use({ "hrsh7th/cmp-nvim-lsp-signature-help", commit = "3dd40097196bdffe5f868d5dddcc0aa146ae41eb" })
    use({ "dmitmel/cmp-digraphs", commit = "5efc1f0078d7c5f3ea1c8e3aad04da3fd6e081a9" })
    use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })
    use({ "hrsh7th/cmp-emoji", commit = "19075c36d5820253d32e2478b6aaf3734aeaafa0" })
    -- use({ "tzachar/cmp-tabnine", commit = "f2ea9c0824d389d588966c64c146d324138a443c" })
    use({ "petertriho/cmp-git", commit = "fae6cdb407ad6c63a0b1928670bad1a67a55b887" })

    -- Ui Stuff
    use({ "akinsho/bufferline.nvim", commit = "938908fc8db120d907bda23f6744202f534f63e4" })
    use({ "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" })
    use({ "m-demare/hlargs.nvim", commit = "71f3c467c426d2ded2491cc280e21cf8c3330d8f" })
    use({ "stevearc/dressing.nvim", commit = "9cdb3e0f0973447b940b35d3175dc780301de427" })

	-- Key related
	use({ "folke/which-key.nvim", commit = "f11260251ad942ba1635db9bc25c2efaf75caf0a" })
    use({ "mrjones2014/legendary.nvim", commit = "bb997500c454a470dc029c054d66f6d698404f2c" })
	use({ "Jxstxs/keystack.nvim" })

    -- Git Stuff
    use({ "kdheepak/lazygit.nvim", commit = "9c73fd69a4c1cb3b3fc35b741ac968e331642600" })
    use({ "ThePrimeagen/git-worktree.nvim", commit = "d7f4e2584e81670154f07ca9fa5dd791d9c1b458" })

    -- Snippet Stuff
    -- use({ "L3MON4D3/LuaSnip", commit = "a45cd5f4d9dea7c64b37fa69dea91e46bbbe9671" })
    -- use({ "SirVer/ultisnips", commit = "4f5249b2a6f6308377cb2bf734974a4e6f8a960e" })

	if packer_bootstrap then
		packer.sync()
	end
end)

-- use {
--   'myusername/example',        -- The plugin location string
--   -- The following keys are all optional
--   disable = boolean,           -- Mark a plugin as inactive
--   as = string,                 -- Specifies an alias under which to install the plugin
--   installer = function,        -- Specifies custom installer. See "custom installers" below.
--   updater = function,          -- Specifies custom updater. See "custom installers" below.
--   after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
--   rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
--   opt = boolean,               -- Manually marks a plugin as optional.
--   bufread = boolean,           -- Manually specifying if a plugin needs BufRead after being loaded
--   branch = string,             -- Specifies a git branch to use
--   tag = string,                -- Specifies a git tag to use. Supports '*' for "latest tag"
--   commit = string,             -- Specifies a git commit to use
--   lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
--   run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
--   requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
--   rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
--   config = string or function, -- Specifies code to run after this plugin is loaded.
--   -- The setup key implies opt = true
--   setup = string or function,  -- Specifies code to run before this plugin is loaded.
--   -- The following keys all imply lazy-loading and imply opt = true
--   cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
--   ft = string or list,         -- Specifies filetypes which load this plugin.
--   keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
--   event = string or list,      -- Specifies autocommand events which load this plugin.
--   fn = string or list          -- Specifies functions which load this plugin.
--   cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
--   module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
--                                -- with one of these module names, the plugin will be loaded.
--   module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When requiring a string which matches one of these patterns, the plugin will be loaded.
-- }
