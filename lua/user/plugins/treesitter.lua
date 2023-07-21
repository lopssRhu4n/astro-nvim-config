vim.filetype.add({pattern = {[".*%.blade.php"] = "blade"}})
local parser_config = require"nvim-treesitter.parsers".get_parser_configs()
parser_config.blade = {
    install_info = {
        url = "~/Coding/Extra_Repos/tree-sitter-blade", -- local path or git repo
        files = {"src/parser.c"} -- note that some parsers also require src/scanner.c or src/scanner.cc
    }
    -- filetype = 'php'
}
-- parser_config.php = {
--     install_info = {
--         url = "https://github.com/tree-sitter/tree-sitter-php",
--         files = {"src/parser.c", "src/scanner.c"}
--     },
--     filetypes = {"php", "blade"}
-- }
--
-- print(parser_config.php.install_info.url)
--
-- print(parser_config.php.install_info.files[0])
return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "nvim-treesitter/nvim-treesitter-textobjects", "windwp/nvim-ts-autotag"
    },
    event = "User AstroFile",
    cmd = {
        "TSBufDisable", "TSBufEnable", "TSBufToggle", "TSDisable", "TSEnable",
        "TSToggle", "TSInstall", "TSInstallInfo", "TSInstallSync",
        "TSModuleInfo", "TSUninstall", "TSUpdate", "TSUpdateSync", "TSEditQuery"
    },
    build = ":TSUpdate",
    opts = function()
        return {
            autoinstall = true,
            autotag = {enable = true},
            context_commentstring = {enable = true, enable_autocmd = false},
            ensure_installed = {
                "markdown", "vue", "javascript", "typescript", "php", "lua",
                "html"
            },
            highlight = {
                enable = true,
                disable = function(_, bufnr)
                    return vim.api.nvim_buf_line_count(bufnr) > 10000
                end,
                additional_vim_regex_highlighting = true
            },
            incremental_selection = {enable = true},
            indent = {enable = true},
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["ak"] = {query = "@block.outer", desc = "around block"},
                        ["ik"] = {query = "@block.inner", desc = "inside block"},
                        ["ac"] = {query = "@class.outer", desc = "around class"},
                        ["ic"] = {query = "@class.inner", desc = "inside class"},
                        ["a?"] = {
                            query = "@conditional.outer",
                            desc = "around conditional"
                        },
                        ["i?"] = {
                            query = "@conditional.inner",
                            desc = "inside conditional"
                        },
                        ["af"] = {
                            query = "@function.outer",
                            desc = "around function "
                        },
                        ["if"] = {
                            query = "@function.inner",
                            desc = "inside function "
                        },
                        ["al"] = {query = "@loop.outer", desc = "around loop"},
                        ["il"] = {query = "@loop.inner", desc = "inside loop"},
                        ["aa"] = {
                            query = "@parameter.outer",
                            desc = "around argument"
                        },
                        ["ia"] = {
                            query = "@parameter.inner",
                            desc = "inside argument"
                        }
                    }
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]k"] = {
                            query = "@block.outer",
                            desc = "Next block start"
                        },
                        ["]f"] = {
                            query = "@function.outer",
                            desc = "Next function start"
                        },
                        ["]a"] = {
                            query = "@parameter.inner",
                            desc = "Next argument start"
                        }
                    },
                    goto_next_end = {
                        ["]K"] = {
                            query = "@block.outer",
                            desc = "Next block end"
                        },
                        ["]F"] = {
                            query = "@function.outer",
                            desc = "Next function end"
                        },
                        ["]A"] = {
                            query = "@parameter.inner",
                            desc = "Next argument end"
                        }
                    },
                    goto_previous_start = {
                        ["[k"] = {
                            query = "@block.outer",
                            desc = "Previous block start"
                        },
                        ["[f"] = {
                            query = "@function.outer",
                            desc = "Previous function start"
                        },
                        ["[a"] = {
                            query = "@parameter.inner",
                            desc = "Previous argument start"
                        }
                    },
                    goto_previous_end = {
                        ["[K"] = {
                            query = "@block.outer",
                            desc = "Previous block end"
                        },
                        ["[F"] = {
                            query = "@function.outer",
                            desc = "Previous function end"
                        },
                        ["[A"] = {
                            query = "@parameter.inner",
                            desc = "Previous argument end"
                        }
                    }
                },
                swap = {
                    enable = true,
                    swap_next = {
                        [">K"] = {
                            query = "@block.outer",
                            desc = "Swap next block"
                        },
                        [">F"] = {
                            query = "@function.outer",
                            desc = "Swap next function"
                        },
                        [">A"] = {
                            query = "@parameter.inner",
                            desc = "Swap next argument"
                        }
                    },
                    swap_previous = {
                        ["<K"] = {
                            query = "@block.outer",
                            desc = "Swap previous block"
                        },
                        ["<F"] = {
                            query = "@function.outer",
                            desc = "Swap previous function"
                        },
                        ["<A"] = {
                            query = "@parameter.inner",
                            desc = "Swap previous argument"
                        }
                    }
                }
            }
        }
    end,
    config = require "plugins.configs.nvim-treesitter"
}