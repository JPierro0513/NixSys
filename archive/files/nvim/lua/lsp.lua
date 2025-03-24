local diagnostic_icons = {
    ERROR = ' ',
    WARN = ' ',
    HINT = ' ',
    INFO = ' ',
}
local methods = vim.lsp.protocol.Methods

local function on_attach(client, bufnr)
    local function map(lhs, rhs, desc, mode)
        vim.keymap.set(mode or 'n', lhs, rhs, { desc = desc, noremap = true, buffer = bufnr })
    end

    map('gra', vim.lsp.buf.code_action, 'LSP Code Action')
    map('grr', vim.lsp.buf.references,  'LSP References')
    map('gy',  vim.lsp.buf.type_definition, 'LSP Type Definition')

    map('<leader>fs', vim.lsp.buf.document_symbol, 'LSP Document Symbols')
    map('<leader>fS', vim.lsp.buf.workspace_symbol, 'LSP Workspace Symbols')

    map('[e', function()
        vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR }
    end, 'Previous error')
    map(']e', function()
        vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR }
    end, 'Next error')

    if client:supports_method(methods.textDocument_definition) then
        map('gd', vim.lsp.buf.declaration, 'Go to definition')
        map('gD', vim.lsp.buf.definition, 'Peek definition')
    end

    if client:supports_method(methods.textDocument_signatureHelp) then
        local blink_window = require 'blink.cmp.completion.windows.menu'
        local blink = require 'blink.cmp'

        map('<C-k>', function()
            if blink_window.win:is_open() then
                blink.hide()
            end

            vim.lsp.buf.signature_help()
        end, 'Signature help', 'i')
    end

    if client:supports_method(methods.textDocument_documentHighlight) then
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
end

vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.E] = diagnostic_icons.ERROR,
            [vim.diagnostic.severity.W] = diagnostic_icons.WARN,
            [vim.diagnostic.severity.N] = diagnostic_icons.HINT,
            [vim.diagnostic.severity.I] = diagnostic_icons.INFO,
        },
    },
    float = {
        border = 'rounded',
        source = 'if_many',
        prefix = function(diag)
            local level = vim.diagnostic.severity[diag.severity]
            local prefix = string.format(' %s ', diagnostic_icons[level])
            return prefix, 'Diagnostic' .. level:gsub('^%l', string.upper)
        end,
    },
})

-- Update mappings when registering dynamic capabilities.
local register_capability = vim.lsp.handlers[methods.client_registerCapability]
vim.lsp.handlers[methods.client_registerCapability] = function(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then
        return
    end

    on_attach(client, vim.api.nvim_get_current_buf())

    return register_capability(err, res, ctx)
end

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Configure LSP keymaps',
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- I don't think this can happen but it's a wild world out there.
        if not client then
            return
        end

        on_attach(client, args.buf)
    end,
})
