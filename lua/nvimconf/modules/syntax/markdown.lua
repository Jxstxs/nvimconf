return function(markdown)
	vim.g.vim_markdown_folding_disabled = 0
	vim.g.vim_markdown_folding_style_pythonic = 0
	vim.g.vim_markdown_override_foldtext = 0
	vim.g.vim_markdown_folding_level = 6
	vim.g.vim_markdown_no_default_key_mappings = 1
	vim.g.vim_markdown_toc_autofit = 1
	vim.g.vim_markdown_emphasis_multiline = 0
	vim.g.vim_markdown_conceal = 2
	vim.g.vim_markdown_conceal_code_blocks = 0
	vim.g.vim_markdown_fenced_languages = { "csharp=cs" }
	vim.g.vim_markdown_follow_anchor = 1
	vim.g.vim_markdown_anchorexpr = "'<<'.v:anchor.'>>'"
	vim.g.vim_markdown_math = 1
	vim.g.vim_markdown_frontmatter = 1
	vim.g.vim_markdown_toml_frontmatter = 1
	vim.g.vim_markdown_json_frontmatter = 1
	vim.g.vim_markdown_strikethrough = 1
	vim.g.vim_markdown_new_list_item_indent = 0
	vim.g.vim_markdown_no_extensions_in_markdown = 1
	vim.g.vim_markdown_autowrite = 1
	vim.g.vim_markdown_auto_extension_ext = "txt"
	vim.g.vim_markdown_auto_insert_bullets = 0
	vim.g.vim_markdown_new_list_item_indent = 0
	vim.g.vim_markdown_edit_url_in = "tab"
end
