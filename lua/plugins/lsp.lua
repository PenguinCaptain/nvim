return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },
    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                dependencies = { "rafamadriz/friendly-snippets" },
            },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lua" },
            { "onsails/lspkind.nvim" },
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require("cmp")
            local cmp_action = lsp_zero.cmp_action()

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "luasnip" },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<Tab>"] = cmp_action.tab_complete(),
                    ["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
                }),
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                    format = require("lspkind").cmp_format({
                        mode = "symbol", -- show only symbol annotations
                        maxwidth = 50, -- prevent the popup from showing more than provided characters
                        ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
                    }),
                },
                preselect = "item",
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
            })
        end,
    },
    -- LSP
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason-lspconfig.nvim" },
            { "lvimuser/lsp-inlayhints.nvim" },
            {
                "weilbith/nvim-code-action-menu",
                cmd = "CodeActionMenu",
                config = function()
                    vim.g.code_action_menu_show_details = false
                    vim.g.code_action_menu_show_diff = false
                end,
            },
            { "ray-x/lsp_signature.nvim" },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local ih = require("lsp-inlayhints")
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                local wk = require("which-key")
                local fmt = function(cmd)
                    return function(str)
                        return cmd:format(str)
                    end
                end
                local lsp = fmt("<cmd>lua vim.lsp.%s<cr>")
                local lsp_telescope = fmt("<cmd>Telescope lsp_%s<cr>")
                local diagnostic = fmt("<cmd>lua vim.diagnostic.%s<cr>")
                wk.register({
                    g = {
                        d = { lsp_telescope("definitions"), "Jump to definition" },
                        D = { lsp("buf.declaration()"), "Jump to declaration" },
                        i = { lsp_telescope("implementations"), "Jump to implementation" },
                        o = { lsp_telescope("type_definitions"), "Jump to type definition" },
                        r = { lsp_telescope("references"), "Jump to references" },
                        s = { lsp("buf.signature_help()"), "Show signature help" },
                        l = { diagnostic("open_float()"), "Show diagnostics" },
                    },
                    ["rn"] = { lsp("buf.rename()"), "Rename" },
                    ["<M-CR>"] = { ":CodeActionMenu<cr>", "Code actions" },
                    ["[g"] = { diagnostic("goto_prev()"), "Previous diagnostic" },
                    ["]g"] = { diagnostic("goto_next()"), "Next diagnostic" },
                }, {
                    buffer = bufnr,
                    silent = true,
                })

                ih.on_attach(client, bufnr)
            end)

            lsp_zero.set_server_config({
                capabilities = {
                    textDocument = {
                        foldingRange = {
                            dynamicRegistration = false,
                            lineFoldingOnly = true,
                        },
                    },
                },
            })

            local group = vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
            vim.api.nvim_create_autocmd({ "CursorHold" }, {
                pattern = "*",
                callback = function()
                    vim.diagnostic.open_float(0, {
                        scope = "cursor",
                        focusable = false,
                        zindex = 10,
                        close_events = {
                            "CursorMoved",
                            "CursorMovedI",
                            "BufHidden",
                            "InsertCharPre",
                            "InsertEnter",
                            "WinLeave",
                            "ModeChanged",
                        },
                    })
                end,
                group = group,
            })

            require("lsp_signature").setup({
                bind = true,
                hint_enable = false,
                hint_prefix = "",
                handler_opts = {
                    border = "rounded",
                },
            })

            ih.setup({
                inlay_hints = {
                    only_current_line = false,
                    -- whether to align to the length of the longest line in the file
                    max_len_align = false,
                    -- padding from the left if max_len_align is true
                    max_len_align_padding = 1,
                },
            })

            -- vim.cmd("hi link LspInlayHint Comment")

            local lspc = require("lspconfig")
            lspc.lua_ls.setup({
                settings = {
                    Lua = {
                        hint = {
                            enable = true,
                        },
                    },
                },
            })

            lspc.tsserver.setup({
                settings = {
                    typescript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                    javascript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                },
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "jsonls",
                    "tsserver",
                },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require("lspconfig").lua_ls.setup(lua_opts)
                    end,
                },
            })
        end,
    },
}
