vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local topts = {
    "number",
    "cursorline",
    "expandtab",
    "splitright",
    "splitbelow",
    "ignorecase",
    "smartcase",
    "smartindent",
    "incsearch",
    'list',
}
for _,v in pairs(topts) do vim.o[v] = true end

vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)
vim.o.selection = 'old'

vim.o.signcolumn = 'yes'

vim.o.shiftwidth  = 4
vim.o.tabstop     = 4
vim.o.softtabstop = 4

vim.o.inccommand = 'split'

vim.o.listchars = 'tab:󰄾·,trail:·,nbsp:·'

vim.o.updatetime = 200
vim.o.timeoutlen = 450
vim.o.ttimeoutlen = 10

vim.o.laststatus = 3
vim.o.showmode = false

vim.o.scrolloff = 10

