return {
    "nvim-neotest/neotest",
    ft = {"go", "rust", "python"},
    dependencies = {
        "nvim-neotest/neotest-go", "nvim-lua/plenary.nvim",
        "olimorris/neotest-phpunit", "marilari88/neotest-vitest",
        "haydenmeade/neotest-jest"
    },

    opts = function()
        return {
            -- your neotest config here
            adapters = {
                require "neotest-go", require "neotest-phpunit",
                require "neotest-vitest", require('neotest-jest')({
                    jestCommand = "npm run test:unit",
                    -- jestConfigFile = "custom.jest.config.ts",
                    env = {CI = true},
                    cwd = function(path)
                        return vim.fn.getcwd()
                    end
                })
            }
        }
    end,
    config = function(_, opts)
        -- get neotest namespace (api call creates or returns namespace)
        local neotest_ns = vim.api.nvim_create_namespace "neotest"
        vim.diagnostic.config({
            virtual_text = {
                format = function(diagnostic)
                    local message = diagnostic.message:gsub("\n", " "):gsub(
                                        "\t", " "):gsub("%s+", " ")
                                        :gsub("^%s+", "")
                    return message
                end
            }
        }, neotest_ns)
        require("neotest").setup(opts)
    end
}

-- return
--
-- {
--   "nvim-neotest/neotest",
--   lazy = true,
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "olimorris/neotest-phpunit",
--     "marilari88/neotest-vitest",
--     -- "theutz/neotest-pest",
--   },

-- config = function()
--     require("neotest").setup({
--       adapters = {
--         require("neotest-phpunit"),
--         require("neotest-vitest"),
--         -- require("neotest-pest")
--       },
--     })
--
--     require("neotest-phpunit")({
--       filter_dirs = { "vendor" }
--     })
--   end
-- }
