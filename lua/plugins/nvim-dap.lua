return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            -- {
            --     "ravenxrz/DAPInstall.nvim",
            --     config = function()
            --         local dap_install = require("dap-install")
            --         dap_install.setup({
            --             installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
            --         })
            --     end,
            -- },
            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "nvim-telescope/telescope-dap.nvim",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            require("nvim-dap-virtual-text").setup()
            local wk = require("which-key")
            local api = vim.api
            local fn = vim.fn

            -- wk.register({
            --     ["<leader>'"] = {
            --         name = "Debug",
            --         b = { dap.toggle_breakpoint, "Toggle Breakpoint" },
            --         c = { dap.continue, "Continue" },
            --         i = { dap.step_into, "Step Into" },
            --         f = { dap.step_over, "Step Over" },
            --         o = { dap.step_out, "Step Out" },
            --         q = { dap.terminate, "Terminate" },
            --         e = { dapui.toggle, "Toggle UI" },
            --         r = { ":Telescope dap configurations<CR>", "Run with configurations" },
            --         R = { dap.run_last, "Re-run" },
            --     },
            -- })

            wk.add({
                { "<leader>'", group = "Debug" },
                { "<leader>'R", dap.run_last, desc = "Re-run" },
                { "<leader>'b", dap.toggle_breakpoint, desc = "Toggle Breakpoint" },
                { "<leader>'c", dap.continue, desc = "Continue" },
                { "<leader>'e", dapui.toggle, desc = "Toggle UI" },
                { "<leader>'f", dap.step_over, desc = "Step Over" },
                { "<leader>'i", dap.step_into, desc = "Step Into" },
                { "<leader>'o", dap.step_out, desc = "Step Out" },
                { "<leader>'q", dap.terminate, desc = "Terminate" },
                { "<leader>'r", ":Telescope dap configurations<CR>", desc = "Run with configurations" },
            })

            api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
            api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
            api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

            fn.sign_define(
                "DapBreakpoint",
                { text = "󰝥", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
            )
            fn.sign_define(
                "DapBreakpointCondition",
                { text = "󰟃", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
            )
            fn.sign_define(
                "DapBreakpointRejected",
                { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
            )
            fn.sign_define("DapLogPoint", {
                text = "",
                texthl = "DapLogPoint",
                linehl = "DapLogPoint",
                numhl = "DapLogPoint",
            })
            fn.sign_define(
                "DapStopped",
                { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
            )
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        config = function()
            require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
        end,
    },
}
