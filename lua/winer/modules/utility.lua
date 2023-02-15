local m = require("winer.utils").map

return {
    {
        "jackMort/ChatGPT.nvim",
        opts = {
            yank_register = "+",
            settings_window = {
                border = {
                    style = "single",
                },
            },
            chat_window = {
                border = {
                    style = "single",
                },
            },
            chat_input = {
                border = {
                    style = "single",
                },
            },
        },
        keys = {
            { m.ld("Cc"), m.cmd("ChatGPT"), desc = "[C]hatGPT" },
        },
    },
    {
        "anuvyklack/hydra.nvim",
        dependencies = {
            {
                "jbyuki/venn.nvim",
                {
                    -- FIX: integrate with hydra
                    "jghauser/fold-cycle.nvim",
                    keys = {
                        { m.ld("Fo"), m.cmd("lua require('fold-cycle').open()"), desc = "[O]pen Next" },
                        { m.ld("FO"), m.cmd("lua require('fold-cycle').open_all()"), desc = "[O]pen All" },
                        { m.ld("Fc"), m.cmd("lua require('fold-cycle').close()"), desc = "[C]lose Next" },
                        { m.ld("FC"), m.cmd("lua require('fold-cycle').close_all()"), desc = "[C]lose All" },
                    },
                },
            },
        },
        keys = {
            { m.ld("Hv"), m.cmd("lua require('winer.hydras').activate_hydra('venn')"), desc = "[V]enn Diagrams" },
            { m.ld("HH"), m.cmd("lua require('winer.hydras').activate_hydra()"), desc = "Choose [H]ydra" },
        },
    },
    {
        "toppair/peek.nvim",
        build = "deno task --quiet build:fast",
        keys = {
            {
                m.ld("Cp"),
                function()
                    if require("peek").is_open() then
                        require("peek").close()
                    else
                        require("peek").open()
                    end
                end,
                desc = "Toggle [P]review",
            },
        },
        config = function()
            require("peek").setup({
                syntax = false,
                app = "browser",
            })
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        keys = {
            {
                m.ld("e"),
                function()
                    vim.cmd("NvimTreeToggle")
                end,
                desc = "Toggl[e] NvimTree",
            },
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
                            { key = "s", cb = tree_cb("split") },
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
                renderer = { special_files = { "Makefile", "README.md", "readme.md" } },
                update_focused_file = {
                    enable = true,
                    update_root = true,
                },
                actions = {
                    file_popup = {
                        open_win_config = {
                            relative = "cursor",
                            border = "single",
                        },
                    },
                    open_file = {
                        window_picker = {
                            exclude = {
                                filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                                buftype = { "nofile", "terminal", "help" },
                            },
                        },
                    },
                },
            })
        end,
    },
    {
        "stevearc/oil.nvim",
        keys = {
            { m.ld("Co"), m.cmd("lua require('oil').open_float()"), desc = "[O]il" },
        },
        opts = {
            columns = {
                "icon",
                -- "permissions",
                "size",
                -- "mtime",
            },
            skip_confirm_for_simple_edits = true,
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = "actions.select_vsplit",
                ["<C-h>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["g."] = "actions.toggle_hidden",
            },
            use_default_keymaps = true,
            view_options = {
                show_hidden = true,
            },
            float = {
                border = "single",
                win_options = {
                    winblend = 10,
                },
            },
        },
    },
    {
        -- FIX: need config
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup()
        end,
    },
    { "jcdickinson/codeium.nvim", event = "InsertEnter" },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "BufRead",
        keys = {
            { m.ld("ft"), m.cmd("TodoTelescope"), desc = "Find [T]odos" },
        },
        config = function()
            require("todo-comments").setup({
                keywords = {
                    -- FIX = {
                    -- icon = " ", -- icon used for the sign, and in search results
                    -- color = "error", -- can be a hex color, or a named color (see below)
                    -- alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                    -- signs = false, -- configure signs for some keywords individually
                    -- },
                },
                merge_keywords = true,
            })
        end,
    },
    {
        "is0n/fm-nvim",
        enabled = true,
        keys = {
            { m.ld("gL"), m.cmd("Lazygit"), desc = "[L]azygit" },
        },
        opts = { ui = { float = { border = "single" } } },
    },
}
