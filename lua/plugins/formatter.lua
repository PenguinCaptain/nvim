return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>=",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    config = function()
        local get_eslint = function(bufnr)
            if require("conform").get_formatter_info("eslint_d", bufnr).available then
                return { "eslint_d", "prettier" }
            else
                return { "prettier" }
            end
        end

        local get_ruff = function(bufnr)
            if require("conform").get_formatter_info("ruff_format", bufnr).available then
                return { "ruff_fix", "ruff_format", "ruff_organize_imports" }
            else
                return { "isort", "black" }
            end
        end
        require("conform").setup({
            formatters_by_ft = {
                javascript = get_eslint,
                typescript = get_eslint,
                javascriptreact = get_eslint,
                typescriptreact = get_eslint,
                vue = get_eslint,
                html = { "html_beautify" },
                css = get_eslint,
                scss = get_eslint,
                json = get_eslint,
                -- markdown = { { "prettierd", "prettier" } },
                yaml = get_eslint,
                svelte = get_eslint,
                lua = { "stylua" },
                python = get_ruff,
                csharp = { "csharpier" },
                cpp = { "clang-format" },
                rust = { "rustfmt" },
            },
            -- format_on_save = {
            --     lsp_fallback = true,
            --     timeout_ms = 500,
            -- },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        })

        local util = require("conform.util")

        require("conform.formatters.prettierd").env = {
            PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/default/editor-configs/.prettierrc.json"),
        }

        require("conform").formatters.darker = {
            prepend_args = { "-i", "-f" },
        }
        require("conform").formatters.eslint_d = {
            append_args = function()
                -- local file_types = { "js", "cjs", "yaml", "yml", "json" }
                -- for _, file_type in pairs(file_types) do
                --     if file_exists(params.root .. "/.eslintrc." .. file_type) then
                --         return {}
                --     end
                -- end

                return {
                    "--config",
                    vim.fn.expand("~/.config/nvim/default/editor-configs/.eslintrc.json"),
                }
            end,
        }

        require("conform").formatters.clang_format = {
            prepend_args = { "--style=file:" .. vim.fn.expand("~/.config/nvim/default/editor-configs/.clang-format") },
        }
        -- require("conform").formatters.ruff_fix = {
        --     prepend_args = { "--select", "I" },
        -- }
    end,
}
