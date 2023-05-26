local M = {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = { "vim", "bash", "c", "cpp", "javascript", "lua"},
        highlight = { enable = true },
        indent = { enable = true},
        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = nil,
        },
        autotag = {
            enable = true,
        },
        endwise = {
            enable = true,
        },
        indent = {
            enable = true,
        },
    },
    config = function(_,opts)
        require'nvim-treesitter.configs'.setup(opts)
    end,
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
}

return { M }
