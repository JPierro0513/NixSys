return {
    {
        'saghen/blink.pairs',
        version = '*', -- (recommended) only required with prebuilt binaries
        dependencies = 'saghen/blink.download',
        build = 'cargo build --release',
        event = 'InsertEnter',
        --- @module 'blink.pairs'
        opts = {
            mappings = {
                enabled = true,
                pairs = {
                    ['('] = ')',
                    ['['] = ']',
                    ['{'] = '}',
                    ["'"] = { closing = "'", enter = false },
                    ['"'] = { closing = '"', enter = false },
                    ['`'] = { closing = '`', enter = false },
                },
            },
            highlights = {
                enabled = true,
                groups = {
                    'BlinkPairsOrange',
                    'BlinkPairsPurple',
                    'BlinkPairsBlue',
                },
                priority = 200,
                ns = vim.api.nvim_create_namespace('blink.pairs'),
            },
            debug = false,
        }
    },
    {
        'saghen/blink.cmp',
        version = 'v0.14.0',
        build = 'cargo build --release',
        event = 'InsertEnter',
        opts = {
            keymap = {
                preset = "super-tab",
                ["<C-y>"] = { "select_and_accept" },
            },
            completion = {
                list = {
                    selection = { auto_insert = false },
                    max_items = 15,
                },
                menu = {
                    border = 'rounded',
                    draw = {
                        treesitter = { "lsp" },
                        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
                    },
                },
                documentation = {
                    auto_show = true,
                    window = { border = 'rounded' },
                },
            },
            cmdline = { enabled = false },
            sources = {
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100, -- show at a higher priority than lsp
                    },
                },
            },
            appearance = {
                use_nvim_cmp_as_default = true,
            }
        },
    },
}
