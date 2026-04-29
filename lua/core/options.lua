local opt = vim.opt
local g = vim.g
local api = vim.api
local fn = vim.fn
local autocmd = vim.api.nvim_create_autocmd

local uname = vim.uv.os_uname()
local sysname = uname.sysname

_G.is_wsl = sysname == "Linux" and uname.release:find("microsoft") ~= nil
_G.is_mac = sysname == "Darwin"
_G.is_windows = sysname:find("Windows") ~= nil or is_wsl

if is_wsl then
    g.clipboard = "win32yank"
    -- g.clipboard = {
    --     name = "WslClipboard",
    --     copy = {
    --         ["+"] = "clip.exe",
    --         ["*"] = "clip.exe",
    --     },
    --     paste = {
    --         ["+"] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    --         ["*"] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    --     },
    --     cache_enabled = 0,
    -- }
end

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

opt.laststatus = 3

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
        vim.cmd("setlocal nonumber")
        -- fix snack dashboard
        if vim.api.nvim_buf_get_name(0) ~= "" then
            vim.cmd("startinsert")
        end
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
-- g.copilot_no_tab_map = true

-- Diagnostic
vim.diagnostic.config({
    virtual_text = {
        severity = { min = vim.diagnostic.severity.WARN },
    },
})

-- Auto Reload
vim.o.autoread = true

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    command = "checktime",
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
    pattern = "*",
    callback = function()
        vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
    end,
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
