local load = require'utils'.load

load('vague2k/vague.nvim', { lazy = false })
-- vim.cmd.colorscheme 'vague'

load('slugbyte/lackluster.nvim', { lazy = false })
local lackluster = require 'lackluster'
lackluster.setup({
    tweak_background = {
        menu = 'none',
        popup = 'none',
        -- telescope = 'default',
        -- normal = 'default',
    },
    tweak_syntax = {
        keyword = lackluster.color.lack,
        string = '#FFAA88',
        comment = lackluster.color.gray5,
        type = lackluster.color.green,
        builtin = lackluster.color.orange,
        keyword_return = lackluster.color.red,
        keyword_exception = lackluster.color.lack,
        string_escape = lackluster.color.blue,
    },
    disable_plugin = {},
})
vim.cmd.colorscheme 'lackluster'
