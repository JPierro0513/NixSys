return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        {
            "smjonas/inc-rename.nvim",
            opts = {},
            keys = {
                { '<leader>rn', ':IncRename ', desc = 'Inc-Rename input' },
                {
                    '<leader>rN',
                    function()
                        return ':IncRename ' .. vim.fn.expand('<cword>')
                    end,
                    expr = true,
                    desc = 'Inc-Rename word under cursor'
                }
            }
        },
        "MunifTanjim/nui.nvim",
    },
    ---@module 'noice.config'
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
        },
        presets = {
            long_message_to_split = true,
            inc_rename = true,
            lsp_doc_border = true,
        },
        routes = {
            {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "written" },
                        { find = "<ed" },
                        { find = ">ed" },
                    }
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "%d+L, %d+B" },
                        { find = "; after #%d+" },
                        { find = "; before #%d+" },
                    },
                },
                view = "mini",
            },
        },
    },
}
