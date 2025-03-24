return {
    -- {
    --     "armannikoyan/rusty",
    --     enable = false,
    --     lazy = false,
    --     priority = 1000,
    --     opts = {
    --         transparent = false,
    --         italic_comments = false,
    --         underline_current_line = true,
    --     },
    --     config = function(_, opts)
    --         require("rusty").setup(opts)
    --         vim.cmd("colorscheme rusty")
    --     end,
    -- },
    -- {
    --     'vague2k/vague.nvim',
    --     enable = false,
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         vim.cmd.colorscheme 'vague'
    --     end,
    -- },
    {
        "slugbyte/lackluster.nvim",
        lazy = false,
        priority = 1000,
        -- init = function()
        --     vim.cmd.colorscheme 'lackluster-hack'
        --     -- vim.cmd.colorscheme("lackluster-hack") -- my favorite
        --     -- vim.cmd.colorscheme("lackluster-mint")
        -- end,
        config = function()
            local lack = require'lackluster'
            ---@diagnostic disable-next-line: missing-fields
            lack.setup({
                tweak_pallet = {

                },
                tweak_syntax = {
                    keyword = '#8a4843',
                    type = lack.color.green,
                }
            })
            vim.cmd.colorscheme 'lackluster'
        end
    }
}
