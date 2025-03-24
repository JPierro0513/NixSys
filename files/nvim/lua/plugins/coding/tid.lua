return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "LspAttach", 
        priority = 1000, -- needs to be loaded in first
        config = function()
            require('tiny-inline-diagnostic').setup({
                preset = 'modern',
                options = {
                    use_icons_from_diagnostic = true,
                    set_arrow_to_diag_color = false,
                    multilines = {
                        enabled = true,
                        always_show = true,
                    },
                },
            })
        end
    }
}
