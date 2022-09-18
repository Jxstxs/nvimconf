return function(cmp)
	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
				require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
				-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			-- { name = 'luasnip' }, -- For luasnip users.
            { name = "buffer" },
            { name = "nvim_lua" },
			{ name = "path" },
			{ name = "nvim_lsp_signature_help" },
			-- { name = "spell" },
			-- { name = "emoji" },
			-- { name = "copilot" },
		}),

		--	enabled = function()
		--		-- disable completion in comments
		--		local context = require("cmp.config.context")
		--		-- keep command mode completion enabled when cursor is in a comment
		--		if vim.api.nvim_get_mode().mode == "c" then
		--			return true
		--		else
		--			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		--		end
		--	end,
	})

	-- Set configuration for specific filetype.
	cmp.setup.filetype("gitcommit", {
		sources = cmp.config.sources({
			{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
		}, {
			{ name = "buffer" },
		}),
	})

	-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})

	-- Set up lspconfig.
	local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
	-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
	for _, server in ipairs(require("nvimconf.modules.lsp.lsp").servers) do
		require("lspconfig")[server].setup({
			capabilities = capabilities,
		})
	end
end
