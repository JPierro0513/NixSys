local lazypath = vim.fn.stdpath 'data' .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim', lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.loader.enable()
require 'utils'
require 'settings'
require 'keybinds'
require 'commands'
require 'lsp'

require'lazy'.setup({
    'nvim-lua/plenary.nvim',
    'tpope/vim-sleuth',
    {
        'echasnovski/mini.icons',
        init = function()
            package.preload['nvim-web-devicons'] = function()
                require'mini.icons'.mock_nvim_web_devicons()
                return package.loaded['nvim-web-devicons']
            end
        end,
    },
    {
        'marko-cerovac/material.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.material_style = 'darker'
            vim.cmd.colorscheme 'material'
        end,
    },
    {
        'stevearc/oil.nvim',
        lazy = false,
        dependencies = {
            'JezerM/oil-lsp-diagnostics.nvim',
            'SirZenith/oil-vcs-status'
        },
        opts = {
            skip_confirm_for_simple_edits = true,
            delete_to_trash = true,
            keymaps = {
                ['q'] = { 'actions.close', mode = 'n' }
            }
        },
        keys = {
            {'-', ':Oil<cr>', desc  = 'Open Oil'},
            {'<leader>e', ':Oil --float<cr>', desc = 'File Explorer'}
        }
    },
    require 'plugins.snacks',
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'VeryLazy',
        version = '*',
        build = ':TSUpdate',
        config = function()
            require'nvim-treesitter.configs'.setup({
                ensure_installed = {
                    'bash', 'c', 'cpp', 'lua', 'markdown', 'markdown_inline',
                    'nix', 'query', 'python', 'regex', 'rst', 'vim', 'vimdoc'
                },
                highlight = { enable = true },
            })
        end,
    },
    { 'folke/which-key.nvim', event = 'VeryLazy', opts = { preset = 'helix' } },
    { 'echasnovski/mini.pairs', event = 'InsertEnter', opts = {} },
    require 'plugins.blink',
    -- require 'plugins.care',
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = 'lazy.nvim' },
                { path = 'snacks.nvim', words = { 'Snacks' } },
            },
        },
    },
    {
        'rachartier/tiny-inline-diagnostic.nvim',
        event = 'LspAttach',
        priority = 1000,
        opts = {
            options = {
                use_icons_from_diagnostic = false,
                multilines = {
                    enabled = false,
                    always_show = false,
                },
            },
        },
    },
    require 'plugins.noice',
    require 'plugins.lines',
    {
        'j-morano/buffer_manager.nvim',
        keys = {
            { '<leader>bb', function() require("buffer_manager.ui").toggle_quick_menu() end, desc = 'Buffer manager' }
        }
    },
    require 'plugins.pick',
    {
        "smjonas/inc-rename.nvim",
        opts = {},
        keys = {
            { "<leader>rn", ":IncRename ",                                                   desc = 'Rename' },
            { '<leader>rN', function() return ":IncRename " .. vim.fn.expand("<cword>") end, desc = 'Rename', expr = true }
        }
        -- config = function()
        --     require("inc_rename").setup()
        -- end,
    }
}, {
    install = { colorscheme = { 'material' } },
    defaults = { lazy = true },
    rocks = { enabled = false },
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip', 'matchit', 'netrwPlugin', 'tarPlugin', 'tohtml', 'tutor', 'zipPlugin'
            },
        },
    },
})
