require'utils'.load('saghen/blink.cmp', {
    install = {
        checkout = 'v0.14.2',
        -- hooks = { post_checkout = function() vim.fn.system 'cargo build --release' end },
    },
    name = 'blink.cmp',
    lazy = true,
    opts = {
        keymap     = { preset = 'super-tab' },
        completion = {
            menu = {
                border = 'rounded',
            },
            documentation = {
                auto_show = true,
                window = { border = 'rounded' },
            },
        },
        cmdline    = { enabled = false },
        sources    = {
            default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
                lazydev = {
                    name = 'LazyDev',
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        }
    }
})
