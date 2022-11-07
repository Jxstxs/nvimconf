return function(ufo)
    vim.o.foldcolumn = '1' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    local ftMap = {
        vim = 'indent',
        python = { 'indent' },
        git = ''
    }

    local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ('  %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
                table.insert(newVirtText, chunk)
            else
                chunkText = truncate(chunkText, targetWidth - curWidth)
                local hlGroup = chunk[2]
                table.insert(newVirtText, { chunkText, hlGroup })
                chunkWidth = vim.fn.strdisplaywidth(chunkText)
                -- str width returned from truncate() may less than 2nd argument, need padding
                if curWidth + chunkWidth < targetWidth then
                    suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                end
                break
            end
            curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, 'MoreMsg' })
        return newVirtText
    end

    ufo.setup({
        -- open_fold_hl_timeout = 150,
        -- close_fold_kinds = { 'imports', 'comment' },
        -- preview = {
        -- win_config = {
        -- border = { '', '─', '', '', '', '─', '', '' },
        -- winhighlight = 'Normal:Folded',
        -- winblend = 0
        -- },
        -- mappings = {
        -- scrollU = '<C-u>',
        -- scrollD = '<C-d>'
        -- }
        -- },
        fold_virt_text_handler = handler,
        provider_selector = function(bufnr, filetype, buftype)
            -- if you prefer treesitter provider rather than lsp,
            return ftMap[filetype] or { 'treesitter', 'indent' }
            -- return ftMap[filetype]

            -- refer to ./doc/example.lua for detail
        end
    })

    -- buffer scope handler
    -- will override global handler if it is existed
    local bufnr = vim.api.nvim_get_current_buf()
    ufo.setFoldVirtTextHandler(bufnr, handler)
end
