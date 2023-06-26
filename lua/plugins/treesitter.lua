return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = {
            "arduino",
            "c",
            "c_sharp",
            "cpp",
            "java",
            "javascript",
            "json",
            "lua",
            "markdown",
            "python",
            "query",
            "rust",
            "toml",
            "typescript",
            "vim",
            "vimdoc",
            "yaml",
        },
        sync_install = false,
        ignore_install = { "" },
        highlight = {
            enable = true,
            disable = { "" },
            additional_vim_regex_highlighting = true,
        },
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
    },
    config = function(_,opts)
        require'nvim-treesitter.configs'.setup(opts)
    end,
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
}
