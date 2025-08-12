return {
    "mfussenegger/nvim-lint",

    opts = {
        -- other config
        linters = {
            eslint_d = {
                args = {
                    "--no-warn-ignored", -- <-- this is the key argument
                    "--format",
                    "json",
                    "--stdin",
                    "--stdin-filename",
                    function()
                        return vim.api.nvim_buf_get_name(0)
                    end,
                },
            },
        },
    },
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            svelte = { "eslint_d" },
            python = { "ruff" },
        }
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
                lint.try_lint("codespell")
            end,
        })
    end,
}
