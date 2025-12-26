local ls = require("luasnip")
local s = ls.snippet
-- local postfix = require("luasnip.extras.postfix").postfix
local i = ls.insert_node
local d = ls.dynamic_node
local f = ls.function_node
local sn = ls.snippet_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("useer", fmt("const {} = useRef<{}>(null);", {
    i(1),
    i(0)
  })),
}
