
return {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
        require("gitsigns").setup({
            numhl = true,
            current_line_blame_opts = {
                virt_text_pos = "right_align"
            }
        })
    end
}
