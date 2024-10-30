return {
    "folke/which-key.nvim",
    dependencies = {
        { "echasnovski/mini.icons", version = "*" },
        "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    opts = {
        delay = 500,
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
