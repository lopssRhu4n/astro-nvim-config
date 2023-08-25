-- local output_bufnr, command = 34, {"go", "run", "main.go"}
local attach_to_buffer = function(output_bufnr, pattern, command)
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("run_on_save", {clear = true}),
        pattern = pattern,
        callback = function()
            local append_data = function(_, data)
                if data then
                    vim.api
                        .nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
                end
            end

            vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false,
                                       {"main.go output"})
            vim.fn.jobstart(command, {
                stdout_buffered = true,
                on_stdout = append_data,
                on_stderr = append_data

            })
        end
    })

end

vim.api.nvim_create_user_command("AutoRunCurrentBuf", function()
    vim.cmd("vs")
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_open_win(bufnr, true, {})
end, {})

vim.api.nvim_create_user_command("AutoRun", function()
    local bufnr = vim.fn.input("Bufnr: ")
    local pattern = vim.fn.input("Pattern: ")
    local command = vim.split(vim.fn.input("Command: "), " ")

    attach_to_buffer(tonumber(bufnr), pattern, command)
end, {})

-- vim.api.nvim_create_autocmd("BufWritePost", {
--     group = vim.api.nvim_create_augroup("run_on_save", {clear = true}),
--     pattern = "*.go",
--     callback = function()
--         local append_data = function(_, data)
--             if data then
--                 vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
--             end
--         end
--
--         vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false,
--                                    {"main.go output"})
--         vim.fn.jobstart(command, {
--             stdout_buffered = true,
--             on_stdout = append_data,
--             on_stderr = append_data
--
--         })
--     end
-- })

return {
    colorscheme = "catppuccin",
    plugins = {
        {
            "L3MON4D3/LuaSnip",
            config = function(plugin, opts)
                require "plugins.configs.luasnip"(plugin, opts)
                require("luasnip.loaders.from_lua").load({
                    paths = "~/.config/nvim/snippets/"
                })
                require("luasnip").filetype_extend(".vue", {".js", ".ts"})
            end
        }
    }
}
