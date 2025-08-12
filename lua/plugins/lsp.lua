return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    -- -- Autocompletion
    -- {
    --     "hrsh7th/nvim-cmp",
    --     event = "InsertEnter",
    --     dependencies = {
    --         {
    --             "L3MON4D3/LuaSnip",
    --             dependencies = { "rafamadriz/friendly-snippets" },
    --         },
    --         { "saadparwaiz1/cmp_luasnip" },
    --         { "hrsh7th/cmp-nvim-lua" },
    --         { "hrsh7th/cmp-path" },
    --         { "hrsh7th/cmp-calc" },
    --         { "hrsh7th/cmp-emoji" },
    --         { "onsails/lspkind.nvim" },
    --     },
    --     config = function()
    --         -- Here is where you configure the autocompletion settings.
    --         local lsp_zero = require("lsp-zero")
    --         lsp_zero.extend_cmp()
    --
    --         -- And you can configure cmp even more, if you want to.
    --         local cmp = require("cmp")
    --         local cmp_action = lsp_zero.cmp_action()
    --
    --         require("luasnip.loaders.from_vscode").lazy_load()
    --
    --         cmp.setup({
    --             sources = {
    --                 { name = "nvim_lsp" },
    --                 { name = "nvim_lua" },
    --                 { name = "path" },
    --                 { name = "calc" },
    --                 { name = "emoji" },
    --                 { name = "luasnip" },
    --             },
    --             mapping = cmp.mapping.preset.insert({
    --                 ["<CR>"] = cmp.mapping.confirm({ select = false }),
    --                 ["<Tab>"] = cmp_action.tab_complete(),
    --                 ["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
    --                 ["<C-Space>"] = cmp.mapping.complete(),
    --                 ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    --                 ["<C-d>"] = cmp.mapping.scroll_docs(4),
    --                 ["<C-f>"] = cmp_action.luasnip_jump_forward(),
    --                 ["<C-b>"] = cmp_action.luasnip_jump_backward(),
    --             }),
    --             formatting = {
    --                 fields = { "abbr", "kind", "menu" },
    --                 format = require("lspkind").cmp_format({
    --                     mode = "symbol", -- show only symbol annotations
    --                     maxwidth = 50, -- prevent the popup from showing more than provided characters
    --                     ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
    --                 }),
    --             },
    --             preselect = "item",
    --             completion = {
    --                 completeopt = "menu,menuone,noinsert",
    --             },
    --             window = {
    --                 completion = cmp.config.window.bordered(),
    --                 documentation = cmp.config.window.bordered(),
    --             },
    --         })
    --     end,
    -- },
    -- LSP
    {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        opts = {
            bind = true,
            hint_enable = false,
            hint_prefix = "",
            handler_opts = {
                border = "rounded",
            },
        },
    },
    {
        "MysticalDevil/inlay-hints.nvim",
        event = "LspAttach",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require("inlay-hints").setup()
            vim.api.nvim_set_hl(0, "LspInlayHint", { bg = "none", fg = "#545C7E" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- This is where all the LSP shenanigans will live_grep
            --
            local wk = require("which-key")
            local fmt = function(cmd)
                return function(str)
                    return cmd:format(str)
                end
            end
            local lsp_telescope = fmt("<cmd>Telescope lsp_%s<cr>")

            wk.add({
                -- buffer = bufnr,
                silent = true,
                { "g", group = "Jump" },
                { "gd", Snacks.picker.lsp_definitions, desc = "Jump to definition" },
                { "gD", Snacks.picker.lsp_declarations, desc = "Jump to declaration" },
                { "gi", Snacks.picker.lsp_implementations, desc = "Jump to implementation" },
                { "go", Snacks.picker.lsp_type_definitions, desc = "Jump to type definition" },
                { "gr", Snacks.picker.lsp_references, desc = "Jump to references" },

                { "gs", vim.lsp.buf.signature_help, desc = "Jump to signature help" },
                { "<leader>ss", Snacks.picker.lsp_symbols, desc = "LSP Symbols" },
                { "<leader>sS", Snacks.picker.lsp_workspace_symbols, desc = "LSP Workspace Symbols" },
                -- {
                --     mode = { "n", "i" },
                --     { "<M-CR>", "<cmd>CodeActionMenu<cr>", desc = "Code actions" },
                -- },
                { "rn", vim.lsp.buf.rename, desc = "Rename" },
            })

            -- local servers = require("plugins.lsp.servers")
            -- for server, opts in pairs(servers) do
            --     vim.lsp.config(server, opts)
            --     vim.lsp.enable(server)
            -- end
        end,
    },
}
