local solid_bar,dashed_bar = '│', '┊'

require('utils').load('lewis6991/gitsigns.nvim', {
    lazy = true,
    opts = {
        signs = {
            add = { text = solid_bar },
            untracked = { text = solid_bar },
            change = { text = solid_bar },
            delete = { text = solid_bar },
            topdelete = { text = solid_bar },
            changedelete = { text = solid_bar },
        },
        signs_staged = {
            add = { text = dashed_bar },
            untracked = { text = dashed_bar },
            change = { text = dashed_bar },
            delete = { text = dashed_bar },
            topdelete = { text = dashed_bar },
            changedelete = { text = dashed_bar },
        },
        preview_config = { border = 'rounded' },
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            -- Mappings.
            ---@param lhs string
            ---@param rhs function
            ---@param desc string
            local function nmap(lhs, rhs, desc)
                vim.keymap.set('n', lhs, rhs, { desc = desc, buffer = bufnr })
            end
            nmap('[g', gs.prev_hunk, 'Previous hunk')
            nmap(']g', gs.next_hunk, 'Next hunk')
            nmap('<leader>gR', gs.reset_buffer, 'Reset buffer')
            nmap('<leader>gb', gs.blame_line, 'Blame line')
            nmap('<leader>gp', gs.preview_hunk, 'Preview hunk')
            nmap('<leader>gr', gs.reset_hunk, 'Reset hunk')
            nmap('<leader>gs', gs.stage_hunk, 'Stage hunk')
            -- nmap('<leader>gl', function()
            --     require('float_term').float_term('lazygit', {
            --         size = { width = 0.85, height = 0.8 },
            --         cwd = vim.b.gitsigns_status_dict.root,
            --     })
            -- end, 'Lazygit')

            -- Text object:
            vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<cr>')
        end,
    },
})
