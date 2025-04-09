local lazypath = vim.fn.stdpath 'data' .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim', lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.loader.enable()

_G.MapKey = function(lhs, rhs, desc, mode, opts)
    vim.keymap.set(
        mode or 'n',
        lhs, rhs,
        vim.tbl_deep_extend(
            'force',
            { desc = desc, silent = true, noremap = true },
            opts or {}
        )
    )
end

require 'settings'
require 'keybinds'
require 'commands'
require 'lsp'

require'lazy'.setup({
    spec = {
        { import = 'plug-core' },
        { import = 'plug-extra' },
    },
    install = { colorscheme = { 'kanagawa-paper' } },
    defaults = { lazy = true },
    rocks = { enabled = false },
    change_detection = { notify = false },
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip', 'matchit', 'netrwPlugin', 'tarPlugin', 'tohtml', 'tutor', 'zipPlugin'
            },
        },
    },
})
MapKey('<leader>L', '<CMD>Lazy<CR>', 'Open Lazy')

