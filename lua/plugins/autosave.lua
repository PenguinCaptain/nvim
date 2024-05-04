return {
    "0x00-ketsu/autosave.nvim",
    event = { "InsertLeave", "TextChanged" },
    config = function()
        require("autosave").setup({
            debounce_delay = 1500,
        })

        vim.keymap.set(
            "n",
            "<leader>&",
            "<cmd>ASToggle<cr>",
            { noremap = true, silent = true, desc = "Toggle autosave" }
        )
    end,
}
