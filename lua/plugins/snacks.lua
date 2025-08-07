return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            sections = {
                { section = "header" },
                { section = "keys", gap = 1, padding = 1 },
                { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                {
                    pane = 2,
                    icon = " ",
                    title = "Git Status",
                    section = "terminal",
                    enabled = function()
                        return Snacks.git.get_root() ~= nil
                    end,
                    cmd = "git status --short --branch --renames",
                    height = 7,
                    padding = 1,
                    ttl = 5 * 60,
                    indent = 3,
                },
                { section = "startup" },
            },
        },
        explorer = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        picker = { enabled = true },
        notifier = { enabled = false },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
    },
    keys = {
        -- Top Pickers & Explorer
        {
            "<leader><space>",
            function()
                Snacks.picker.smart()
            end,
            desc = "Smart Find Files",
        },
        {
            "<leader><tab>",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>:",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Command History",
        },
        {
            "<leader>n",
            function()
                Snacks.picker.notifications()
            end,
            desc = "Notification History",
        },
        -- { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
        {
            "<leader>ff",
            function()
                Snacks.picker.files()
            end,
            desc = "Find Files",
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep",
        },
        {
            "<leader>h",
            function()
                Snacks.picker.help()
            end,
            desc = "Help Pages",
        },
        {
            "<leader>q",
            function()
                Snacks.bufdelete()
            end,
            desc = "Close current buffer",
        },
        {
            "<leader>Q",
            function()
                Snacks.bufdelete({ force = true })
            end,
            desc = "Force close current buffer",
        },
        {
            "<leader>cc",
            function()
                Snacks.bufdelete.other()
            end,
            desc = "Close other buffer",
        },
        {
            "<leader>cC",
            function()
                Snacks.bufdelete.others({ force = true })
            end,
            desc = "Force close current buffer",
        },
    },
}
