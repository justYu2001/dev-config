return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_lua").lazy_load({ paths = { "./lua/snippets" } })

      require("luasnip").filetype_extend("typescriptreact", { "typescript" })
    end,
  },
}
