return {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
        local rainbow_delimiters = require("rainbow-delimiters")
        require("rainbow-delimiters.setup").setup({
            strategy = {
                [""] = rainbow_delimiters.strategy["global"],
                vim = rainbow_delimiters.strategy["local"],
                html = rainbow_delimiters.strategy["local"],
                -- Pick the strategy for LaTeX dynamically based on the buffer size
                latex = function()
                    -- Disabled for very large files, global strategy for large files,
                    -- local strategy otherwise
                    if vim.fn.line("$") > 10000 then
                        return nil
                    elseif vim.fn.line("$") > 1000 then
                        return rainbow_delimiters.strategy["global"]
                    end
                    return rainbow_delimiters.strategy["local"]
                end,
            },
            query = {
                [""] = "rainbow-delimiters",
                lua = "rainbow-blocks",
                tsx = "rainbow-parens",
            },
            highlight = {
                "RainbowDelimiterRed",
                "RainbowDelimiterYellow",
                "RainbowDelimiterBlue",
                "RainbowDelimiterOrange",
                "RainbowDelimiterGreen",
                "RainbowDelimiterViolet",
                "RainbowDelimiterCyan",
            },
        })
    end,
}
