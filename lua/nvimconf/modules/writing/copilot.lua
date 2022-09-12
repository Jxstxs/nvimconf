-- vim.cmd [[ imap <silent><script><expr> <C-m> copilot#Accept("\<CR>") ]]
-- vim.g.copilot_no_tab_map = true

return function(copilot)
    copilot.setup({
        cmp = {
            enabled = true,
            method = "getCompletionsCycling",
        },
        panel = { -- no config options yet
            enabled = true,
        },
        ft_disable = {},
        copilot_node_command = 'node', -- Node version must be < 18
        plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
        server_opts_overrides = {},
    })
end
