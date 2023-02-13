return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-path",
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
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
                    },
                }),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs( -4),
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
                    elseif luasnip.jumpable( -1) then
                        luasnip.jump( -1)
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

        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
        local servers = require("winer.lsps")

        for i, server in pairs(servers) do
            if server == "sumneko_lua" then
                servers[i] = "lua_ls"
            end
        end

        for _, server in ipairs(servers) do
            require("lspconfig")[server].setup({
                capabilities = capabilities,
            })
        end
    end,
}
