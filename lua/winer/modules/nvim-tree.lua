local m = require("winer.utils").map

return {
    "nvim-tree/nvim-tree.lua",
    keys = {
        { m.ld("e"), function() vim.cmd("NvimTreeToggle") end, desc = "Toggl[e] NvimTree" },
    },
    config = function()
        local tree_cb = require("nvim-tree.config").nvim_tree_callback

        require("nvim-tree").setup({
            auto_reload_on_write = true,
            disable_netrw = true,
            hijack_netrw = true,
            view = {
                side = "left",
                mappings = {
                    custom_only = false,
                    list = {
                        { key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
                        { key = "h", cb = tree_cb("close_node") },
                        { key = "v", cb = tree_cb("vsplit") },
                    },
                },
                float = {
                    enable = true,
                    open_win_config = {
                        relative = "editor",
                        border = "rounded",
                    },
                },
            },
            sync_root_with_cwd = true,
            view = { float = {
                enable = true,
                quit_on_focus_loss = false,
            } },
            renderer = { special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" }, },
            update_focused_file = {
                enable = true,
                update_root = true,
            },
            actions = {
                file_popup = { open_win_config = {
                    relative = "cursor",
                    border = "single",
                } },
                open_file = { window_picker = { exclude = {
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                    buftype = { "nofile", "terminal", "help" },
                } } },
            },
        })
    end
}
