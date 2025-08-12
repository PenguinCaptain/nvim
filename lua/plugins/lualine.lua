return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        sections = {
            lualine_b = {
                {
                    "diff",
                    source = function()
                        local gitsigns = vim.b.gitsigns_status_dict
                        if gitsigns then
                            return {
                                added = gitsigns.added,
                                modified = gitsigns.changed,
                                removed = gitsigns.removed,
                            }
                        end
                    end,
                },
            },
        },
        options = {
            theme = "tokyonight",
        },
    },
    config = function(_, opts)
        require("lualine").setup(opts)
    end,
}
