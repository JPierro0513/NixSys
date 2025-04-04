-- Save file
MapKey('<C-s>', '<esc>:w<cr>', 'Save File', { 'n', 'i', 's', 'x', 'v' })

MapKey('<C-l>', '<C-o>A', 'Jump to the end of the line', { 'i', 'c' })

MapKey('j', [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']], 'WordWrap JumpList J', 'n', { expr = true })
MapKey('k', [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']], 'WordWrap JumpList K', 'n', { expr = true })

MapKey('<C-d>', '<C-d>zz', 'Scroll downwards')
MapKey('<C-u>', '<C-u>zz', 'Scroll upwards')
MapKey('n', 'nzzzv', 'Next result')
MapKey('N', 'Nzzzv', 'Previous result')

MapKey('<', '<gv', 'Shift <', 'v')
MapKey('>', '>gv', 'Shift >', 'v')

MapKey('gQ', 'mzgggqG`z<cmd>delmarks z<cr>zz', 'Format buffer')

MapKey('<esc>', function()
    vim.cmd 'noh'
    return '<esc>'
end, 'Clear hl and escape', { 'n', 'i', 's' }, { expr = true})
