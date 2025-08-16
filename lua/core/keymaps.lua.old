vim.g.mapleader = " "

local wk = require("which-key")

local keymap = vim.keymap
local opts = { silent = true, noremap = true }

local isOnWindows = function()
    local uname = vim.uv.os_uname()
    local sysname = uname.sysname
    if sysname:find("Windows") then
        return true
    end
    if sysname:find("Linux") and uname.release:find("Microsoft") then
        return true
    end
    return false
end

-- ESC
keymap.set("i", "kk", "<ESC>", opts)

-- Move visual up and down
keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

-- Faster Navigation
keymap.set("n", "J", "5j", opts)
keymap.set("n", "K", "5k", opts)
keymap.set("v", "J", "5j", opts)
keymap.set("v", "K", "5k", opts)

-- Split
keymap.set("n", "<leader>sv", "<C-w>v", { silent = true, noremap = true, desc = "Split vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { silent = true, noremap = true, desc = "Split horizontally" })

keymap.set("n", "<leader>tv", "<C-w>v:term<cr>", { silent = true, noremap = true, desc = "Split terminal vertically" })
keymap.set(
    "n",
    "<leader>th",
    "<C-w>s:term<cr>",
    { silent = true, noremap = true, desc = "Split terminal horizontally" }
)

-- No Highlight
keymap.set("n", "<leader>nh", ":nohl<CR>", { silent = true, noremap = true, desc = "No Highlight" })

-- Clear DOS file format control chars
keymap.set("n", "<leader>nm", ":e ++ff=dos<CR> :set ff=unix<CR> :w<CR>", opts)

-- Nvim Tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, noremap = true, desc = "Toggle Nvim Tree" })

-- Remap CTRL+v
if isOnWindows() then
    keymap.set("", "<M-v>", "<C-v>", opts)
    keymap.set("!", "<M-v>", "<C-v>", opts)
end

--Bufferline
keymap.set("n", "<S-l>", ":bnext<CR>", opts)
keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

function _G.set_terminal_keymaps()
    local term_opts = { buffer = 0 }
    keymap.set("t", "<esc>", [[<C-\><C-n>]], term_opts)
    keymap.set("t", "<C-h>", "<C-\\><C-N>:lua require'tmux'.move_left()<CR>", term_opts)
    keymap.set("t", "<C-j>", "<C-\\><C-N>:lua require'tmux'.move_bottom()<CR>", term_opts)
    keymap.set("t", "<C-k>", "<C-\\><C-N>:lua require'tmux'.move_top()<CR>", term_opts)
    keymap.set("t", "<C-l>", "<C-\\><C-N>:lua require'tmux'.move_right()<CR>", term_opts)
    keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], term_opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Better terminal navigation
keymap.set("t", "<C-w>", "<C-\\><C-n><C-w><cr>", opts)

-- Wrapping
keymap.set("n", "<leader>wp", ":ToggleWrapMode<CR>", { silent = true, noremap = true, desc = "Toggle Wrap Mode" })

-- Destroy the buffer
keymap.set("n", "<leader>q", ":bd<CR>", { silent = true, noremap = true, desc = "Destroy the buffer" })

keymap.set("n", "<leader>Q", ":bd!<CR>", { silent = true, noremap = true, desc = "Force destroy the buffer" })

vim.api.nvim_set_keymap(
    "n",
    "<leader>y?",
    [[:lua YankDiagnosticError()<CR>]],
    { noremap = true, silent = true, desc = "Copy error" }
)

function YankDiagnosticError()
    vim.diagnostic.open_float()
    vim.diagnostic.open_float()
    local win_id = vim.fn.win_getid() -- get the window ID of the floating window
    vim.cmd("normal! j") -- move down one row
    vim.cmd("normal! VG") -- select everything from that row down
    vim.cmd("normal! y") -- yank selected text
    vim.api.nvim_win_close(win_id, true) -- close the floating window by its ID
end
