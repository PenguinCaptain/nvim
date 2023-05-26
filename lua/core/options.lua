local opt = vim.opt

-- Line Number
opt.relativenumber = true
opt.number = true

-- Indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- No Wrap
opt.wrap = false

-- Cursor Line
opt.cursorline = true

-- Enable Mouse
opt.mouse:append("a")

-- System Clipboard
opt.clipboard:append("unnamedplus")

-- Copy highlight
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
		})
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
