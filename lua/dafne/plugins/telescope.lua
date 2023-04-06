local m = require("dafne.util").map

return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "molecule-man/telescope-menufacture",
            "debugloop/telescope-undo.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        keys = {
            {
                m.ld("ff"),
                m.lua("require('telescope').extensions.menufacture.find_files()"),
                desc = "[F]ind Files",
            },
            {
                m.ld("fr"),
                m.lua("require('telescope.builtin').resume()"),
                desc = "[R]esume Last",
            },
            { m.ld("fo"), m.lua("require('telescope.builtin').oldfiles()"), desc = "[O]ldfiles" },
            { m.ld("fb"), m.lua("require('telescope.builtin').buffers()"), desc = "[B]uffers" },
            {
                m.ld("fh"),
                m.lua("require('telescope.builtin').help_tags()"),
                desc = "[H]elp Tags",
            },
            {
                m.ld("fu"),
                m.lua("require('telescope').extensions.undo.undo()"),
                desc = "Undo",
            },
            {
                m.ld("fd"),
                m.cmd("Telescope diagnostics"),
                desc = "[D]iagnostics",
            },
            { m.ld("fl"), m.cmd("lua require('telescope').extensions.menufacture.live_grep()"), desc = "[L]ive Grep" },
            {
                m.ld("fp"),
                function()
                    require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
                end,
                desc = "[P]lugin files",
            },
            { m.ld("fgb"), m.cmd("Telescope git_branches"), desc = "[B]ranches" },
            { m.ld("fgc"), m.cmd("Telescope git_commits"), desc = "[C]ommits" },
            { m.ld("fgf"), m.cmd("Telescope git_bcommits"), desc = "[F]ile Commits" },
            {
                m.ld("f<CR>"),
                m.cmd("lua require('telescope').extensions.menufacture.find_files()"),
                desc = "[F]ind Files",
            },
        },
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
        end,
    },
}
