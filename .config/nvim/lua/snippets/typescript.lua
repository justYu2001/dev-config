local ls = require("luasnip")
local postfix = require("luasnip.extras.postfix").postfix
local i = ls.insert_node
local d = ls.dynamic_node
local f = ls.function_node
local sn = ls.snippet_node
local t = ls.text_node

local obj_match_pat = [[[%w_%d%.%[%]%{%}%"%'%:%,%s]+$]]
local func_match_pat = [[[%w%.%_%%(%)%\"%\'%/%k%,%s]+$]]

local function has_semi()
  local line = vim.api.nvim_get_current_line()

  return line:find(";")
end

return {
  postfix({ trig = ".return", match_pattern = obj_match_pat }, {
    t("return "),
    f(function(_, parent)
      return parent.snippet.env.POSTFIX_MATCH:gsub("^%s*(.-)%s*$", "%1") .. (
        has_semi() and "" or ";"
      )
    end, {}),
    i(0),
  }),

  postfix({ trig = ".const", match_pattern = obj_match_pat }, {
    t("const "),
    i(1),
    t(" = "),
    f(function(_, parent)
      return parent.snippet.env.POSTFIX_MATCH:gsub("^%s*(.-)%s*$", "%1") .. (
        has_semi() and "" or ";"
      )
    end, {}),
    i(0),
  }),

  postfix({
    trig = ".dest",
    match_pattern = func_match_pat
  }, {
    t("const { "),
    i(0),
    f(function(_, parent)
      return " } = " .. parent.snippet.env.POSTFIX_MATCH .. (
        has_semi() and "" or ";"
      )
    end, {}),
  }),

  postfix({
    trig = ".if",
    match_pattern = "[%w%.%_%s%(%)%&%|%!%=>%<]+$"
  }, {
    f(function(_, parent)
      local match = parent.snippet.env.POSTFIX_MATCH:gsub("^%s*(.-)%s*$", "%1")

      return "if (" .. match .. ") {"
    end, {}),
    t({"", "\t"}),
    i(0),
    t({"", "}"}),
  }),

  postfix(".log", {
    f(function(_, parent)
      return "console.log(" .. parent.snippet.env.POSTFIX_MATCH .. ");"
    end, {}),
    i(0),
  }),

  postfix({ 
    trig = ".await", 
    match_pattern = func_match_pat
  }, {
    f(function(_, parent)
      local content = parent.snippet.env.POSTFIX_MATCH

      content = content:gsub("^%s+", "")

      return "await " .. content .. ";"
    end, {}),
    i(0),
  }),
}
