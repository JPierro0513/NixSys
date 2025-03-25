local load = require'utils'.load

load('neovim/nvim-lspconfig', {
    install = {
        depends = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            'folke/lazydev.nvim',
            'rachartier/tiny-inline-diagnostic.nvim',
            'j-hui/fidget.nvim',
        }
    }
})

load('fidget', { lazy = true, opts = {} })

load('tiny-inline-diagnostic', {
    lazy = true,
    opts = {
        options = {
            use_icons_from_diagnostic = true,
            multilines = {
                enabled = false,
                always_show = false,
            },
        }
    }
})

load('mason', {
    lazy = true,
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    }
})

load('mason-tool-installer', {
    lazy = true,
    opts = {
        ensure_installed = {
            'stylua', 'alejandra',
        },
    }
})

local function configure_server(server, settings)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

    require('lspconfig')[server].setup(
        vim.tbl_deep_extend('error', { capabilities = capabilities, silent = true }, settings or {})
    )
end

load('mason-lspconfig', {
    lazy = true,
    opts = {
        ensure_installed = {
            'bashls', 'lua_ls', 'nil_ls',
        },
        handlers = {

            ['lua_ls'] = configure_server('lua_ls', {
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                                '${3rd}/luv/library',
                            },
                        },
                        -- Using stylua for formatting.
                        format = { enable = false },
                        hint = {
                            enable = true,
                            arrayIndex = 'Disable',
                        },
                        completion = { callSnippet = 'Replace' },
                    },
                }
            }),

            ['nil_ls'] = configure_server('nil_ls', {
                settings = {
                    Nil = {
                        formatting = {
                            command = { "alejandra" },
                        },
                    }
                }
            }),

            configure_server
        },
    }
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'lua',
    callback = function()
        ---@diagnostic disable-next-line: missing-fields
        require 'lazydev'.setup {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "snacks.nvim",        words = { "Snacks" } },
                { path = "mini.nvim" },
            },
        }
    end,
})
