return {
    {
        'L3MON4D3/LuaSnip',
        keys = {
            {
                '<C-r>s',
                function()
                    require('luasnip.extras.otf').on_the_fly 's'
                end,
                desc = 'Insert on-the-fly snippet',
                mode = 'i',
            },
        },
        opts = function()
            local types = require 'luasnip.util.types'
            return {
                -- Check if the current snippet was deleted.
                delete_check_events = 'TextChanged',
                -- Display a cursor-like placeholder in unvisited nodes
                -- of the snippet.
                ext_opts = {
                    [types.insertNode] = {
                        unvisited = {
                            virt_text = { { '|', 'Conceal' } },
                            virt_text_pos = 'inline',
                        },
                    },
                    [types.exitNode] = {
                        unvisited = {
                            virt_text = { { '|', 'Conceal' } },
                            virt_text_pos = 'inline',
                        },
                    },
                    [types.choiceNode] = {
                        active = {
                            virt_text = { { '(snippet) choice node', 'LspInlayHint' } },
                        },
                    },
                },
            }
        end,
        config = function(_, opts)
            local luasnip = require 'luasnip'
            ---@diagnostic disable: undefined-field
            luasnip.setup(opts)
            require('luasnip.loaders.from_vscode').lazy_load()
            -- {
            --     paths = vim.fn.stdpath 'config' .. '/snippets',
            -- }

            -- Use <C-c> to select a choice in a snippet.
            vim.keymap.set({ 'i', 's' }, '<C-c>', function()
                if luasnip.choice_active() then
                    require 'luasnip.extras.select_choice'()
                end
            end, { desc = 'Select choice' })
            ---@diagnostic enable: undefined-field
        end,
    },
    {
        'saghen/blink.cmp',
        event = 'InsertEnter',
        dependencies = 'LuaSnip',
        build = 'cargo build --release',
        opts = {
            -- keymap = {
            --     preset = 'super-tab',
            -- }
            keymap = {
                ['<CR>'] = { 'accept', 'fallback' },
                ['<C-\\>'] = { 'hide', 'fallback' },
                ['<C-n>'] = { 'select_next', 'show' },
                ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
                ['<C-p>'] = { 'select_prev' },
                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            },
            completion = {
                list = {
                    selection = { preselect = false, auto_insert = true },
                    max_items = 10,
                },
                documentation = { auto_show = true },
            },
            snippets = { preset = 'luasnip' },
            cmdline = { enabled = false },
            sources = {
                default = { 'lsp', 'buffer', 'path', 'snippets' }
            },
        },
        config = function (_, opts)
            require'blink.cmp'.setup(opts)
            vim.lsp.config('*', { capabilities = require'blink.cmp'.get_lsp_capabilities(nil, true) })
        end
    }
}
