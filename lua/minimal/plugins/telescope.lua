local m = require("minimal.util").map

return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "molecule-man/telescope-menufacture",
            "debugloop/telescope-undo.nvim",
            "Snikimonkd/telescope-git-conflicts.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        keys = require("minimal.telescope_keys"),
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
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    menufacture = {
                        mappings = {
                            main_menu = { [{ "i", "n" }] = "<C-e>" },
                        },
                    },
                },
            })
            ts.load_extension("fzf")
            ts.load_extension("noice")
            ts.load_extension("menufacture")
            ts.load_extension("undo")
            ts.load_extension("conflicts")
        end,
    },
}
