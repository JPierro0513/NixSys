local M = {}

M.load = function(plugin, spec)
    local path, file = plugin:match("(.-)([^\\/]-%.?([^%.\\/]*))$")

    if not spec then return require(plugin) end

    if path ~= '' then
        MiniDeps.add(vim.tbl_deep_extend(
            'force',
            { source = plugin },
            spec.install or {}
        ))
    end

    if spec.name then
        file = spec.name
    else
        local p = file:find('.nvim')
        if p ~= nil then file = file:sub(1, p - 1) end
    end

    if spec.opts then
        if spec.lazy then
            return MiniDeps.later(function() require(file).setup(spec.opts) end)
        else
            return MiniDeps.now(function() require(file).setup(spec.opts) end)
        end
    end
end

M.map = function(lhs, rhs, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, lhs, rhs,
        { desc = desc, silent = true, noremap = true }
    )
end

return M
