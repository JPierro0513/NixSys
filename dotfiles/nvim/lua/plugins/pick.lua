return {
    'echasnovski/mini.pick',
    opts = {
        options = {
            use_cache = true,
        }
    },
    keys = {
        { '<leader> ', function() require'mini.pick'.builtin.files() end, desc = 'Pick Files' },
    }
}
