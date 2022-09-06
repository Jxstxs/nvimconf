local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack"
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path .. "packer-test/start/packer.nvim",
  }
  vim.cmd [[packadd packer.nvim]]
end

local status, packer = pcall(require, "packer")
if not status then
  return
end

-- Configure Packer
packer.init(require "nvimconf.modules.packer")

return packer.startup(function(use)
  use "wbthomason/packer.nvim"

  -- Things that everybody needs
  use { "nvim-lua/plenary.nvim", commit = "4b66054e75356ac0b909bbfee9c682e703f535c2" }
  use { "kyazdani42/nvim-web-devicons" } -- no need for commit wont change
  use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269" }
  use { "nvim-treesitter/nvim-treesitter", commit = "518e27589c0463af15463c9d675c65e464efc2fe" }

  -- Safe imports
  use { "miversen33/import.nvim", commit = "cd3be6736a78aa07357d97efa71e7ab5e542532b" }

  -- Faster Loading
  use { "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" }

  -- Theme
  use { "catppuccin/nvim", as = "catppuccin" }

  -- File Management / Ranger
  use { "kevinhwang91/rnvimr" }
  use { "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" }

  -- Lsp Stuff
  use { "neovim/nvim-lspconfig", commit = "0fafc3ef648bd612757630097c96b725a36a0476" }
  use { "williamboman/mason.nvim", commit = "b109b498650fae746b3f10d09fa08cd9cc8ad674" }
  use { "williamboman/mason-lspconfig.nvim", commit = "980f83609cd58e2069dda89a05367f81a48bdf2f" }
  use { "glepnir/lspsaga.nvim", commit = "551811a33f26040ae217d27f212a9b88165e4633" }

  -- Cmp Stuff
  use { "hrsh7th/nvim-cmp", commit = "33fbb2c3d2c512bd79ea03cf11fea405cbe618a9" }
  use { "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" }
  use { "f3fora/cmp-spell", commit = "5602f1a0de7831f8dad5b0c6db45328fbd539971" }
  use { "hrsh7th/cmp-nvim-lsp-signature-help", commit = "3dd40097196bdffe5f868d5dddcc0aa146ae41eb" }
  use { "dmitmel/cmp-digraphs", commit = "5efc1f0078d7c5f3ea1c8e3aad04da3fd6e081a9" }
  use { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" }
  use { "hrsh7th/cmp-emoji", commit = "19075c36d5820253d32e2478b6aaf3734aeaafa0" }
  -- use({ "tzachar/cmp-tabnine", commit = "f2ea9c0824d389d588966c64c146d324138a443c" })
  use { "petertriho/cmp-git", commit = "fae6cdb407ad6c63a0b1928670bad1a67a55b887" }

  -- Ui Stuff
  use { "akinsho/bufferline.nvim", commit = "938908fc8db120d907bda23f6744202f534f63e4" }
  use { "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" }
  use { "m-demare/hlargs.nvim", commit = "71f3c467c426d2ded2491cc280e21cf8c3330d8f" }
  use { "stevearc/dressing.nvim", commit = "9cdb3e0f0973447b940b35d3175dc780301de427" }
  use { "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" }
  use { "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" }
  use { "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" }
  use { "nvim-lualine/lualine.nvim", commit = "3362b28f917acc37538b1047f187ff1b5645ecdd" }
  use { "nvim-treesitter/nvim-treesitter-context" }
  use { "kevinhwang91/nvim-ufo" }

  -- Telescope
  use { "nvim-telescope/telescope.nvim", commit = "d96eaa914aab6cfc4adccb34af421bdd496468b0" }

  -- Key related
  use { "folke/which-key.nvim", commit = "f11260251ad942ba1635db9bc25c2efaf75caf0a" }
  use { "mrjones2014/legendary.nvim", commit = "bb997500c454a470dc029c054d66f6d698404f2c" }

  -- Git Stuff
  use { "kdheepak/lazygit.nvim", commit = "9c73fd69a4c1cb3b3fc35b741ac968e331642600" }
  use { "ThePrimeagen/git-worktree.nvim", commit = "d7f4e2584e81670154f07ca9fa5dd791d9c1b458" }
  use { "lewis6991/gitsigns.nvim", commit = "c18e016864c92ecf9775abea1baaa161c28082c3" }

  -- Writing Stuff
  use { "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" }
  use { "numToStr/Comment.nvim", commit = "2c26a00f32b190390b664e56e32fd5347613b9e2" }

  -- Wakatime
  use { "wakatime/vim-wakatime" }

  -- Own plugins
  use { "/home/julius/gits/personal/nvim-plugs/keystack.nvim" }
  -- use { "/home/julius/gits/personal/nvim-plugs/mdbook.nvim" }
  use { "/home/julius/gits/personal/nvim-plugs/jaw.nvim" }

  -- Snippet Stuff
  -- use({ "L3MON4D3/LuaSnip", commit = "a45cd5f4d9dea7c64b37fa69dea91e46bbbe9671" })
  -- use({ "SirVer/ultisnips", commit = "4f5249b2a6f6308377cb2bf734974a4e6f8a960e" })

  -- Markdown Stuff
  use { "preservim/vim-markdown" }
  use { "jbyuki/venn.nvim" }
  use { "dhruvasagar/vim-table-mode" }

  -- Extra Stuff (School)
  use { "renerocksai/calendar-vim" }
  use { "uga-rosa/translate.nvim" }

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
