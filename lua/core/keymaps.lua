vim.g.mapleader = " "

local keymap = vim.keymap
local opts = { silent = true, noremap = true }

local isOnWindows = function()
    local uname = vim.loop.os_uname()
    local sysname = uname.sysname
    print(sysname)
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
keymap.set("n", "<leader>sv", "<C-w>v", opts)
keymap.set("n", "<leader>sh", "<C-w>s", opts)

keymap.set("n", "<leader>tv", "<C-w>v:term<cr>", opts)
keymap.set("n", "<leader>th", "<C-w>s:term<cr>", opts)

-- No Highlight
keymap.set("n", "<leader>nh", ":nohl<CR>", opts)

-- Clear DOS file format control chars
keymap.set("n", "<leader>nm", ":e ++ff=dos<CR> :set ff=unix<CR> :w<CR>", opts)

-- Nvim Tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

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

-- Better terminal navigation
keymap.set("t", "<C-h>", "<C-\\><C-N>:lua require'tmux'.move_left()<CR>", opts)
keymap.set("t", "<C-j>", "<C-\\><C-N>:lua require'tmux'.move_bottom()<CR>", opts)
keymap.set("t", "<C-k>", "<C-\\><C-N>:lua require'tmux'.move_top()<CR>", opts)
keymap.set("t", "<C-l>", "<C-\\><C-N>:lua require'tmux'.move_right()<CR>", opts)
keymap.set("t", "<C-q>", "<C-\\><C-n>:bd!<cr>", opts)

-- Wrapping
keymap.set("n", "<leader>wp", ":ToggleWrapMode<CR>", opts)

-- Format the buffer
keymap.set("n", "<leader>=", ":call CocAction('format')<CR>", opts)

-- Destroy the buffer
keymap.set("n", "<leader>q", ":bd<CR>", opts)

-- Coc
keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
    { silent = true, noremap = true, expr = true })
keymap.set("i", "<S-TAB>", 'coc#pum#visible() ? coc#pum#prev(1) : "<C-h>"', { noremap = true, expr = true })
keymap.set("i", "<CR>",
    'coc#pum#visible() ? coc#pum#confirm() : "<C-g>u<C-r>=v:lua.require\'nvim-autopairs\'.autopairs_cr()<CR><C-r>=coc#on_enter()<CR>"',
    { silent = true, noremap = true, expr = true })
keymap.set("i", "<M-Enter>", "coc#refresh()", { silent = true, noremap = true, expr = true })
keymap.set("n", "[g", "<Plug>(coc-diagnostic-prev)", opts)
keymap.set("n", "]g", "<Plug>(coc-diagnostic-next)", opts)
keymap.set("n", "gb", "<Plug>(coc-cursors-word)", opts)
keymap.set("n", "gd", "<Plug>(coc-definition)", opts)
keymap.set("n", "gy", "<Plug>(coc-type-definition)", opts)
keymap.set("n", "gi", "<Plug>(coc-implementation)", opts)
keymap.set("n", "gr", "<Plug>(coc-references)", opts)
