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
