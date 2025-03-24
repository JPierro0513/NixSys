return {
    {
        'folke/snacks.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            -- explorer = { enabled = true },
            indent = { enabled = true },
            scope = { enabled = true },
            -- input = { enabled = true },
            -- picker = { enabled = true },
            notifier = { enabled = true, timeout = 3000 },
            quickfile = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true,  },
            toggle = { enable = true },
        },
        keys = {
            -- Top Pickers & Explorer
            -- { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
            -- { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
            -- { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
            -- { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
            -- { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
            -- { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
            -- Other
            { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
            { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
            { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
            { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
            { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
            { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
            { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
            { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
            { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
            { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
        },
    }
}
