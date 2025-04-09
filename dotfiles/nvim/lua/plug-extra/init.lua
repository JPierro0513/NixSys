return {
    {
        'j-morano/buffer_manager.nvim',
        keys = {
            { '<leader>bb', function() require'buffer_manager.ui'.toggle_quick_menu() end, desc = 'Buffer Manager Quick Menu' }
        }
    },
    -- {
    --     'vzze/cmdline.nvim',
    --     event = 'CmdLineEnter',
    --     opts = {
    --         cmdtype = ":/?",
    --         window = {
    --             matchFuzzy = true,
    --             offset     = 1,    -- depending on 'cmdheight' you might need to offset
    --             debounceMs = 10    -- the lower the number the more responsive however
    --                                -- more resource intensive
    --         },
    --
    --         hl = {
    --             default   = "Pmenu",
    --             selection = "PmenuSel",
    --             directory = "Directory",
    --             substr    = "LineNr"
    --         },
    --
    --         column = {
    --             maxNumber = 6,
    --             minWidth  = 20
    --         },
    --
    --         binds = {
    --             next = "<Tab>",
    --             back = "<S-Tab>"
    --         }
    --     },
    -- }
}
