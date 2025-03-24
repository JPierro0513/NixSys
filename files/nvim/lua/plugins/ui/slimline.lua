return {
    "sschleemilch/slimline.nvim",
    event = { "LazyFile" },
    config = function()
        require('slimline').setup {
            bold = true,
            verbose_mode = true,
            style = 'fg',
            components = { -- Choose components and their location
                left = {
                    "mode",
                    function()
                        local h = require('slimline.highlights')
                        local c = require("slimline").config
                        if vim.bo.buftype ~= '' then return '' end
                        local file = '' --vim.fn.expand('%:t')
                        if vim.bo.modified then
                            file = file .. ' '.. c.icons.buffer.modified
                        end
                        if vim.bo.readonly then
                            file = file .. ' ' .. c.icons.buffer.read_only
                        end
                        local path = vim.fs.normalize(vim.fn.expand('%:.:h'))
                        if #path == 0 then return '' end
                        path = c.icons.folder .. path
                        return h.hl_component({ primary = path, secondary = file }, h.hls.component, { left = '', right = '' })
                    end,
                    "git"
                },
                center = {},
                right = {
                    "diagnostics",
                    "filetype_lsp",
                    -- "progress"
                    function()
                        local h = require("slimline.highlights")
                        local c = require("slimline").config
                        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                        local content = string.format("%s %s:%s", c.icons.lines, row, col)
                        return h.hl_component({primary = content}, h.get_mode_hl(require'slimline.utils'.get_mode()), { left = '', right = '' })
                    end,
                }
            },
            -- spaces = {
            --     components = ' ', -- string between components
            --     left = ' ', -- string at the start of the line
            --     right = ' ', -- string at the end of the line
            -- },
            -- sep = {
            --     hide = {
            --         first = false, -- hides the first separator
            --         last = false, -- hides the last separator
            --     },
            --     left = '', -- left separator of components
            --     right = '', -- right separator of components
            -- },
        }
    end,
}
