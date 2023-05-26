vim.g.mapleader = " "

local keymap = vim.keymap
local opts = {silent = true, noremap = true}

-- ESC
keymap.set("i", "kk", "<ESC>", opts)

-- Move visual up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Split
keymap.set("n", "<leader>sv", "<C-w>v", opts)
keymap.set("n", "<leader>sh", "<C-w>s", opts)

-- No Highlight
keymap.set("n", "<leader>nh", ":nohl<CR>", opts)

-- Clear DOS file format control chars
keymap.set("n", "<leader>nm", ":e ++ff=dos<CR> :set ff=unix<CR> :w<CR>", opts)

-- Nvim Tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Remap CTRL+v
keymap.set("", "<M-v>", "<C-v>", opts)
keymap.set("!", "<M-v>", "<C-v>", opts)

--Bufferline
keymap.set("n", "<S-l>", ":bnext<CR>", opts)
keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Better terminal navigation
keymap.set("t", "<C-h>", "<C-\\><C-N>:lua require'tmux'.move_left()<CR>", opts)
keymap.set("t", "<C-j>", "<C-\\><C-N>:lua require'tmux'.move_bottom()<CR>", opts)
keymap.set("t", "<C-k>", "<C-\\><C-N>:lua require'tmux'.move_top()<CR>", opts)
keymap.set("t", "<C-l>", "<C-\\><C-N>:lua require'tmux'.move_right()<CR>", opts)

-- Wrapping
keymap.set("n", "<leader>wp", ":ToggleWrapMode<CR>",opts)

-- Indent whole buffer
keymap.set("n", "<leader>=", "gg=G",opts)
