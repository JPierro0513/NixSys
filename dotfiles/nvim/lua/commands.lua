vim.api.nvim_create_autocmd('FileType', {
    desc = 'Close with <q>',
    pattern = {
        'git',
        'help',
        'man',
        'qf',
        'query',
        'scratch',
    },
    callback = function(args)
        vim.keymap.set('n', 'q', '<cmd>quit<cr>', { buffer = args.buf })
    end,
})

vim.api.nvim_create_autocmd('CmdwinEnter', {
    desc = 'Execute command and stay in the command-line window',
    callback = function(args)
        vim.keymap.set({ 'n', 'i' }, '<S-CR>', '<cr>q:', { buffer = args.buf })
    end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
    desc = 'Go to the last location when opening a buffer',
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.cmd 'normal! g`"zz'
        end
    end,
})

-- vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'CmdlineLeave', 'WinEnter' }, {
--     desc = 'Toggle relative line numbers on',
--     callback = function()
--         if vim.wo.nu and not vim.startswith(vim.api.nvim_get_mode().mode, 'i') then
--             vim.wo.relativenumber = true
--         end
--     end,
-- })
-- vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'CmdlineEnter', 'WinLeave' }, {
--     desc = 'Toggle relative line numbers off',
--     callback = function(args)
--         if vim.wo.nu then
--             vim.wo.relativenumber = false
--         end
--
--         -- Redraw here to avoid having to first write something for the line numbers to update.
--         if args.event == 'CmdlineEnter' then
--             if not vim.tbl_contains({ '@', '-' }, vim.v.event.cmdtype) then
--                 vim.cmd.redraw()
--             end
--         end
--     end,
-- })

vim.api.nvim_create_autocmd({ 'BufDelete', 'BufWipeout' }, {
    desc = 'Write to ShaDa when deleting/wiping out buffers',
    command = 'wshada',
})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight on yank',
    callback = function()
        -- Setting a priority higher than the LSP references one.
        vim.hl.on_yank { higroup = 'Visual', priority = 250 }
    end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
    callback = function()
        vim.cmd [[%s/\s\+$//e]]
    end,
})

vim.api.nvim_create_autocmd({'BufWinEnter', 'BufNewFile'}, {
    callback = function()
        vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
    end
})
