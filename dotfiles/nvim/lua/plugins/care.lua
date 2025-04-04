return {
    "max397574/care.nvim",
    lazy = false,
    dependencies = {
        {
            "romgrk/fzy-lua-native",
            build = "make"
        }
    },
    config = function()
        require'care'.setup({
            config = {
                ui = {
                    ghost_text = false,
                    type_icons = "mini.icons",
                },
            },
        })

        vim.keymap.set("i", "<c-n>", function() vim.snippet.jump(1) end)
        vim.keymap.set("i", "<c-p>", function() vim.snippet.jump(-1) end)
        vim.keymap.set("i", "<c-space>", function() require("care").api.complete() end)

        vim.keymap.set("i", "<cr>", "<Plug>(CareConfirm)")
        vim.keymap.set("i", "<c-e>", "<Plug>(CareClose)")
        vim.keymap.set("i", "<tab>", "<Plug>(CareSelectNext)")
        vim.keymap.set("i", "<s-tab>", "<Plug>(CareSelectPrev)")

        vim.keymap.set("i", "<c-f>", function()
            if require("care").api.doc_is_open() then
                require("care").api.scroll_docs(4)
            else
                vim.api.nvim_feedkeys(vim.keycode("<c-f>"), "n", false)
            end
        end)

        vim.keymap.set("i", "<c-b>", function()
            if require("care").api.doc_is_open() then
                require("care").api.scroll_docs(-4)
            else
                vim.api.nvim_feedkeys(vim.keycode("<c-d>"), "n", false)
            end
        end)
    end
}
