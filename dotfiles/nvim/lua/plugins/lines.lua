local load,map = require 'utils'.load,require'utils'.map

load('mini.tabline', { lazy = true, opts = {} })
map('<leader>bd', function() load 'mini.bufremove'.delete(0, false) end, 'Close buffer')

-- load('mini.statusline', {
--     lazy = true,
--     opts = {
--         content = {
--             active = function()
--                 local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
--                 local git           = MiniStatusline.section_git({ trunc_width = 40 })
--                 local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
--                 local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
--                 local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
--                 local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
--                 local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 900 })
--                 local location      = MiniStatusline.section_location({ trunc_width = 900 })
--                 local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })
--
--                 return MiniStatusline.combine_groups({
--                     { hl = mode_hl,                 strings = { mode } },
--                     { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
--                     '%<', -- Mark general truncate point
--                     { hl = 'MiniStatuslineFilename', strings = { filename } },
--                     '%=', -- End left alignment
--                     { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
--                     { hl = mode_hl,                  strings = { search, location } },
--                 })
--             end
--         }
--     }
-- })

local function fileinfo()
    local h,c = require'slimline.highlights',require'slimline'.config
    if vim.bo.buftype ~= '' then return '' end
    local file = ''
    if vim.bo.modified then
        file = file .. ' ' .. c.icons.buffer.modified
    end
    if vim.bo.readonly then
        file = file .. ' ' .. c.icons.buffer.read_only
    end
    local path = vim.fs.normalize(vim.fn.expand('%:.:h'))
    if #path == 0 then return '' end
    path = c.icons.folder .. path
    return h.hl_component({ primary = path, secondary = file }, h.hls.component, {})
end

local function location()
    local h, c = require 'slimline.highlights', require 'slimline'.config
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local content = string.format('%s %s:%s ', c.icons.lines, row, col)
    return h.hl_component({ primary = content }, h.hls.component, {})
end

load('sschleemilch/slimline.nvim', {
    lazy = true,
    opts = {
        bold = true,
        verbose_mode = true,
        style = 'fg',
        components = {
            left = { 'mode', 'git', fileinfo },
            center = {},                                         -- TODO: navic
            right = { 'diagnostics', 'filetype_lsp', location }, -- TODO: custom progress
        }
    },
})
