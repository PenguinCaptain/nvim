return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "html",
                -- "javascript",
                "json",
                "lua",
                "markdown",
                "toml",
                "yaml",
            },
            auto_install = true,
            sync_install = false,
            ignore_install = { "" },
            highlight = {
                enable = true,
                disable = { "" },
                additional_vim_regex_highlighting = true,
            },
            indent = { enable = true },
            autotag = {
                enable = true,
                enable_rename = true,
                enable_close = true,
                enable_close_on_slash = true,
                filetypes = { "html", "xml", "vue" },
            },
            endwise = {
                enable = true,
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
    },
    {
        "RRethy/nvim-treesitter-endwise",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "PenguinCaptain/nvim-ts-autotag",
        branch = "hotfix/issue-145",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
}
