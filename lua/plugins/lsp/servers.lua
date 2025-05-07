return {
    lua_ls = {
        settings = {
            Lua = {
                hint = {
                    enable = true,
                },
            },
        },
    },
    ts_ls = {
        init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = "/Users/penguincapt/.nvm/versions/node/v20.9.0/lib/node_modules/@vue/language-server",
                    languages = { "vue" },
                },
            },
            preferences = {
                typescript = {
                    inlayHints = {
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                },
                javascript = {
                    inlayHints = {
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                },
            },
        },
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "typescript.tsx", "vue" },
    },
    volar = {},
    pylsp = {
        {
            settings = {
                pylsp = {
                    plugins = {
                        rope_autoimport = {
                            enabled = false,
                        },
                        ruff = {
                            enabled = true,
                            executable = "ruff",
                        },
                        pylint = {
                            enabled = true,
                            executable = "pylint",
                            args = { "--rcfile=~/.pylintrc" },
                        },
                        mccabe = {
                            enabled = false,
                        },
                        flake8 = {
                            enabled = true,
                        },
                        autopep8 = {
                            enabled = false,
                        },
                        black = {
                            enabled = false,
                        },
                        yapf = {
                            enabled = false,
                        },
                        pycodestyle = {
                            enabled = false,
                        },
                        pydocstyle = {
                            enabled = false,
                        },
                        pyflakes = {
                            enabled = false,
                        },
                    },
                },
            },
        },
    },
    clangd = {
        cmd = { "clangd", "--offset-encoding=utf-16" },
    },
    html = {},
    -- lspc.tsserver.setup({
    --     settings = {
    --         typescript = {
    --             inlayhints = {
    --                 includeinlayparameternamehints = "all",
    --                 includeinlayparameternamehintswhenargumentmatchesname = false,
    --                 includeinlayfunctionparametertypehints = true,
    --                 includeinlayvariabletypehints = true,
    --                 includeinlayvariabletypehintswhentypematchesname = false,
    --                 includeinlaypropertydeclarationtypehints = true,
    --                 includeinlayfunctionlikereturntypehints = true,
    --                 includeinlayenummembervaluehints = true,
    --             },
    --         },
    --         javascript = {
    --             inlayhints = {
    --                 includeinlayparameternamehints = "all",
    --                 includeinlayparameternamehintswhenargumentmatchesname = false,
    --                 includeinlayfunctionparametertypehints = true,
    --                 includeinlayvariabletypehints = true,
    --                 includeinlayvariabletypehintswhentypematchesname = false,
    --                 includeinlaypropertydeclarationtypehints = true,
    --                 includeinlayfunctionlikereturntypehints = true,
    --                 includeinlayenummembervaluehints = true,
    --             },
    --         },
    --     },
    -- })
}
