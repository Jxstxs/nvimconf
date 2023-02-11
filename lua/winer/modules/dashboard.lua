return {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            theme = 'doom',
            config = {
                header = require("winer.db-logo")[2],
                center = {
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Find File',
                        desc_hl = 'String',
                        key = 'f',
                        keymap = 'SPC f f',
                        key_hl = 'Number',
                        action = 'Telescope find_files'
                    },
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Recent Files',
                        desc_hl = 'String',
                        key = 'r',
                        keymap = 'SPC f o',
                        key_hl = 'Number',
                        action = 'Telescope oldfiles'
                    },
                    {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Quit',
                        desc_hl = 'String',
                        key = 'q',
                        keymap = 'Z Z',
                        key_hl = 'Number',
                        action = 'qa!'
                    },
                },
                footer = { "Dave Raves All Day Long" }
            }
        }
    end,
    dependencies = { { 'kyazdani42/nvim-web-devicons' } }
}
