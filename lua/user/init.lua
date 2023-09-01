local getFileExtension = function()
    local current_file = vim.fn.expand('%')
    return current_file:match("%.([^%.]+)$")
end

local fileTable = {
    ["cpp"] = {
        ["command"] = "./output",
        ["compile"] = true,
        ["compileCommand"] = {"g++", "-o", "output", "main.cpp"}

    },

    ["java"] = {
        ["command"] = "java bin/",
        ["compile"] = true,
        ["compileCommand"] = "javac -o bin/ src/*.java"
    },
    ["go"] = {
        ["command"] = "go run *.go",
        ["compile"] = false,
        ["compileCommand"] = nil
    }
}

local attach_to_buffer = function(output_bufnr, pattern, command, compile,
                                  compileCommand)
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("run_on_save", {clear = true}),
        pattern = pattern,
        callback = function()

            -- Cleaning buffer lines before adding new info
            vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, {})

            local append_data = function(_, data)
                print(data)
                if data then
                    vim.api
                        .nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
                end
            end

            if compile ~= 0 then
                vim.fn.jobstart(compileCommand, {stdout_buffered = false})
            end

            vim.fn.jobstart(command, {
                stdout_buffered = true,
                on_stdout = append_data,
                on_stderr = append_data

            })
        end
    })

end

vim.api.nvim_create_user_command("AutoRunCurrentBuf", function()
    local pattern = getFileExtension()

    vim.cmd("vsplit")

    local bufnr = vim.api.nvim_create_buf(true, true)
    local winnr = vim.api.nvim_get_current_win()

    attach_to_buffer(bufnr, "*." .. pattern, fileTable[pattern]["command"],
                     fileTable[pattern]["compile"],
                     fileTable[pattern]["compileCommand"])

    vim.api.nvim_win_set_buf(winnr, bufnr)

end, {})

vim.api.nvim_create_user_command("AutoRun", function()
    local bufnr = tonumber(vim.fn.input("Bufnr: "))
    local pattern = vim.fn.input("Pattern: ")
    local command = vim.split(vim.fn.input("Command: "), " ")
    local compile = tonumber(vim.fn.input("Compile: "))
    local compileCommand
    if compile ~= 0 then
        compileCommand = vim.split(vim.fn.input("Compile command: "), " ")
    end

    attach_to_buffer(bufnr, pattern, command, compile, compileCommand)
end, {})

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
