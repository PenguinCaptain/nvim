return {
    "lewis6991/hover.nvim",
    opts = {
        title = true,
        preview_opts = {
            border = "rounded",
        },
    },
    keys = {
        {
            "<leader>k",
            mode = { "n" },
            function()
                require("hover").open()
            end,
            desc = "Open Hover",
        },
        {
            "k",
            mode = { "n" },
            function()
                local buf = vim.api.nvim_get_current_buf()
                local win = vim.b[buf].hover_preview
                if win and vim.api.nvim_win_is_valid(win) then
                    vim.schedule(function()
                        require("hover").enter()
                    end)
                    return ""
                else
                    return "k"
                end
            end,
            expr = true,
        },
        {
            "<Tab>",
            mode = { "n" },
            function()
                require("hover").switch("next")
            end,
            desc = "Next Hover",
        },
    },
    config = function(_, opts)
        require("hover").config(opts)
    end,
}
