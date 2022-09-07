return function(lspc)
	for _, server in ipairs(require("nvimconf.modules.lsp.lsp").servers) do
		lspc[server].setup({})
	end
end
