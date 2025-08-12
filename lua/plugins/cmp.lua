return {
    {
        "saghen/blink.compat",
        version = "2.*",
        lazy = true,
        opts = {},
    },
    {
        "saghen/blink.cmp",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                dependencies = { "rafamadriz/friendly-snippets" },
                config = function()
                    -- Load snippets from friendly-snippets
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
            { "Kaiser-Yang/blink-cmp-avante" },
            { "hrsh7th/cmp-calc" },
            { "moyiz/blink-emoji.nvim" },
            { "MahanRahmati/blink-nerdfont.nvim" },
            { "onsails/lspkind.nvim" },
        },

        version = "1.*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            --
            enabled = function()
                return not vim.tbl_contains({ "markdown", "AvanteInput" }, vim.bo.filetype)
            end,

            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = {
                preset = "super-tab",
                ["<CR>"] = { "accept", "fallback" },
            },

            cmdline = {
                keymap = {
                    preset = "inherit",
                    ["<Tab>"] = { "show_and_insert", "select_next", "fallback" },
                    ["<S-Tab>"] = { "show", "select_prev", "fallback" },
                    ["<CR>"] = {
                        function(cmp)
                            if cmp.is_menu_visible() then
                                cmp.accept()
                            else
                                vim.api.nvim_feedkeys(
                                    vim.api.nvim_replace_termcodes("<CR>", true, false, true),
                                    "n",
                                    false
                                )
                            end
                        end,
                    },
                },
            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono",
            },

            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
                trigger = { show_in_snippet = false },
                list = {
                    selection = {
                        preselect = function(ctx)
                            return not require("blink.cmp").snippet_active({ direction = 1 })
                        end,
                    },
                },
            },

            snippets = { preset = "luasnip" },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer", "avante", "emoji", "nerdfont", "calc" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                        opts = {},
                    },
                    calc = {
                        name = "calc",
                        module = "blink.compat.source",
                        opts = {},
                    },
                    emoji = {
                        module = "blink-emoji",
                        name = "Emoji",
                        opts = {
                            score_offset = 15,
                            opts = {
                                insert = true,
                                ---@type string|table|fun():table
                                trigger = function()
                                    return { ":" }
                                end,
                                should_show_items = function()
                                    return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
                                end,
                            },
                        },
                    },
                    avante = {
                        module = "blink-cmp-avante",
                        name = "Avante",
                        opts = {},
                    },
                    nerdfont = {
                        module = "blink-nerdfont",
                        name = "Nerd Fonts",
                        opts = {
                            score_offset = 15,
                            opts = {
                                insert = true,
                                ---@type string|table|fun():table
                                trigger = function()
                                    return { ":" }
                                end,
                                should_show_items = function()
                                    return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
                                end,
                            },
                        },
                    },
                },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
}
