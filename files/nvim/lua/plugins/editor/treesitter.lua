return {
    'nvim-treesitter/nvim-treesitter',
    event = { "LazyFile" },
    version = false,
    build = ':TSUpdate',
    opts = {
        ensure_installed = {
            'bash', 
            'c', 'cpp', 'cmake',
            'gitcommit', 
            'html', 'css', 'scss',
            'java',
            'javascript', 'typescript', 'tsx',
            'json', 'jsonc', 'json5',
            'lua',
            'markdown', 'markdown_inline',
            'python',
            'query', 'rasi', 'rst', 'regex',
            'rust',
            'toml', 'yaml',
            'vim', 'vimdoc',
        },
        hightlight = { enable = true },
        indent = { enable = true, disable = { 'yaml' } },
    },
    config = function(_, opts)
        require'nvim-treesitter.configs'.setup(opts)
    end,
}
