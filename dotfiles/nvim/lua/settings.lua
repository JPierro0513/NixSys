vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.o.clipboard = 'unnamedplus'
vim.o.selection = 'old'

vim.o.number = true
vim.o.cursorline = true
vim.o.signcolumn = 'yes'
vim.o.linebreak = true

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.incsearch = true
vim.o.smartindent = true
vim.o.smartcase = true
vim.o.inccommand = 'split'

vim.o.list = true
vim.opt.listchars = 'tab:>-,trail:·,nbsp:·'

-- Folding.
vim.o.foldcolumn = '1'
vim.o.foldlevelstart = 99
vim.wo.foldtext = ''
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

vim.opt.fillchars = {
    eob = ' ',
    fold = ' ',
    -- foldclose = arrows.right,
    -- foldopen = arrows.down,
    foldsep = ' ',
    msgsep = '─',
}

vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10

vim.o.laststatus = 3
vim.o.showmode = false


