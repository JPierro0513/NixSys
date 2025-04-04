local function setup()
    _G.MapKey = function(lhs, rhs, desc, mode, opts)
        vim.keymap.set(mode or 'n', lhs, rhs, vim.tbl_deep_extend('force', { desc = desc, silent = true, noremap = true }, opts or {}))
    end

--     _G.PlugAdd = function(plugin, opts)
--         opts = opts or {}
--
--         local start
--         if opts.auto then start = '/start/'
--         else              start = '/opt/'
--         end
--
--         local name = plugin:gsub(".*/", "")
--         print(name)
--         local path = vim.fn.stdpath 'data' .. '/site/pack/pac' .. start .. name
--         print(path)
--
--         local branch
--         if opts.rev then
--              branch = '--branch='..opts.rev
--         else branch = '--branch=main'
--         end
--
--         if not vim.uv.fs_stat(path) then
--             print('Installing: '..name..' ...')
--             vim.fn.system({
--                 'git', 'clone', '--filter=blob:none',
--                 branch,
--                 'https://github.com/'..plugin,
--                 path
--             })
--             vim.cmd 'redraw'
--             print('Success')
--         end
--
--         if not opts.auto then vim.cmd('packadd ' .. name) end
--
--         if opts.after then
--             opts.after()
--         end
--
--     end
end


setup()
