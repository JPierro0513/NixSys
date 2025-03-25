local load = require'utils'.load

load('folke/which-key.nvim', { opts = {preset = 'helix'}})
require'which-key'.add({
    {
        "<leader>b", group = "buffers", expand = function()
            return require("which-key.extras").expand.buf()
        end
    },
    { '<leader>c', group = 'code' },
    { '<leader>f', group = 'find' },
    { '<leader>g', group = 'git' },
    { '<leader>u', group = 'toggle' },
})
