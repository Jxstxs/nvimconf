local m = require("winer.utils").map

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
        { m.ld("ff"), m.cmd("Telescope find_files"), desc = "[F]ind files" },
        { m.ld("fo"), m.cmd("Telescope oldfiles"), desc = "[O]ld files" },
        { m.ld("fb"), m.cmd("Telescope buffers"), desc = "[B]uffers" },
        { m.ld("fh"), m.cmd("Telescope help_tags"), desc = "[H]elp Tags" },
        { m.ld("fn"), m.cmd("Telescope notify"), desc = "[N]otification History" },
        { m.ld("fm"), m.cmd("Telescope man_pages"), desc = "[M]an" },
        { m.ld("fk"), m.cmd("Telescope keymaps"), desc = "[K]eymaps" },
        { m.ld("fc"), m.cmd("Telescope commands"), desc = "[C]ommands" },
        { m.ld("fd"), m.cmd("Telescope diagnostics"), desc = "[D]iagnostics" },
        { m.ld("fl"), m.cmd("Telescope live_grep"), desc = "[G]rep" },
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
            },
        })
        ts.load_extension("fzf")
    end,
}
