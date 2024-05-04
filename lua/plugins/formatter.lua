return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local get_eslint = function(bufnr)
            if require("conform").get_formatter_info("eslint_d", bufnr).available then
                return { "eslint_d", "prettier" }
            else
                return { "prettier" }
            end
        end
        require("conform").setup({
            formatters_by_ft = {
                javascript = get_eslint,
                typescript = get_eslint,
                vue = get_eslint,
                html = get_eslint,
                css = get_eslint,
                scss = get_eslint,
                json = get_eslint,
                -- markdown = { { "prettierd", "prettier" } },
                yaml = get_eslint,
                svelte = get_eslint,
                lua = { "stylua" },
                python = function(bufnr)
                    if require("conform").get_formatter_info("ruff_format", bufnr).available then
                        return { "ruff_fix", "ruff_format" }
                    else
                        return { "isort", { "darker", "black" } }
                    end
                end,
                csharp = { "csharpier" },
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

        local util = require("conform.util")

        require("conform.formatters.prettierd").env = {
            PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/default/formatter-configs/.prettierrc.json"),
        }

        require("conform").formatters.darker = {
            prepend_args = { "-i", "-f" },
        }

        require("conform").formatters.ruff_fix = {
            prepend_args = { "--select", "I" },
        }
    end,
}
