return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'fannheyward/telescope-coc.nvim'

    },
    opts = {
        extensions = {
            fzf = {
                fuzzy = true,                   -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true,    -- override the file sorter
                case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            },
            coc = {
                prefer_locations = true,
            }
        }
    },
    config = function(_, opts)
        local telescope = require('telescope')
        telescope.setup(opts)
        telescope.load_extension('dap')
        telescope.load_extension('fzf')
        telescope.load_extension('coc')

    end
}
