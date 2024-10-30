local wk = require("which-key")

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

-- Add mappings using which-key's wk.add()
wk.add({
    -- ESC
    { "kk", "<ESC>", mode = "i", desc = "Escape insert mode" },

    -- Move visual up and down
    { "<C-j>", ":m '>+1<CR>gv=gv", mode = "v", desc = "Move selection down" },
    { "<C-k>", ":m '<-2<CR>gv=gv", mode = "v", desc = "Move selection up" },

    -- Faster Navigation
    { "J", "5j", mode = { "n", "v" }, desc = "Jump down 5 lines" },
    { "K", "5k", mode = { "n", "v" }, desc = "Jump up 5 lines" },

    -- Split
    { "<leader>s", group = "Split" },
    { "<leader>sv", "<C-w>v", desc = "Split vertically" },
    { "<leader>sh", "<C-w>s", desc = "Split horizontally" },
    { "<leader>sq", "<C-w>q", desc = "Close split" },

    -- Split terminal
    { "<leader>t", group = "Create split terminal" },
    { "<leader>tv", "<C-w>v:term<cr>", desc = "Vertical terminal split" },
    { "<leader>th", "<C-w>s:term<cr>", desc = "Horizontal terminal split" },

    -- No Highlight
    { "<leader>nh", ":nohl<CR>", desc = "Clear search highlight" },

    -- Clear DOS file format control chars
    { "<leader>nm", ":e ++ff=dos<CR> :set ff=unix<CR> :w<CR>", desc = "Convert DOS to Unix file format" },

    -- Nvim Tree
    { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle Nvim Tree" },

    -- Bufferline
    { "<S-l>", ":bnext<CR>", desc = "Next buffer" },
    { "<S-h>", ":bprevious<CR>", desc = "Previous buffer" },

    -- Stay in indent mode
    { "<", "<gv", mode = "v", desc = "Indent line left" },
    { ">", ">gv", mode = "v", desc = "Indent line right" },

    -- Better terminal navigation
    -- { "<C-w>", "<C-\\><C-n><C-w><cr>", mode = "t", desc = "Terminal Window" },

    -- Toggle wrap mode
    { "<leader>wp", ":ToggleWrapMode<CR>", desc = "Toggle Wrap Mode" },

    -- Destroy buffer
    -- { "<leader>q", ":b#<bar>bd<CR>", desc = "Close buffer" },
    -- { "<leader>Q", ":b#<bar>bd!<CR>", desc = "Force close buffer" },

    -- Yank diagnostic error
    { "<leader>y?", ":lua YankDiagnosticError()<CR>", desc = "Copy diagnostic error" },
})

-- Remap CTRL+v for Windows
if isOnWindows() then
    wk.add({
        { "<M-v>", "<C-v>", mode = "", desc = "Remap CTRL+v on Windows" },
        { "<M-v>", "<C-v>", mode = "!", desc = "Remap CTRL+v on Windows" },
    })
end

function YankDiagnosticError()
    vim.diagnostic.open_float()
    vim.diagnostic.open_float()
    local win_id = vim.fn.win_getid() -- get the window ID of the floating window
    vim.cmd("normal! j") -- move down one row
    vim.cmd("normal! VG") -- select everything from that row down
    vim.cmd("normal! y") -- yank selected text
    vim.api.nvim_win_close(win_id, true) -- close the floating window by its ID
end

function _G.set_terminal_keymaps()
    local term_opts = { buffer = 0 }
    wk.add({
        { "<esc>", [[<C-\><C-n>]], mode = "t", desc = "Escape terminal mode" },
        { "<C-h>", "<C-\\><C-N>:lua require'tmux'.move_left()<CR>", mode = "t", desc = "Move left in terminal" },
        { "<C-j>", "<C-\\><C-N>:lua require'tmux'.move_bottom()<CR>", mode = "t", desc = "Move down in terminal" },
        { "<C-k>", "<C-\\><C-N>:lua require'tmux'.move_top()<CR>", mode = "t", desc = "Move up in terminal" },
        { "<C-l>", "<C-\\><C-N>:lua require'tmux'.move_right()<CR>", mode = "t", desc = "Move right in terminal" },
        { "<C-w>", [[<C-\><C-n><C-w>]], mode = "t", desc = "Terminal window" },
    })
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
