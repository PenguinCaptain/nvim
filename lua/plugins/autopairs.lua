return {
    'windwp/nvim-autopairs',
    enabled = require("plugins.treesitter").enabled,
    opts = {
        map_cr = false,
        check_ts = true,
        fast_wrap = {
            map = '<M-e>',
            chars = { '{', '[', '(', '"', "'" },
            pattern = [=[[%'%"%)%>%]%)%}%,]]=],
            end_key = '$',
            keys = 'qwertyuiopzxcvbnmasdfghjkl',
            check_comma = true,
            highlight = 'Search',
            highlight_grey='Comment'
        },
    },
    config = function(_, opts)
        local npairs = require('nvim-autopairs')
        npairs.setup(opts)
    end,
}
