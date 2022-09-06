local M = {}

M.servers = {
	"lemminx", -- xml
	"vimls", -- vim script
	"sqlls", -- sql
	"jedi_language_server", -- python
	"intelephense", -- php
	"marksman", -- markdown
	"sumneko_lua", -- lua
	"quick_lint_js", -- javascript
	"jsonls", -- json
	"html", -- html
	"cssls", -- css
	"clangd", -- c, c++
	"bashls", -- bash
	"awk_ls", -- awk
}

M.manson = function(mason)
	mason.setup({
		ui = {
			-- Whether to automatically check for new versions when opening the :Mason window.
			check_outdated_packages_on_open = true,

			-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
			border = "none",

			icons = {
				-- The list icon to use for installed packages.
				package_installed = "✓",
				-- The list icon to use for packages that are installing, or queued for installation.
				package_pending = "➜",
				-- The list icon to use for packages that are not installed.
				package_uninstalled = "✗",
			},

			keymaps = {
				-- Keymap to expand a package
				toggle_package_expand = "<CR>",
				-- Keymap to install the package under the current cursor position
				install_package = "i",
				-- Keymap to reinstall/update the package under the current cursor position
				update_package = "u",
				-- Keymap to check for new version for the package under the current cursor position
				check_package_version = "c",
				-- Keymap to update all installed packages
				update_all_packages = "U",
				-- Keymap to check which installed packages are outdated
				check_outdated_packages = "C",
				-- Keymap to uninstall a package
				uninstall_package = "X",
				-- Keymap to cancel a package installation
				cancel_installation = "<C-c>",
				-- Keymap to apply language filter
				apply_language_filter = "<C-f>",
			},
		},

		-- The directory in which to install packages.
		install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }),

		pip = {
			-- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
			-- and is not recommended.
			--
			-- Example: { "--proxy", "https://proxyserver" }
			install_args = {},
		},

		-- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
		-- debugging issues with package installations.
		log_level = vim.log.levels.INFO,

		-- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
		-- packages that are requested to be installed will be put in a queue.
		max_concurrent_installers = 4,

		github = {
			-- The template URL to use when downloading assets from GitHub.
			-- The placeholders are the following (in order):
			-- 1. The repository (e.g. "rust-lang/rust-analyzer")
			-- 2. The release version (e.g. "v0.3.0")
			-- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
			download_url_template = "https://github.com/%s/releases/download/%s/%s",
		},
	})
end

M.manson_lspconfig = function(mlsp)
	mlsp.setup({
		-- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
		-- This setting has no relation with the `automatic_installation` setting.
		ensure_installed = M.servers,

		-- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
		-- This setting has no relation with the `ensure_installed` setting.
		-- Can either be:
		--   - false: Servers are not automatically installed.
		--   - true: All servers set up via lspconfig are automatically installed.
		--   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
		--       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
		automatic_installation = false,
	})
end

M.lspconfig = function (lspc)
    for _, server in ipairs(M.servers) then
        lspc[server].setup({})
    end
end

M.lspsaga = function(lsps)
	lsps.init_lsp_saga({
		-- Options with default value
		-- "single" | "double" | "rounded" | "bold" | "plus"
		border_style = "single",
		--the range of 0 for fully opaque window (disabled) to 100 for fully
		--transparent background. Values between 0-30 are typically most useful.
		saga_winblend = 0,
		-- when cursor in saga window you config these to move
		move_in_saga = { prev = "<C-p>", next = "<C-n>" },
		-- Error, Warn, Info, Hint
		-- use emoji like
		-- { "🙀", "😿", "😾", "😺" }
		-- or
		-- { "😡", "😥", "😤", "😐" }
		-- and diagnostic_header can be a function type
		-- must return a string and when diagnostic_header
		-- is function type it will have a param `entry`
		-- entry is a table type has these filed
		-- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
		diagnostic_header = { " ", " ", " ", "ﴞ " },
		-- show diagnostic source
		show_diagnostic_source = true,
		-- add bracket or something with diagnostic source, just have 2 elements
		diagnostic_source_bracket = {},
		-- preview lines of lsp_finder and definition preview
		max_preview_lines = 10,
		-- use emoji lightbulb in default
		code_action_icon = "💡",
		-- if true can press number to execute the codeaction in codeaction window
		code_action_num_shortcut = true,
		-- same as nvim-lightbulb but async
		code_action_lightbulb = {
			enable = false,
			enable_in_insert = true,
			cache_code_action = true,
			sign = true,
			update_time = 150,
			sign_priority = 20,
			virtual_text = true,
		},
		-- finder icons
		finder_icons = {
			def = "  ",
			ref = "諭 ",
			link = "  ",
		},
		-- finder do lsp request timeout
		-- if your project big enough or your server very slow
		-- you may need to increase this value
		finder_request_timeout = 1500,
		-- set antoher colorscheme in preview window
		finder_preview_hl_ns = 0,
		finder_action_keys = {
			open = "o",
			vsplit = "s",
			split = "i",
			tabe = "t",
			quit = "q",
		},
		code_action_keys = {
			quit = "q",
			exec = "<CR>",
		},
		definition_action_keys = {
			quit = "q",
		},
		rename_action_quit = "<C-c>",
		rename_in_select = true,
		definition_preview_icon = "  ",
		-- show symbols in winbar must nightly
		symbol_in_winbar = {
			in_custom = false,
			enable = false,
			separator = " ",
			show_file = true,
			click_support = false,
		},
		-- show outline
		show_outline = {
			win_position = "right",
			--set special filetype win that outline window split.like NvimTree neotree
			-- defx, db_ui
			win_with = "",
			win_width = 30,
			auto_enter = true,
			auto_preview = true,
			virt_text = "┃",
			jump_key = "o",
			-- auto refresh when change buffer
			auto_refresh = true,
		},
		-- custom lsp kind
		-- usage { Field = 'color code'} or {Field = {your icon, your color code}}
		custom_kind = {},
		-- if you don't use nvim-lspconfig you must pass your server name and
		-- the related filetypes into this table
		-- like server_filetype_map = { metals = { "sbt", "scala" } }
		server_filetype_map = {},
	})
end

return M
