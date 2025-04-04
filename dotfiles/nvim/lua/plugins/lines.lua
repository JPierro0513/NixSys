-- return {
--     'nvim-lualine/lualine.nvim',
--     event = 'VeryLazy',
--     dependencies = {
--         "meuter/lualine-so-fancy.nvim",
--     },
--     opts = {
--         options = {
--             theme = 'material-nvim',
--             component_separators = { left = "│", right = "│" },
--             section_separators = { left = "", right = "" },
--             globalstatus = true,
--             refresh = {
--                 statusline = 100,
--             },
--         },
--         sections = {
--             lualine_a = {
--                 -- { "fancy_mode", width = 6 }
--                 'mode',
--             },
--             lualine_b = {
--                 { "fancy_branch" },
--                 { "fancy_diff" },
--             },
--             lualine_c = {
--                 { "fancy_cwd", substitute_home = true }
--             },
--             lualine_x = {
--                 { "fancy_macro" },
--                 { "fancy_diagnostics" },
--                 { "fancy_searchcount" },
--                 { "fancy_location" },
--             },
--             lualine_y = {
--                 { "fancy_filetype", ts_icon = "" }
--             },
--             lualine_z = {
--                 { "fancy_lsp_servers" }
--             },
--         }
--     }
-- }

return {
    {
        'b0o/incline.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'sschleemilch/slimline.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            require'slimline'.setup({
                style = 'fg',
                bold = true,
                configs = {
                    mode = { verbose = true },
                },
                components = {
                    left = {
                        'mode', 'git',
                        function()
                            local highlights = require('slimline.highlights')
                            local config = require('slimline').config

                            if vim.bo.buftype ~= '' then return '' end

                            local file = ''
                            local icons = config.configs['path'].icons

                            if vim.bo.modified then
                                file = file..icons.modified
                            end
                            if vim.bo.readonly then
                                file = file..icons.read_only
                            end

                            local path = ''
                            path = vim.fs.normalize(vim.fn.expand('%:.:h'))
                            if #path == 0 then return '' end
                            path = icons.folder .. path

                            return highlights.hl_component(
                                {primary = path, secondary = file},
                                {
                                    primary = highlights.hls.components['filetype_lsp'].primary,
                                    secondary = highlights.hls.components['filetype_lsp'].secondary,
                                },
                                ''
                            )
                        end,
                        'diagnostics',
                    },
                    center = {
                        -- navic
                    },
                    right = {
                        'filetype_lsp',
                        function()
                            local highlights = require('slimline.highlights')
                            local config = require('slimline').config
                            local utils = require'slimline.utils'
                            local content = string.format(
                                '%s %s:%s',
                                config.configs['progress'].icon,
                                vim.fn.line('.'), vim.fn.col('.')
                            )
                            return highlights.hl_component(
                                { primary = content },
                                highlights.get_mode_hl(utils.get_mode()),
                                ''
                            )
                        end,
                    }
                }
            })
        end,
    }
}
