return {
    {
        "mbbill/undotree",
        keys = { "<leader>u" },
        config = function()
            local wk = require("which-key")
            wk.register({
                u = { "<cmd>UndotreeToggle<cr>", "Toggle undotree" },
            }, { prefix = "<leader>", mode = "n" })
            vim.cmd([[
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
	nmap <buffer> k <plug>UndotreeNextState
	nmap <buffer> j <plug>UndotreePreviousState
	nmap <buffer> K 5<plug>UndotreeNextState
	nmap <buffer> J 5<plug>UndotreePreviousState
endfunc]])
        end,
    },
}
