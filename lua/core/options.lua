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
opt.clipboard:append{"unnamed","unnamedplus"}

-- Copy highlight
autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            timeout = 300,
        })
    end,
})

-- Auto mkdir
autocmd('BufWritePre', {
    command = 'call mkdir(expand("<afile>:p:h"), "p")',
})

autocmd('TermOpen', {
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

-- Coc
g.coc_global_extensions = {
    'coc-marketplace',
    'coc-json',
    'coc-vimlsp',
    'coc-lua',
    'coc-eslint',
    'coc-pyright',
    'coc-java',
    'coc-prettier',
    'coc-tsserver'
}

opt.hidden = true
opt.updatetime = 300
opt.shortmess:append('c')

function _G.check_back_space()
    local col = fn.col('.') - 1
    return col == 0 or fn.getline('.'):sub(col, col):match('%s')
end

function _G.show_docs()
    if api.nvim_eval("CocAction('hasProvider', 'hover')") then
        fn.CocActionAsync("definitionHover")
        return true
    else
        return false
    end
end

autocmd('CursorHold', {
    command = "silent call CocActionAsync('highlight')"
})
