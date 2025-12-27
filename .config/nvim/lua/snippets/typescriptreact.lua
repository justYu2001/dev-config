local ls = require("luasnip")
local s = ls.snippet
local postfix = require("luasnip.extras.postfix").postfix
local i = ls.insert_node
local d = ls.dynamic_node
local f = ls.function_node
local sn = ls.snippet_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

local match_pat = [[[%w%s%p]+$]]

local function capitalize(args)
    local str = args[1][1] or ""
    if #str == 0 then
        return ""
    end
    return str:sub(1, 1):upper() .. str:sub(2)
end

return {
  s("useer", fmt("const {} = useRef<{}>(null);", {
    i(1),
    i(0)
  })),
  postfix({
    trig = ".state",
    match_pattern = match_pat
  }, {
    t("const ["),
    i(1),
    t(", set"),
    f(capitalize, {1}),
    f(function(_, parent)
      return "] = useState(" .. parent.snippet.env.POSTFIX_MATCH .. ");"
    end, {}),
  }),
}
