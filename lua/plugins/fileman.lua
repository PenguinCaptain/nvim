-- return {
--     "mikavilpas/yazi.nvim",
--     event = "verylazy",
--     dependencies = {
--         { "nvim-lua/plenary.nvim", lazy = true },
--     },
--     keys = {
--         -- 👇 in this section, choose your own keymappings!
--         {
--             "<leader>.",
--             mode = { "n", "v" },
--             "<cmd>yazi<cr>",
--             desc = "open yazi at the current file",
--         },
--         {
--             -- open in the current working directory
--             "<leader>e",
--             "<cmd>yazi cwd<cr>",
--             desc = "open the file manager in nvim's working directory",
--         },
--         {
--             "<c-up>",
--             "<cmd>yazi toggle<cr>",
--             desc = "resume the last yazi session",
--         },
--     },
--     opts = {
--         -- if you want to open yazi instead of netrw, see below for more info
--         open_for_directories = true,
--         keymaps = {
--             show_help = "<f1>",
--         },
--         integrations = {
--             grep_in_directory = "snacks.picker",
--             grep_in_selected_files = "snacks.picker",
--         },
--     },
--     -- 👇 if you use `open_for_directories=true`, this is recommended
--     init = function()
--         -- mark netrw as loaded so it's not loaded at all.
--         --
--         -- more details: https://github.com/mikavilpas/yazi.nvim/issues/802
--         vim.g.loaded_netrwplugin = 1
--     end,
-- }
return {
    "stevearc/oil.nvim",
    dependencies = {
        { "nvim-mini/mini.icons", version = "*" },
    },
    keys = {
        {
            "<leader>e",
            function()
                require("oil").toggle_float()
            end,
            mode = { "n", "v" },
            desc = "open oil at the current file",
        },
        -- {
        --     "<leader>e",
        --     function()
        --         require("oil").open(vim.fn.getcwd())
        --     end,
        --     desc = "open oil in nvim's working directory",
        -- },
    },
    opts = {
        default_file_explorer = true,
        keymaps = {
            ["gd"] = {
                desc = "Toggle file detail view",
                callback = function()
                    detail = not detail
                    if detail then
                        require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                    else
                        require("oil").set_columns({ "icon" })
                    end
                end,
            },
            ["q"] = "actions.close",
        },
        view_options = {
            show_hidden = true,
        },
        win_options = {
            winbar = "%!v:lua.get_oil_winbar()",
        },
    },
    lazy = false,
    init = function()
        _G.get_oil_winbar = function()
            local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
            local dir = require("oil").get_current_dir(bufnr)
            if dir then
                return vim.fn.fnamemodify(dir, ":~")
            else
                -- If there is no current directory (e.g. over ssh), just show the buffer name
                return vim.api.nvim_buf_get_name(0)
            end
        end
    end,
}
