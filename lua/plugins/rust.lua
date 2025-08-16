return {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
    config = function()
        vim.g.rustaceanvim = {
            tools = {
                float_win_config = { auto_focus = true },
            },
            server = {
                on_attach = function(client, bufnr)
                    local wk = require("which-key")
                    wk.add({
                        {
                            "<leader>a",
                            function()
                                vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
                            end,
                            desc = "Open Codeaction",
                            mode = "n",
                        },
                        {
                            "<leader>k",
                            function()
                                local winid = require("ufo").peekFoldedLinesUnderCursor()
                                if not winid then
                                    vim.cmd.RustLsp({ "hover", "actions" })
                                end
                            end,
                            desc = "Open Hover",
                            mode = "n",
                        },
                    })
                end,
                default_settings = {
                    ["rust-analyzer"] = {
                        diagnostics = {
                            enable = true,
                        },
                        checkOnSave = true,
                    },
                },
            },
            dap = {},
        }
    end,
}
