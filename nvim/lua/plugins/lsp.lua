return {
    {
        "williamboman/mason.nvim",
        config = function()
            require('mason').setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            local on_attach = function(_, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("n", "<leader>m", function() vim.lsp.buf.format() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

                vim.diagnostic.config({
                    virtual_text = {
                        -- prefix = '●', -- Could be '●', '▎', 'x'
                        spacing = 4,
                    },
                    signs = true,
                    underline = true,
                    update_in_insert = true, -- Show diagnostics in insert mode
                    severity_sort = true,
                })
            end

            require('mason-lspconfig').setup {
                ensure_installed = { "lua_ls", "tsserver" }
            }

            require('mason-lspconfig').setup_handlers {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        on_attach = on_attach
                    }
                end,
                ["clangd"] = function()
                    require("lspconfig").clangd.setup {
                        cmd = { "clangd", "--header-insertion=never" },
                        filetypes = { "cpp" },
                        root_dir = require("lspconfig").util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
                    }
                end,
                ["cssls"] = function()
                    require("lspconfig").cssls.setup {
                        capabilities = capabilities,
                    }
                end,
                ["html"] = function()
                    require("lspconfig").html.setup {
                        capabilities = capabilities,
                    }
                end,
                -- ["pyright"] = function()
                --     require("lspconfig").pyright.setup {
                --         on_attach = on_attach,
                --         settings = {
                --             python = {
                --                 formatting = {
                --                     provider = "black"
                --                 }
                --             }
                --         }
                --     }
                -- end,
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup {
                        on_attach = on_attach,
                        settings = {
                            Lua = {
                                runtime = {
                                    version = "LuaJIT",
                                },
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        vim.env.VIMRUNTIME
                                    },
                                },
                            },
                        },
                    }
                end,
                ["eslint"] = function()
                    require("lspconfig").eslint.setup {
                        on_attach = on_attach,
                        settings = {
                            codeAction = {
                                disableRuleComment = {
                                    enable = true,
                                    location = "separateLine"
                                },
                                showDocumentation = {
                                    enable = true
                                }
                            },
                            codeActionOnSave = {
                                enable = false,
                                mode = "all"
                            },
                            experimental = {
                                useFlatConfig = false
                            },
                            format = true,
                            nodePath = "",
                            onIgnoredFiles = "off",
                            problems = {
                                shortenToSingleLine = false
                            },
                            quiet = false,
                            rulesCustomizations = {},
                            run = "onType",
                            useESLintClass = false,
                            validate = "on",
                            workingDirectory = {
                                mode = "location"
                            }
                        }
                    }
                end
            }
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {},
        config = function()
            require("conform").setup {
                formatters_by_ft = {
                    python = { "black" }
                },
                format_on_save = {
                    lsp_format = "fallback"
                },
                format = {
                    lsp_format = "prefer"
                }
            }
        end
    }
}
