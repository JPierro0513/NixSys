local diagnostic_icons = {
    ERROR = '',
    WARN = '',
    HINT = '',
    INFO = '',
}

local function on_attach(client, bufnr)
    local function map(lhs, rhs, desc, mode)
        vim.keymap.set(
            mode or 'n',
            lhs, rhs,
            { desc = desc, buffer = bufnr }
        )
    end

    map('[e', function()
        vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR }
    end, 'Previous error')
    map(']e', function()
        vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR }
    end, 'Next error')

    if client:supports_method('textDocument/signatureHelp') then
        local blink_window = require 'blink.cmp.completion.windows.menu'
        local blink = require 'blink.cmp'

        map('<C-k>', function()
            -- Close the completion menu first (if open).
            if blink_window.win:is_open() then
                blink.hide()
            end

            vim.lsp.buf.signature_help()
        end, 'Signature help', 'i')
    end

    if client:supports_method('textDocument/documentHighlight') then
        vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave' }, {
            desc = 'Highlight references under the cursor',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'BufLeave' }, {
            desc = 'Clear highlight references',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end

    -- if client:supports_method('textDocument/completion') then
    --     client.server_capabilities.completionProvider.triggerCharacters = vim.split("qwertyuiopasdfghjklzxcvbnm. ", "")
    --     vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    -- end
end

vim.diagnostic.config {
    severity_sort = true,
    virtual_text = false,
    float = { border = 'rounded', source = 'if_many' },
    signs = {
        text = {
            [vim.diagnostic.severity.E] = diagnostic_icons.ERROR,
            [vim.diagnostic.severity.W] = diagnostic_icons.WARN,
            [vim.diagnostic.severity.N] = diagnostic_icons.HINT,
            [vim.diagnostic.severity.I] = diagnostic_icons.INFO,
        },
    },
}

local methods = vim.lsp.protocol.Methods
local register_capability = vim.lsp.handlers[methods.client_registerCapability]
vim.lsp.handlers[methods.client_registerCapability] = function(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then return end
    on_attach(client, vim.api.nvim_get_current_buf())
    return register_capability(err, res, ctx)
end

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Configure LSP keymaps',
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end
        on_attach(client, args.buf)
    end
})

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
    once = true,
    callback = function()
        ---@param name string
        ---@param config vim.lsp.Config
        local function configure_server(name, config)
            vim.lsp.config(name, config)
            vim.lsp.enable(name)
        end

        configure_server('nixd', {
            cmd = { 'nixd' },
            filetypes = { 'nix' }
        })

        configure_server('lua_ls', {
            cmd = { 'lua-language-server' },
            filetypes = { 'lua' },
            root_markers = { '.luarc.json', '.luarc.jsonc' },
            -- NOTE: These will be merged with the configuration file.
            settings = {
                Lua = {
                    completion = { callSnippet = 'Replace' },
                    -- Using stylua for formatting.
                    format = { enable = false },
                    hint = {
                        enable = true,
                        arrayIndex = 'Disable',
                    },
                    runtime = {
                        version = 'LuaJIT',
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME,
                            '${3rd}/luv/library',
                        },
                    },
                },
            },
        })
    end
})

