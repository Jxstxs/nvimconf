return function(indent)
	vim.opt.list = true
	vim.opt.listchars:append("eol:↴")
	vim.opt.listchars:append("space:⋅")

	indent.setup({
		show_end_of_line = true,
		space_char_blankline = " ",
		show_current_context = true,
		show_current_context_start = true,
	})
end
