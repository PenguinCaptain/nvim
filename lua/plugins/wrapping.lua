return {
    "andrewferrier/wrapping.nvim",
    opts = {
        create_keymappings = false,
    },
    config = function(_,opts)
        require("wrapping").setup(opts)
    end,
}
