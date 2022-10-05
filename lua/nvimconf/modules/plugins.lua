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
    use("wbthomason/packer.nvim") -- Config Complete

    -- Things that everybody needs
    use({ "nvim-lua/plenary.nvim" })
    use({ "kyazdani42/nvim-web-devicons" })
    use({ "JoosepAlviste/nvim-ts-context-commentstring" })
    use({ "nvim-treesitter/nvim-treesitter" }) -- Config Complete

    -- Safe imports
    use({ "miversen33/import.nvim" }) -- Config Complete

    -- Faster Loading
    use({ "lewis6991/impatient.nvim" }) -- No need for Config

    -- Theme
    use({ "catppuccin/nvim", as = "catppuccin" }) -- Config Complete

    -- File Management / Ranger
    use({ "kevinhwang91/rnvimr" }) -- Config Complete
    use({ "kyazdani42/nvim-tree.lua" }) -- Config Complete

    -- Lsp Stuff
    use({ "neovim/nvim-lspconfig" }) -- Config Complete
    use({ "williamboman/mason.nvim" }) -- Config Complete
    use({ "williamboman/mason-lspconfig.nvim" }) -- Config Complete
    use({ "glepnir/lspsaga.nvim" }) -- Config Configure

    -- Cmp Stuff
    use({ "hrsh7th/nvim-cmp" }) -- Not even Done
    use({ "hrsh7th/cmp-path" })
    use({ "f3fora/cmp-spell" })
    use({ "hrsh7th/cmp-nvim-lsp-signature-help" })
    -- use({ "dmitmel/cmp-digraphs" })
    use({ "hrsh7th/cmp-nvim-lua" })
    -- use({ "hrsh7th/cmp-emoji" })
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-buffer" })
    -- use({ "zbirenbaum/copilot-cmp", module = "copilot_cmp" })
    -- use({ "tzachar/cmp-tabnine", commit = "f2ea9c0824d389d588966c64c146d324138a443c" })
    -- use({ "petertriho/cmp-git" })

    -- copilot
    -- use({ "zbirenbaum/copilot.lua" })
    -- use({ "github/copilot.vim" })

    -- Ui Stuff
    use({ "akinsho/bufferline.nvim" }) -- Config Complete
    use({ "lukas-reineke/indent-blankline.nvim" }) -- Config Complete
    use({ "m-demare/hlargs.nvim" }) -- Config Complete
    use({ "stevearc/dressing.nvim" }) -- Config Complete
    use({ "akinsho/toggleterm.nvim" }) -- Config Complete
    use({ "ahmedkhalf/project.nvim" }) -- Config Complete
    use({ "goolord/alpha-nvim" }) -- Config Complete
    use({ "nvim-lualine/lualine.nvim" }) -- Config Complete
    use({ "nvim-treesitter/nvim-treesitter-context" }) -- Config Complete
    use({ "kevinhwang91/nvim-ufo" }) -- IDK really
    use({ "folke/todo-comments.nvim" }) -- Todo Comments

    -- Telescope
    use({ "BurntSushi/ripgrep" }) -- No Config
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    })
    use({ "nvim-telescope/telescope.nvim" }) -- Not even Done

    -- Key related
    use({ "folke/which-key.nvim" }) -- Config Complete

    -- Git Stuff
    use({ "kdheepak/lazygit.nvim" }) -- Config Complete
    use({ "ThePrimeagen/git-worktree.nvim" }) -- Config Complete
    use({ "lewis6991/gitsigns.nvim" }) -- Config Complete

    -- Writing Stuff
    use({ "windwp/nvim-autopairs" }) -- Config Complete
    use({ "numToStr/Comment.nvim", commit = "2c26a00f32b190390b664e56e32fd5347613b9e2" }) -- Config Complete (still need to watch at new releases)
    use({ "windwp/nvim-ts-autotag" })

    -- Wakatime
    use({ "wakatime/vim-wakatime" }) -- No Config Needed

    -- Own plugins
    use({ "/home/julius/.gits/personal/nvim-plugs/keystack.nvim" }) -- Not even Done
    -- use { "/home/julius/gits/personal/nvim-plugs/mdbook.nvim" }
    use({ "/home/julius/.gits/personal/nvim-plugs/jaw.nvim/ti" }) -- Still Development

    -- Snippet Stuff
    use({ "L3MON4D3/LuaSnip" }) -- Not even Done
    -- use({ "SirVer/ultisnips", commit = "4f5249b2a6f6308377cb2bf734974a4e6f8a960e" })

    -- Markdown Stuff
    -- use({ "preservim/vim-markdown" }) -- Config Base
    use({ "tpope/vim-markdown" })
    use({ "jbyuki/venn.nvim" })
    use({ "dhruvasagar/vim-table-mode" })

    -- Extra Stuff (School)
    use({ "itchyny/calendar.vim" }) -- Need some time
    use({ "uga-rosa/translate.nvim" }) -- IDK

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
