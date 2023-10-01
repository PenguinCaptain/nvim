return {
    "mfussenegger/nvim-dap",
    dependencies = {
        {
            "ravenxrz/DAPInstall.nvim",
            config = function()
                local dap_install = require("dap-install")
                dap_install.setup({
                    installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
                })
            end,
        },
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
        "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup()
        require("nvim-dap-virtual-text").setup()
        local m = { noremap = true }
        local keymap = vim.keymap
        local api = vim.api
        local fn = vim.fn

        keymap.set("n", "<leader>'t", dap.toggle_breakpoint, m)
        keymap.set("n", "<leader>'r", dap.continue, m)
        keymap.set("n", "<leader>'q", dap.terminate, m)
        keymap.set("n", "<leader>'e", dapui.toggle, m)

        api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
        api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
        api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

        fn.sign_define('DapBreakpoint',
            { text = '󰝥', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
        fn.sign_define('DapBreakpointCondition',
            { text = '󰟃', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
        fn.sign_define('DapBreakpointRejected',
            { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
        fn.sign_define('DapLogPoint', {
            text = '',
            texthl = 'DapLogPoint',
            linehl = 'DapLogPoint',
            numhl = 'DapLogPoint'
        })
        fn.sign_define('DapStopped',
            { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
    end
}
