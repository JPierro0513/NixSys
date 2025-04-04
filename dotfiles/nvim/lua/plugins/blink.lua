return {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    version = 'v1.1.0',
    build = function()
        vim.fn.system 'cargo build --release'
    end,
    opts = {
        keymap = { preset = 'super-tab' },
        completion = { documentation = { auto_show = true } },
        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },
    },
}
