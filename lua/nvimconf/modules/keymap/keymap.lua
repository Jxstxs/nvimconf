local M = {}

local key = require("nvimconf.core.keys")
local nmap = key.nmap
local cmd = key.cmd
local opts = key.opts({ silent = true })

nmap({
    { "<S-h>", cmd("BufferLineCyclePrev"), opts },
    { "<S-l>", cmd("BufferLineCycleNext"), opts },
})

local reload_module = function()
    vim.ui.input({ prompt = "Reload: " }, function(input)
        if input ~= nil then
            require("plenary.reload").reload_module(input)
        end
    end)
end

M.keys = {
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
            w = { cmd("w!"), "Save" },
            q = { cmd("bdelete!"), "Close Buffer" },
            Q = { cmd("q!"), "Quit Nvim" },
            h = { cmd("nohl"), "Clear Highlights" },
            e = { cmd("RnvimrToggle"), "Ranger" },
            E = { cmd("NvimTreeToggle"), "Neotree" },
            --[[ c = { cmd("lua require('Comment.api').toggle_current_linewise()"), "Comment" }, ]]
            c = { cmd("normal gcc"), "Comment" },
            m = { cmd("lua require('keystack').push('page_moving')"), "Movement" },
            d = { cmd("Lspsaga lsp_finder"), "Definition and Reference" },

            -- Lsp Stuff
            l = {
                name = "Lsp",
                r = { cmd("lua vim.lsp.buf.rename()"), "Rename" },
                f = { cmd("lua vim.lsp.buf.format({async=true})"), "Format Buffer" },
                D = { cmd("Lspsaga preview_definition"), "Preview Definition" },
                a = { cmd("Lspsaga code_action"), "Code Actions" },
                h = { cmd("Lspsaga hover_doc"), "Documentation" },
                d = { cmd("Lspsaga show_line_diagnostics"), "Show Diagnostics" },
                o = { cmd("LSoutlineToggle"), "Code Outline" },
                m = { cmd("lua require('keystack').push('dianostic_moving')"), "Diagnostics Movement" },
            },

            -- Git Stuff
            g = {
                name = "Git",
                l = { cmd("LazyGit"), " Open LazyGit" },
                L = {
                    name = "LazyGit",
                    C = { cmd("LazyGitConfig"), "LazyGit Config" },
                    p = { cmd("LazyGitFilter"), "Project Commits" },
                    c = { cmd("LazyGitFilterCurrentFile"), "Current Files Commit" },
                },
                p = { cmd("Gitsigns preview_hunk"), "Preview Hunk" },
                d = { cmd("Gitsigns diff_hunk"), "Preview Diff" },
                b = { cmd("Gitsigns blame_line"), "Blame Current Line" },
                B = { cmd("Gitsigns toggle_current_line_blame"), "Toggle Blaming" },
            },

            -- Worktree Stuff
            W = {
                name = "Worktrees",
                s = { cmd("Telescope git_worktree git_worktrees"), "Switch Worktrees" },
                c = { cmd("Telescope git_worktree create_git_worktree"), "Create Worktree" }
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
                t = { cmd("TodoTelescope"), "Find Todos" },
                b = { cmd("Telescope buffers"), "Find Buffers" },
                f = { cmd("Telescope find_files"), "Find Files" },
                h = { cmd("Telescope help_tags"), "Help Tags" },
                n = { cmd("Telescope notify"), "Notifications" },
                g = { cmd("Telescope live_grep"), "Live Grep" },
                p = { cmd("Telescope projects"), "Projects" },
                m = { cmd("Telescope marks"), "Marks" },
                M = { cmd("Telescope man_pages"), "Man Pages" },
                k = { cmd("Telescope keymaps"), "Keymaps" },
                v = { cmd("Telescope vim_options"), "Vim Options" },
                c = { cmd("Telescope commands"), "Commands" },
                d = { cmd("Telescope diagnostics"), "Diagnostics" },
                o = { cmd("Telescope oldfiles"), "Recent Files" },
                l = {
                    name = "Lsp",
                    D = { cmd("Telescope lsp_definitions"), "Definitions" },
                    r = { cmd("Telescope lsp_references"), "References" },
                },
                G = {
                    name = "Git",
                    b = { cmd("Telescope git_branches"), "Branches" },
                    c = { cmd("Telescope git_commits"), "Commits" },
                    C = { cmd("Telescope git_bcommits"), "Buffer Commits" },
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

return M
