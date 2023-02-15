math.randomseed(os.time())

local m = require("winer.utils").map

--- Returns a merged table from opts and defaults
---@param opts table?
---@return table
local section = function(opts)
    local defaults = {
        icon = " ",
        icon_hl = "Title",
        desc = "",
        desc_hl = "String",
        key = "",
        keymap = "",
        key_hl = "Number",
        action = "",
    }
    return vim.tbl_deep_extend("force", defaults, opts)
end

return {
    {
        "glepnir/dashboard-nvim",
        config = function()
            require("dashboard").setup({
                theme = "doom",
                config = {
                    header = require("winer.db-logo")[math.random(1, #require("winer.db-logo"))],
                    center = {
                        section({
                            desc = "Find Files",
                            key = "f",
                            keymap = "SPC f f",
                            action = "lua require('telescope.builtin').find_files()",
                        }),
                        section({
                            desc = "Recent Files",
                            key = "r",
                            keymap = "SPC f o",
                            action = "lua require('telescope.builtin').oldfiles()",
                        }),
                        section({
                            desc = "Edit Config",
                            key = "c",
                            keymap = "SPC V c",
                            action = "e $MYVIMRC",
                        }),
                        section({
                            desc = "Open Lazy",
                            key = "l",
                            keymap = "SPC L",
                            action = "Lazy",
                        }),
                        section({
                            desc = "Quit",
                            key = "q",
                            keymap = "Z Z",
                            action = "qa!",
                        }),
                    },
                    footer = { "Dave Raves All Day Long" },
                },
            })
        end,
        dependencies = { { "kyazdani42/nvim-web-devicons" } },
    },
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                presets = {
                    lsp_doc_border = true,
                },
            })
        end,
    },
    {
        "stevearc/dressing.nvim",
    },
    {
        "projekt0n/github-nvim-theme",
        lazy = false,
        priority = 1000,
        config = function()
            require("github-theme").setup({ theme_style = "dark_default" })
        end,
    },
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300

            local wk = require("which-key")

            wk.setup({
                plugins = {
                    spelling = {
                        enabled = true,
                        suggestions = 30,
                    },
                },
                window = { border = "single" },
                layout = { align = "center" },
            })

            -- Normal Mode
            wk.register({
                V = "[V]im Stuff",
                f = "[F]inder Stuff",
                ["fg"] = "[G]it Stuff",
                g = "[G]it Stuff",
                l = "[L]SP Stuff",
            }, { mode = "n", prefix = "<leader>" })

            -- Visual Mode
            wk.register({
                T = { name = "Tester" },
            }, { mode = "v", prefix = "<leader>" })
        end,
    },
    {
        "anuvyklack/pretty-fold.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local folder = vim.api.nvim_create_augroup("folder", { clear = true })
            vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
                group = "folder",
                pattern = { "*.lua", "*.md", "*.c", "*.h", "*.norg" },
                callback = function()
                    vim.cmd("set fen")
                end,
            })

            require("pretty-fold").setup({
                sections = {
                    left = {
                        "content",
                    },
                    right = {
                        " ",
                        "number_of_folded_lines",
                        ": ",
                        "percentage",
                        " ",
                        function(config)
                            return config.fill_char:rep(3)
                        end,
                    },
                },
                fill_char = "•",
                keep_indentation = true,
                -- List of patterns that will be removed from content foldtext section.
                stop_words = {
                    "@brief%s*", -- (for C++) Remove '@brief' and all spaces after.
                },
                matchup_patterns = {
                    { "^%s*do$", "end" }, -- `do ... end` blocks
                    { "^%s*if", "end" },
                    { "^%s*for", "end" },
                    { "function%s*%(", "end" },
                    { "{", "}" },
                    { "%(", ")" },
                    { "%[", "]" },
                },
            })
        end,
    },
    {
        "anuvyklack/fold-preview.nvim",
        dependencies = { "anuvyklack/keymap-amend.nvim" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("fold-preview").setup({
                border = "single",
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = { "man", "nvim-tree", "quickfix", "symbols-outline", "toggleterm" },
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        keys = {
            { m.ld("gp"), m.cmd("Gitsigns preview_hunk"), desc = "[P]review Hunk" },
            { m.ld("gb"), m.cmd("Gitsigns toggle_current_line_blame"), desc = "Line [B]lame" },
            { m.ld("gr"), m.cmd("Gitsigns reset_hunk"), desc = "[R]eset Hunk" },
            { m.ld("gl"), m.cmd("Gitsigns toggle_linehl"), desc = "[L]ine Highlight" },
            { m.ld("gd"), m.cmd("Gitsigns toggle_deleted"), desc = "Show [D]eleted" },
        },
        config = function()
            require("gitsigns").setup({
                numhl = true,
                current_line_blame_opts = {
                    virt_text_pos = "right_align",
                },
            })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        config = function()
            vim.opt.list = true
            vim.opt.listchars:append("eol:↴")

            require("indent_blankline").setup({
                show_end_of_line = true,
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
            })
        end,
    },
    {
        "tamton-aquib/flirt.nvim",
        enabled = false,
        config = function()
            require("flirt").setup({
                override_open = true, -- experimental
                close_command = "Q",
                default_move_mappings = false, -- <C-arrows> to move floats
                default_resize_mappings = false, -- <A-arrows> to resize floats
                default_mouse_mappings = true, -- Drag floats with mouse
                exclude_fts = { "notify" },
                -- exclude_fts = { "notify", "cmp_menu" },
                -- custom_filter = function(buffer, win_config) return vim.bo[buffer].filetype == "cmp_menu" end,
            })
        end,
    },
}
