local load, map = require 'utils'.load, require 'utils'.map

load 'plugins.colorscheme'

load('mini.icons', { lazy = false, opts = {} })
load('mini.pairs', {
    lazy = true,
    opts = {
        modes = { insert = true, command = true, terminal = false },
        skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
        skip_ts = { "string" },
        skip_unbalanced = true,
        markdown = true,
    },
})

load 'plugins.snacks'
load 'plugins.whichkey'

load('mini.surround', { lazy = true, opts = {} })
MiniDeps.add('tpope/vim-sleuth')
load('folke/ts-comments.nvim', { lazy = true, opts = {} })

load('stevearc/oil.nvim', {
    lazy = false,
    opts = {
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        keymaps = {
            ['q'] = { 'actions.close', mode = 'n' },
        },
        view_options = { show_hidden = true },
    },
})
map('-', '<cmd>Oil<cr>', 'Oil')

load 'plugins.minifiles'

load('nvim-treesitter/nvim-treesitter', {
    install = {
        checkout = 'master',
        monitor = 'main',
        hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
    },
    name = 'nvim-treesitter.configs',
    lazy = true,
    opts = {
        ensure_installed = {
            'bash', 'c', 'cpp', 'lua', 'markdown', 'markdown_inline', 'nix', 'query', 'regex', 'vim', 'vimdoc'
        },
        indent = { enable = true },
        highlight = { enable = true },
    },
})
load 'plugins.blink'
load 'plugins.lspconfig'

load 'plugins.lines'

load 'plugins.highlighting'

load('MagicDuck/grug-far.nvim', {
    lazy = true,
    opts = {},
})
map('<leader>cg', function()
    local grug = require 'grug-far'
    grug.open {
        transient = true,
        keymaps = { help = '?' },
    }
end, 'GrugFar', { 'n', 'v' })

load 'plugins.gitsigns'

