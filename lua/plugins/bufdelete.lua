return {
    "famiu/bufdelete.nvim",
    keys = {
        { "<leader>q", ":Bdelete<CR>", desc = "Close current buffer", silent = true },
        { "<leader>Q", ":Bdelete!<CR>", desc = "Force close current buffer", silent = true },
    },
    config = function()
        -- Automatically close empty buffers
        vim.api.nvim_create_autocmd({ "BufLeave" }, {
            pattern = "{}",
            callback = function()
                if vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
                    vim.bo.buftype = "nofile"
                    vim.bo.bufhidden = "wipe"
                end
            end,
        })
    end,
}
