return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        keys = require("minimal.telescope_keys").base,
        config = function()
            local ts = require("telescope")
            local actions = require("telescope.actions")
            ts.setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-h>"] = "which_key",
                            ["<Down>"] = actions.cycle_history_next,
                            ["<Up>"] = actions.cycle_history_prev,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                        },
                    },
                    layout_strategy = "vertical",
                    layout_config = {
                        vertical = {
                            preview_cutoff = 1,
                            preview_height = 0.7,

                            width = 0.9,
                            height = 0.9,
                        }
                    }
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })
            ts.load_extension("fzf")
            ts.load_extension("noice")
        end,
    },
}
