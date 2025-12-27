local ls = require("luasnip")
local postfix = require("luasnip.extras.postfix").postfix
local i = ls.insert_node
local d = ls.dynamic_node
local f = ls.function_node
local sn = ls.snippet_node
local t = ls.text_node

local match_pat = [[[%w%s%p]+$]]

return {
  postfix({ trig = ".return", match_pattern = match_pat }, {
    t("return "),
    f(function(_, parent)
      return parent.snippet.env.POSTFIX_MATCH:gsub("^%s*(.-)%s*$", "%1")
    end, {}),
    i(0),
  }),

  postfix({ trig = ".const", match_pattern = match_pat }, {
    t("const "),
    i(1),
    t(" = "),
    f(function(_, parent)
      return parent.snippet.env.POSTFIX_MATCH:gsub("^%s*(.-)%s*$", "%1")
    end, {}),
    i(0),
  }),

  postfix({
    trig = ".dest",
    match_pattern = match_pat
  }, {
    t("const { "),
    i(0),
    f(function(_, parent)
      return " } = " .. parent.snippet.env.POSTFIX_MATCH
    end, {}),
  }),

  postfix({
    trig = ".if",
    match_pattern = match_pat
  }, {
    f(function(_, parent)
      local match = parent.snippet.env.POSTFIX_MATCH:gsub("^%s*(.-)%s*$", "%1")

      return "if (" .. match .. ") {"
    end, {}),
    t({"", "\t"}),
    i(0),
    t({"", "}"}),
  }),

  postfix({
    trig = ".log",
    match_pattern = match_pat
  }, {
    f(function(_, parent)
      local match = parent.snippet.env.POSTFIX_MATCH:gsub("^%s*(.-)%s*$", "%1")

      return "console.log(" .. match .. ")"
    end, {}),
    i(0),
  }),

  postfix({ 
    trig = ".await", 
    match_pattern = match_pat
  }, {
    f(function(_, parent)
      local content = parent.snippet.env.POSTFIX_MATCH

      content = content:gsub("^%s+", "")

      return "await " .. content
    end, {}),
    i(0),
  }),
}
