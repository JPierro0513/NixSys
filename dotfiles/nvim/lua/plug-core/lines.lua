return {
    {
        'sschleemilch/slimline.nvim',
        event = 'VeryLazy',
        config = function()
            require'slimline'.setup {
                style = 'bg',
                configs = {
                    mode = {
                        verbose = true,
                    },
                    path = {
                      hl = {
                        primary = 'Define',
                      },
                    },
                    git = {
                      hl = {
                        primary = 'Function',
                      },
                    },
                    diagnostics = {
                      hl = {
                        primary = 'Statement',
                      },
                    },
                    filetype_lsp = {
                      hl = {
                        primary = 'String',
                      },
                    },
                    progress = {
                        follow = 'mode',
                        icon = ' ',
                    },
                },
                components = {
                    left = { 'mode', 'git', 'path', 'diagnostics' },
                    center = {},
                    right = {
                        'filetype_lsp',
                        function()
                            local h = require('slimline.highlights')
                            local c = require('slimline').config
                            local content = string.format('%s %s:%s', ' ', vim.fn.line('.'), vim.fn.col('.'))
                            return h.hl_component({ primary = content }, h.hls.components['diagnostics'], c.sep)
                        end,
                    },
                }
            }
        end,
    }

}
