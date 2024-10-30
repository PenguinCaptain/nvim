return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
        options = {
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "left",
                    padding = 1,
                },
            },
        },
    },
    config = function(_, opts)
        require("bufferline").setup(opts)
    end,
}
