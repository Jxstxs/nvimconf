return function(norg)
    norg.setup({
        load = {
            ["core.defaults"] = {},
            ["core.norg.esupports.metagen"] = {
                config = {
                    type = "auto",
                }
            },
            ["core.presenter"] = { config = { zen_mode = "truezen" } },
            ["core.export"] = {},
            ["core.norg.concealer"] = {},
            ["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
            ["core.integrations.telescope"] = {},
            ["core.norg.dirman"] = {
                config = {
                    workspaces = {
                        notes = "~/.repos/personal/notes/",
                        scholr = "~/.repos/personal/scholr/",
                    },
                    index = "index.norg", -- The name of the main (root) .norg file
                }
            },
            ["core.norg.manoeuvre"] = { config = {} },
        }
    })
end
