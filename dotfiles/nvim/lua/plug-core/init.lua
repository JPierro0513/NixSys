return {
    'nvim-lua/plenary.nvim',
    {
        'echasnovski/mini.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            local mi = require 'mini.icons'
            mi.setup()
            package.preload['nvim-web-devicons'] = function()
                mi.mock_nvim_web_devicons()
                return package.loaded['nvim-web-devicons']
            end

            require'mini.pairs'.setup()
            require'mini.surround'.setup()

            local highlighters = {}
            for _, word in ipairs { 'todo', 'note', 'hack' } do
                highlighters[word] = {
                    pattern = string.format('%%f[%%w]()%s()%%f[%%W]', word:upper()),
                    group = string.format('MiniHipatterns%s', word:sub(1, 1):upper() .. word:sub(2)),
                }
            end
            highlighters.hex_color = require'mini.hipatterns'.gen_highlighter.hex_color()
            require'mini.hipatterns'.setup { highlighters = highlighters }

            local mn = require'mini.notify'
            mn.setup()
            vim.notify = mn.make_notify()
        end,
    },
    {
        "armannikoyan/rusty",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
            italic_comments = true,
            underline_current_line = true,
        },
        config = function(_, opts)
            require("rusty").setup(opts)
            vim.cmd("colorscheme rusty")
        end,
    },
    {
        'stevearc/oil.nvim',
        lazy = false,
        dependencies = {
            { 'JezerM/oil-lsp-diagnostics.nvim', opts = {} },
            { 'SirZenith/oil-vcs-status', opts = {} }
        },
        opts = {
            default_file_explorer = true,
            win_options = {
                signcolumn = 'yes',
            },
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            keymaps = {
                ['q'] = { 'actions.close', mode = 'n' }
            },
            view_options = { show_hidden = true, },
            float = {
                max_width = 60,
                max_height = 15,
                border = 'none',
            }
        },
        keys = {
            { '-', '<CMD>Oil --float<CR>', desc = 'Open Oil' },
        }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'VeryLazy',
        opts = {
            ensure_installed = {
                'bash', 'c', 'cpp', 'lua', 'markdown', 'markdown_inline', 'nix', 'query', 'python', 'regex', 'rst', 'vim', 'vimdoc',
            },
            highlighter = { enable = true },
        },
        config = function (_,opts)
            require'nvim-treesitter.configs'.setup(opts)
        end
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {
            preset = 'helix',
        }
    },

    require 'plug-core.blink',
    require 'plug-core.mason',

    {
    "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", -- Or `LspAttach`
        priority = 1000, -- needs to be loaded in first
        config = function()
            require('tiny-inline-diagnostic').setup({
                options = {
                    use_icons_from_diagnostic = true,
                }
            })
        end
    }
}
