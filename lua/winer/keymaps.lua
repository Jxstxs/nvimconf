
local map = require("winer.utils").map

local M = {
    base = function()
        vim.keymap.set("", "<Space>", "<NOP>")
        vim.g.mapleader = " "

        map.n("<leader>w", map.cmd("w"))

        map.n("<C-h>", "<C-w>h")
        map.n("<C-j>", "<C-w>j")
        map.n("<C-k>", "<C-w>k")
        map.n("<C-l>", "<C-w>l")

        -- Resizing Hier

        map.v("p", "_dP")
        map.v("<", "<gv")
        map.v(">", ">gv")


        map.i("jj", "<ESC>")

        map.i("<C-h>", "<Left>")
        map.i("<C-j>", "<Down>")
        map.i("<C-k>", "<Up>")
        map.i("<C-l>", "<Right>")
    end,
    keys = {
        n = {
            opts = {
                mode = "n",
                prefix = "<leader>",
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = false,
            },
            mappings = {
                -- Base
                w = { map.cmd("w!"), "Save" },
                q = { map.cmd("bdelete!"), "Close Buffer" },
                Q = { map.cmd("q!"), "Quit Nvim" },
                h = { map.cmd("nohl"), "Clear Highlights" },
                -- e = { map.cmd("RnvimrToggle"), "Ranger" },
                e = { map.cmd("NvimTreeToggle"), "Neotree" },
                --[[ c = { map.cmd("lua require('Comment.api').toggle_current_linewise()"), "Comment" }, ]]
                c = { map.cmd("normal gcc"), "Comment" },
                m = { map.cmd("lua require('keystack').push('page_moving')"), "Movement" },
                d = { map.cmd("Lspsaga lsp_finder"), "Definition and Reference" },
                T = { map.cmd("Twilight"), "Toggle Twilight" },

                -- Lsp Stuff
                l = {
                    name = "Lsp",
                    r = { map.cmd("lua vim.lsp.buf.rename()"), "Rename" },
                    f = { map.cmd("lua vim.lsp.buf.format({async=true})"), "Format Buffer" },
                    D = { map.cmd("Lspsaga preview_definition"), "Preview Definition" },
                    a = { map.cmd("Lspsaga code_action"), "Code Actions" },
                    h = { map.cmd("Lspsaga hover_doc"), "Documentation" },
                    d = { map.cmd("Lspsaga show_line_diagnostics"), "Show Diagnostics" },
                    o = { map.cmd("LSoutlineToggle"), "Code Outline" },
                    m = { map.cmd("lua require('keystack').push('dianostic_moving')"), "Diagnostics Movement" },
                },

                -- Git Stuff
                g = {
                    name = "Git",
                    l = { map.cmd("lua require('winer.utils').toggle_lazygit()"), " Open LazyGit" },
                    -- L = {
                    --     name = "LazyGit",
                    --     C = { map.cmd("LazyGitConfig"), "LazyGit Config" },
                    --     p = { map.cmd("LazyGitFilter"), "Project Commits" },
                    --     c = { map.cmd("LazyGitFilterCurrentFile"), "Current Files Commit" },
                    -- },
                    p = { map.cmd("Gitsigns preview_hunk"), "Preview Hunk" },
                    d = { map.cmd("Gitsigns diff_hunk"), "Preview Diff" },
                    b = { map.cmd("Gitsigns blame_line"), "Blame Current Line" },
                    B = { map.cmd("Gitsigns toggle_current_line_blame"), "Toggle Blaming" },
                },

                -- Worktree Stuff
                W = {
                    name = "Worktrees",
                    s = { map.cmd("Telescope git_worktree git_worktrees"), "Switch Worktrees" },
                    c = { map.cmd("Telescope git_worktree create_git_worktree"), "Create Worktree" }
                },

                -- Usefull for Plugin Dev
                U = {
                    name = "Plugin Dev",
                    r = { reload_module, "Reload Module" },
                },

                -- Ufo Folds
                u = {
                    name = "Ufo",
                    p = {
                        function()
                            local winid = require('ufo').peekFoldedLinesUnderCursor()
                            if not winid then vim.lsp.buf.hover() end
                        end, "Peek Lines"
                    },
                    o = { function() require("ufo").openAllFolds() end, "Open All Folds" },
                    c = {
                        function() require("ufo").closeAllFolds() end,
                        "Close All Folds"
                    }
                },

                -- Finder Stuff
                f = {
                    name = "Finder",
                    t = { map.cmd("TodoTelescope"), "Find Todos" },
                    b = { map.cmd("Telescope buffers"), "Find Buffers" },
                    f = { map.cmd("Telescope find_files"), "Find Files" },
                    h = { map.cmd("Telescope help_tags"), "Help Tags" },
                    n = { map.cmd("Telescope notify"), "Notifications" },
                    g = { map.cmd("Telescope live_grep"), "Live Grep" },
                    p = { map.cmd("Telescope projects"), "Projects" },
                    m = { map.cmd("Telescope marks"), "Marks" },
                    M = { map.cmd("Telescope man_pages"), "Man Pages" },
                    k = { map.cmd("Telescope keymaps"), "Keymaps" },
                    v = { map.cmd("Telescope vim_options"), "Vim Options" },
                    c = { map.cmd("Telescope commands"), "Commands" },
                    d = { map.cmd("Telescope diagnostics"), "Diagnostics" },
                    o = { map.cmd("Telescope oldfiles"), "Recent Files" },
                    l = {
                        name = "Lsp",
                        D = { map.cmd("Telescope lsp_definitions"), "Definitions" },
                        r = { map.cmd("Telescope lsp_references"), "References" },
                    },
                    G = {
                        name = "Git",
                        b = { map.cmd("Telescope git_branches"), "Branches" },
                        c = { map.cmd("Telescope git_commits"), "Commits" },
                        C = { map.cmd("Telescope git_bcommits"), "Buffer Commits" },
                    },
                },

                n = {
                    name = "Neorg Functions",
                    e = {
                        name = "Export",
                        f = { function() require("nvimconf.modules.norg.scholr").exp_file(true) end, "Current File"},
                        F = { function() require("nvimconf.modules.norg.scholr").exp_file(false) end, "File"},
                        d = { function() require("nvimconf.modules.norg.scholr").exp_dir(true) end, "Current Workspace"},
                        D = { function() require("nvimconf.modules.norg.scholr").exp_dir(false) end, "Workspace"},
                    },
                    i = {
                        name = "Insert",
                        t = { function() require("nvimconf.modules.norg").ins_tab() end, "Table"},
                    },
                },
            },
        },
        v = {
            opts = {
                mode = "v",
                prefix = "<leader>",
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = false,
            },
            mappings = {
                --[[ c = { "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" }, ]]
                c = { "gb", "Comment" },
                -- a = { "<cmd>lua vim.lsp.buf.range_code_action()<CR>", "Code Action" },
                a = { "<cmd><C-U>Lspsaga range_code_action<CR>", "Code Actions" },
                f = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Format" },
            },
        },
    }
}

return M
