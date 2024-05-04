return {
    "github/copilot.vim",
    config = function()
        vim.cmd([[
        imap <silent><script><expr> \\ copilot#Accept("\<CR>")
        ]])
    end,
}
