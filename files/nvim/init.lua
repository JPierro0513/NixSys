-- Bootload lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.loader.enable()

require 'settings'
require 'keybinds'
require 'commands'
require 'lsp'

vim.g.lazy_events_config = {
    simple = {
        LazyFile = { "BufReadPost", "BufNewFile", "BufWritePre" },
    }
}

require'lazy'.setup({

    { "bwpge/lazy-events.nvim", import = "lazy-events.import", lazy = false },

    { import = "plugins.basic" },
    { import = "plugins.editor" },
    { import = "plugins.coding" },
    { import = "plugins.ui" },
}, {
  defaults = { lazy = true },
  rocks = { enabled = false },
  checker = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'netrwPlugin',
        'rplugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
