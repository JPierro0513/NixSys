local load = require'utils'.load

load('vague2k/vague.nvim', { lazy = false })
-- vim.cmd.colorscheme 'vague'

load('slugbyte/lackluster.nvim', {
    lazy = false,
    opts = {

    },
})
vim.cmd.colorscheme 'lackluster'
