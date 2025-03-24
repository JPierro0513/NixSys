return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        { 'b0o/SchemaStore.nvim', version = false },
    },
    config = function()
        require('lspconfig.ui.windows').default_options.border = 'rounded'

        local function configure_server(server, settings)
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

            require('lspconfig')[server].setup(
                vim.tbl_deep_extend('error', { capabilities = capabilities, silent = true }, settings or {})
            )
        end

        require'mason'.setup({
            ensure_installed = { 'stylua', 'shfmt' },
        })

        -- Use the same settings for JS and TS.
        local lang_settings = {
            suggest = { completeFunctionCalls = true },
            inlayHints = {
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                variableTypes = { enabled = true },
            },
        }

        ---@diagnostic disable-next-line: missing-fields
        require'mason-lspconfig'.setup({
            ensure_installed = {
                'bashls', 'html', 'cssls', 'pyright', 'ruff', 'eslint', 'jsonls', 'vtsls', 'rust_analyzer',
            },
            handlers = {
                ['jsonls'] = configure_server('jsonls', {
                    settings = {
                        json = {
                            validate = { enable = true },
                        },
                    },
                    on_new_config = function(config)
                        config.settings.json.schemas = config.settings.json.schemas or {}
                        vim.list_extend(config.settings.json.schemas, require('schemastore').json.schemas())
                    end,
                }),

                ['eslint'] = configure_server('eslint', {
                filetypes = {
                    'graphql',
                    'javascript',
                    'javascriptreact',
                    'typescript',
                    'typescriptreact',
                },
                settings = { format = false },
                on_attach = function(_, bufnr)
                    vim.keymap.set(
                        'n',
                        '<leader>ce',
                        '<cmd>EslintFixAll<cr>',
                        { desc = 'Fix all ESLint errors', buffer = bufnr }
                    )
                end,
                }),

                ['rust_analyzer'] = configure_server('rust_analyzer', {
                settings = {
                    ['rust-analyzer'] = {
                        inlayHints = {
                            -- These are a bit too much.
                            chainingHints = { enable = false },
                        },
                    },
                },
                }),

                ['vtsls'] = configure_server('vtsls', {
                    settings = {
                    typescript = lang_settings,
                    javascript = lang_settings,
                    vtsls = {
                        -- Automatically use workspace version of TypeScript lib on startup.
                        autoUseWorkspaceTsdk = true,
                        experimental = {
                            -- Inlay hint truncation.
                            maxInlayHintLength = 30,
                            -- For completion performance.
                            completion = {
                                enableServerSideFuzzyMatch = true,
                            },
                        },
                    },
                    },
                }),

                configure_server
            }
        })

        configure_server('clangd', {
                cmd = {
                    'clangd',
                    '--clang-tidy',
                    '--header-insertion=iwyu',
                    '--completion-style=detailed',
                    '--fallback-style=none',
                    '--function-arg-placeholders=false',
                },
            })

        configure_server('lua_ls', {
            on_init = function(client)
                local path = client.workspace_folders
                    and client.workspace_folders[1]
                    and client.workspace_folders[1].name
                if
                    not path
                    or not (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                then
                    client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                        Lua = {
                            runtime = { version = 'LuaJIT' },
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME,
                                    '${3rd}/luv/library',
                                },
                            },
                        }
                    })
                    client:notify(
                        vim.lsp.protocol.Methods.workspace_didChangeConfiguration,
                        { settings = client.config.settings }
                    )
                end
                return true
            end,
            settings = {
                Lua = {
                    -- format = { enable = false },
                    hint = { enable = true },
                    completion = { callSnippet = 'Replace' },
                },
            },
        })

        configure_server 'nil_ls'

    end,
}
