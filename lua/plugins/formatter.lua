return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                javascript = { { "prettierd", "prettier" } },
                typescript = { { "prettierd", "prettier" } },
                vue = { { "prettierd", "prettier" } },
                html = { { "prettierd", "prettier" } },
                css = { { "prettierd", "prettier" } },
                scss = { { "prettierd", "prettier" } },
                json = { { "prettierd", "prettier" } },
                markdown = { { "prettierd", "prettier" } },
                yaml = { { "prettierd", "prettier" } },
                svelte = { { "prettierd", "prettier" } },
                lua = { "stylua" },
            },
            format_on_save = {
                lsp_fallback = true,
                timeout_ms = 500,
            },
        })
        vim.keymap.set({ "n", "x" }, "<leader>=", function()
            require("conform").format({
                lsp_fallback = true,
                async = true,
            })
        end, { silent = true })

        require("conform.formatters.prettierd").env = {
            PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/default/formatter-configs/.prettierrc.json"),
        }
    end,
}
