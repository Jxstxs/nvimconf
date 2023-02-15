local utils = require("winer.utils")
local m = utils.map

return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { { "nvim-treesitter/playground", enabled = false, cmd = "TSHighlightCapturesUnderCursor" } },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                autotag = {
                    enable = true,
                },
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    -- "gitignore",
                    "java",
                    "json",
                    "json5",
                    "lua",
                    "make",
                    "markdown",
                    "markdown_inline",
                    "python",
                    -- "sql",
                    "vim",
                },
                sync_install = false,
                auto_install = false,
                ignore_install = {},
                highlight = { enable = true, additional_vim_regex_highlighting = false },
            })
        end,
    },
    {
        "famiu/bufdelete.nvim",
        keys = {
            { m.ld("q"), m.cmd("Bdelete"), desc = "Close Buffer" },
        },
    },
    {
        "danymat/neogen",
        keys = {
            { m.ld("Ca"), m.cmd("Neogen"), desc = "[A]nnotation" },
        },
        opts = { snippet_engine = "luasnip" },
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        keys = {
            { m.ld("ff"), m.cmd("Telescope find_files"), desc = "[F]ind files" },
            { m.ld("fr"), m.cmd("lua require('telescope.builtin').resume()"), desc = "[R]esume Last" },
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
            ts.load_extension("noice")
            ts.load_extension("notify")
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                disable_in_macro = true,
                disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
            })
        end,
    },
    {
        "wakatime/vim-wakatime",
        event = "InsertEnter",
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-path",
            "delphinus/cmp-ctags",
            "f3fora/cmp-spell",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "saadparwaiz1/cmp_luasnip",
            "doxnit/cmp-luasnip-choice",
            "KadoBOT/cmp-plugins",
            "lukas-reineke/cmp-under-comparator",
            "onsails/lspkind.nvim",
        },
        event = "InsertEnter",
        config = function()
            local has_words_before = function()
                ---@diagnostic disable-next-line: deprecated
                local unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local luasnip = require("luasnip")
            local lspkind = require("lspkind")
            local neogen = require("neogen")
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                view = { entries = { name = "custom", selection_order = "near_cursor" } },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol",
                        maxwidth = 50,
                        ellipsis_char = "...",
                        symbol_map = { Codeium = "" },
                        menu = {
                            buffer = "[Buf]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snip]",
                            nvim_lua = "[Lua]",
                            path = "[Path]",
                            codeium = "[AI]",
                            nvim_lsp_signature_help = "[LSPS]",
                            ctags = "[CT]",
                        },
                    }),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        elseif neogen.jumpable() then
                            neogen.jump_next()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        elseif neogen.jumpable(true) then
                            neogen.jump_prev()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "nvim_lua" },
                    { name = "luasnip_choice" },
                    { name = "path" },
                    { name = "codeium" },
                    { name = "cmp_ctags" },
                    -- { name = "nvim_lsp_signature_help" },
                    {
                        name = "plugins",
                        option = {
                            get_trigger_characters = function()
                                return { "#" }
                            end,
                        },
                    },
                    -- { name = "spell" },
                }),
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        require("cmp-under-comparator").under,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
            })

            vim.cmd("autocmd FileType guihua lua require('cmp').setup.buffer { enabled = false }")
            vim.cmd("autocmd FileType guihua_rust lua require('cmp').setup.buffer { enabled = false }")

            local capabilities =
                require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
            local servers = require("winer.lsps")

            for _, server in ipairs(servers) do
                require("lspconfig")[server].setup({
                    capabilities = capabilities,
                })
            end
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        build = "make install_jsregexp",
        config = function()
            local ls = require("luasnip")
            ls.setup({
                snip_env = {
                    s = function(...)
                        local snip = ls.s(...)
                        table.insert(getfenv(2).ls_file_snippets, snip)
                    end,
                    parse = function(...)
                        local snip = ls.parser.parse_snippet(...)
                        table.insert(getfenv(2).ls_file_snippets, snip)
                    end,
                    sn = ls.snippet_node,
                    t = ls.text_node,
                    i = ls.insert_node,
                    f = ls.function_node,
                    c = ls.choice_node,
                    d = ls.dynamic_node,
                    l = require("luasnip.extras").lambda,
                    r = require("luasnip.extras").rep,
                    p = require("luasnip.extras").partial,
                    m = require("luasnip.extras").match,
                    n = require("luasnip.extras").nonempty,
                    dl = require("luasnip.extras").dynamic_lambda,
                    fmt = require("luasnip.extras.fmt").fmt,
                    fmta = require("luasnip.extras.fmt").fmta,
                    types = require("luasnip.util.types"),
                    conds = require("luasnip.extras.expand_conditions"),
                    events = require("luasnip.util.events"),
                },
            })

            require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/snippets" })
            vim.cmd([[
            imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
            smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
            ]])
        end,
    },
    {
        "ziontee113/SnippetGenie",
        enabled = false,
        opts = {
            snippets_directory = vim.fn.stdpath("config") .. "lua/winer/snippets/",
            file_name = "snip_genie",
        },
        keys = {
            {
                m.ld("CN"),
                m.cmd("lua require('SnippetGenie').create_new_snippet_or_add_placeholder()"),
                desc = "Submit Snippet",
            },
            {
                m.ld("Cn"),
                function()
                    require("SnippetGenie").create_new_snippet_or_add_placeholder()
                    vim.cmd("norm! �")
                end,
                mode = "x",
                desc = "[N]ew Snippet",
            },
        },
    },
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        event = { "BufRead *.norg", "BufNewFile *.norg" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neorg/neorg-telescope",
            {
                "lukas-reineke/headlines.nvim",
                enable = false,
                config = function()
                    -- vim.cmd([[highlight Headline2 guibg=#21262d guifg=#1e2718 gui=italic]])
                    -- vim.cmd([[highlight CodeBlock guibg=#1c1c1c]])
                    -- vim.cmd([[highlight Quote guibg=#2c1c1c]])
                    -- vim.cmd([[highlight Dash guibg=#D19A66]])
                    -- vim.cmd([[highlight DoubleDash guibg=#D29A66]])
                    require("headlines").setup({
                        norg = {
                            fat_headlines = false,
                            fat_headline_upper_string = " ", -- "▃",
                            fat_headline_lower_string = " ", -- "▃",
                            headline_highlights = {
                                -- "Headline1", "Headline2", "Headline3", "Headline4", "Headline5", "Headline6", "Written",
                            },
                        },
                    })
                end,
            },
        },
        keys = {
            { m.ld("Njj"), m.cmd("Neorg journal today"), desc = "Todays [J]ournal" },
            { m.ld("Njt"), m.cmd("Neorg journal tomorrow"), desc = "[T]omorrows Journal" },
            { m.ld("Njy"), m.cmd("Neorg journal yesterday"), desc = "[Y]esterdays Journal" },
        },
        config = function()
            require("neorg").setup({
                load = {
                    ["core.defaults"] = {},
                    ["core.norg.esupports.metagen"] = {
                        config = {
                            type = "auto",
                        },
                    },
                    -- ["core.presenter"] = { config = { zen_mode = "truezen" } },
                    ["core.export"] = {},
                    ["core.norg.journal"] = {
                        config = {
                            journal_folder = "/doc/journal",
                            workspace = "scholr",
                        },
                    },
                    ["core.norg.concealer"] = {
                        config = {
                            icons = {
                                heading = {
                                    level_1 = { icon = "﮴ " },
                                    level_2 = { icon = "  " },
                                    level_3 = { icon = "   " },
                                    level_4 = { icon = "    " },
                                    level_5 = { icon = "     " },
                                    level_6 = { icon = "      " },
                                },
                                list = {
                                    level_1 = { icon = "﬌" },
                                    level_2 = { icon = "  ﬌" },
                                    level_3 = { icon = "   ﬌" },
                                    level_4 = { icon = "    ﬌" },
                                    level_5 = { icon = "     ﬌" },
                                    level_6 = { icon = "      ﬌" },
                                },
                            },
                        },
                    },
                    ["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
                    ["core.integrations.telescope"] = {}, -- FIX: Need Config?
                    ["core.norg.dirman"] = {
                        config = {
                            workspaces = {
                                notes = "~/repos/personal/notes/",
                                scholr = "~/repos/personal/scholr/",
                            },
                            index = "index.norg", -- The name of the main (root) .norg file
                        },
                    },
                    ["core.norg.manoeuvre"] = { config = {} },
                },
            })

---@diagnostic disable-next-line: unused-local
            local autogroup = vim.api.nvim_create_augroup("winerau", { clear = true })

            vim.api.nvim_create_autocmd({ "FileType" }, {
                group = "winerau",
                pattern = { "norg" },
                callback = function()
                    vim.opt_local.wrap = true
                    vim.opt_local.spell = true
                    vim.opt_local.spelllang = "de,en"
                    vim.api.nvim_set_hl(0, "written", { italic = true })
                end,
            })
        end,
    },
}
