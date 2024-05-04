return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = {
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            },
        },
    },
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        telescope.load_extension("dap")
        telescope.load_extension("fzf")

        local builtin = require("telescope.builtin")
        local wk = require("which-key")
        wk.register({
            ["<leader>f"] = {
                name = "find",
                f = { builtin.find_files, "Find files" },
                g = { builtin.live_grep, "Live grep" },
            },
            ["<leader>h"] = { builtin.help_tags, "Help" },
            ["<leader><tab>"] = { builtin.buffers, "Buffers" },
        })
    end,
}
