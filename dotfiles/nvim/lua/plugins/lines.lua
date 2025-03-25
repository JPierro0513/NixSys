local load,map = require 'utils'.load,require'utils'.map

load('mini.tabline', { lazy = true, opts = {} })
map('<leader>bd', function() load 'mini.bufremove'.delete(0, false) end, 'Close buffer')

load('mini.statusline', {
    lazy = true,
    opts = {
        content = {
            active = function()
                local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
                local git           = MiniStatusline.section_git({ trunc_width = 40 })
                local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
                local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
                local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
                local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
                local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 900 })
                local location      = MiniStatusline.section_location({ trunc_width = 900 })
                local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

                return MiniStatusline.combine_groups({
                    { hl = mode_hl,                 strings = { mode } },
                    { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
                    '%<', -- Mark general truncate point
                    { hl = 'MiniStatuslineFilename', strings = { filename } },
                    '%=', -- End left alignment
                    { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                    { hl = mode_hl,                  strings = { search, location } },
                })
            end
        }
    }
})
