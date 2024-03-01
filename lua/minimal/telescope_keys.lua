local m = require("minimal.util").map

return {
    base = {
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
        { m.ld("fb"), m.lua("require('telescope.builtin').buffers()"),  desc = "[B]uffers" },
        {
            m.ld("fh"),
            m.lua("require('telescope.builtin').help_tags()"),
            desc = "[H]elp Tags",
        },
        { m.ld("fl"),  m.cmd("lua require('telescope').extensions.menufacture.live_grep()"), desc = "[L]ive Grep" },
        {
            m.ld("fp"),
            function()
                require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
            end,
            desc = "[P]lugin files",
        },
        { m.ld("fgb"), m.cmd("Telescope git_branches"),                                      desc = "[B]ranches" },
        { m.ld("fgc"), m.cmd("Telescope git_commits"),                                       desc = "[C]ommits" },
        { m.ld("fgf"), m.cmd("Telescope git_bcommits"),                                      desc = "[F]ile Commits" },
    },
    git_conflicts = {
        {
            m.ld("fgC"),
            m.lua("require('telescope').extensions.conflicts.conflicts({})"),
            desc = "[C]onflicts",
        },
    }
}
