local opt = vim.opt
local g = vim.g
local api = vim.api
local fn = vim.fn
local autocmd = vim.api.nvim_create_autocmd

-- Line Number
opt.relativenumber = true
opt.number = true

-- Indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- Fold
opt.foldcolumn = "1" -- '0' is not bad
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- No Wrap
opt.wrap = false

-- Cursor Line
opt.cursorline = true

-- Enable Mouse
opt.mouse:append("a")

-- System Clipboard
opt.clipboard:append({ "unnamedplus" })

-- Keep 10 lines above and below the cursor
opt.scrolloff = 10

-- Copy highlight
autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            timeout = 300,
        })
    end,
})

-- Auto mkdir
autocmd("BufWritePre", {
    command = 'call mkdir(expand("<afile>:p:h"), "p")',
})

autocmd("TermOpen", {
    callback = function()
        vim.cmd("setlocal nonumber\nnormal a")
    end,
})

-- Split Direction
opt.splitright = true
opt.splitbelow = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"

-- Copilot
g.copilot_no_tab_map = true

-- diagnostic
vim.diagnostic.config({
    virtual_text = {
        severity = { min = vim.diagnostic.severity.WARN },
    },
})

opt.hidden = true
opt.updatetime = 300
opt.shortmess:append("c")

function _G.check_back_space()
    local col = fn.col(".") - 1
    return col == 0 or fn.getline("."):sub(col, col):match("%s")
end

opt.undofile = true

-- Leader
vim.g.mapleader = " "
