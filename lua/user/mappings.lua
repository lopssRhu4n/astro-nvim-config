return {
    n = {
        ["<C-d>"] = {"<C-d>zz"},
        ["<C-u>"] = {"<C-u>zz"},
        ["<leader>tfe"] = {
            ':lua require("neotest").run.run(vim.fn.expand("%")) <CR>',
            desc = 'Neotest File Entirely'
        },
        ["<leader>ts"] = {
            ':lua require("neotest").summary.toggle() <CR>',
            desc = 'Neotest summary toggle'
        },
        ["<leader>tr"] = {
            ':lua require("neotest").run.run() <CR>',
            desc = 'Neotest run test under cursor'
        },
        ["<leader>to"] = {
            ':lua require("neotest").output.open({ enter = true}) <CR>',
            desc = 'Neotest open test output'
        },
        ["<leader>top"] = {
            ':lua require("neotest").output_panel.toggle() <CR>',
            desc = 'Neotest open test output_panel'
        }
    },
    v = {["J"] = {":m '>+1<CR>gv=gv"}, ["K"] = {":m '>-2<CR>gv=gv"}}

    -- neotest = {
    --   n = {
    --   }
    -- }

}

-- keys = {
--     { "<leader>ts",  function() require('neotest').summary.toggle() end },
--     { "<leader>to",  function() require('neotest').output.open({ enter = true }) end },
--     { "<leader>tr",  function() require('neotest').run.run() end },
--     { "<leader>trs", function() require('neotest').run.run({ suite = true }) end },
--     { "<leader>top", function() require('neotest').output_panel.toggle() end },
--     { "<leader>tef",  function() require("neotest").run.run(vim.fn.expand("%")) end },
--     { "[n",          function() require("neotest").jump.prev({ status = "failed" }) end },
--     { "]n",          function() require("neotest").jump.next({ status = "failed" }) end },
--
--   },
