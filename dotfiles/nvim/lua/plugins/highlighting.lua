local load = require 'utils'.load

local function hi()
    local highlighters = {}
    for _, word in ipairs { 'todo', 'note', 'hack' } do
        highlighters[word] = {
            pattern = string.format('%%f[%%w]()%s()%%f[%%W]', word:upper()),
            group = string.format('MiniHipatterns%s', word:sub(1, 1):upper() .. word:sub(2)),
        }
    end

    return highlighters
end
load('mini.hipatterns', {
    lazy = true,
    opts = {
        highlighters = hi()
    },
})

local colored_fts = { 'cfg', 'css', 'conf', 'lua', 'scss', 'nix' }
load('uga-rosa/ccc.nvim', {
    opts = {
        highlighter = {
            auto_enable = true,
            filetypes = colored_fts,
            lsp = false,
        }
    },
})
local ccc = require 'ccc'
-- Use uppercase for hex codes.
ccc.output.hex.setup { uppercase = true }
ccc.output.hex_short.setup { uppercase = true }
