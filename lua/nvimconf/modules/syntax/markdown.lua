return function()
    vim.g.markdown_syntax_conceal = 3
    vim.g.markdown_minlines = 100
    vim.g.markdown_fenced_languages = {'html', 'python', 'bash=sh', 'lua'}
end
