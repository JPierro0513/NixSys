return {
    'stevearc/oil.nvim',
    lazy = false,
    keys = {
        { '-', '<CMD>Oil<CR>', desc = "Open Oil" },
    },
    opts = {
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        keymaps = {
            ["q"] = { "actions.close", mode = "n" },
        },
        view_options = {
            show_hidden = true,
        },
    }
}
