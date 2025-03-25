local load,map = require'utils'.load,require'utils'.map

load('folke/snacks.nvim', {
    install = { checkout = 'stable' },
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        quickfile = { enabled = true },
        indent = { enabled = true },
        scope = { enabled = true },
        statuscolumn = { enabled = true, folds = { open = true } },
        scroll = { enabled = true },
        notifier = { enabled = true },
    },
})

map('<leader>.',  function() Snacks.scratch() end, 'Toggle Scratch Buffer')
map('<leader>S',  function() Snacks.scratch.select() end, 'Select Scratch Buffer')
map('<leader>n',  function() Snacks.notifier.show_history() end, 'Notification History')
map('<leader>cG', function() Snacks.gitbrowse() end, 'Git Browse', { 'n', 'v' })
map('<leader>cR', function() Snacks.rename.rename_file() end, 'Rename File')
map('<leader>gg', function() Snacks.lazygit() end, 'Lazygit')
map('<leader>U',  function() Snacks.notifier.hide() end, 'Dismiss Notifications')
map('<C-/>',      function() Snacks.terminal() end, 'Toggle Terminal')
map('<C-_>',      function() Snacks.terminal() end, 'which_key_ignore')

vim.api.nvim_create_autocmd('UIEnter', {
    once = true,
    callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
    end
})
