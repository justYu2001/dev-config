-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("v", "vv", "<Esc>")

vim.keymap.set({"n", "x", "o"}, "zh", "^")
vim.keymap.set({"n", "x", "o"}, "zl", "$")

vim.keymap.set('n', '<D-b>', vim.lsp.buf.definition, { desc = "LSP Go to Definition" })

vim.keymap.set({ 'n', 'v' }, '<A-CR>', vim.lsp.buf.code_action, { desc = 'LSP Code Action' })

vim.keymap.set("n", "zfc", function()
  vim.cmd("silent! LspEslintFixAll")

  require("conform").format({
    formatters = { "prettier" },
    lsp_fallback = true,
  })
end, { desc = "LSP: Fix imports, ESLint and Format" })

-- Comment
vim.keymap.set({ "n", "v" }, "<D-/>", "gcc", { remap = true })

vim.keymap.set("n", "<M-d>", "yyp", { desc = "Duplicate line" })
vim.keymap.set("v", "<D-d>", "yPgv=gv", { desc = "Duplicate selection" })

-- Refactoring

vim.keymap.set("n", "zrn", function()
  local current_name = vim.fn.expand("<cword>")

  vim.api.nvim_input(":IncRename " .. current_name)
end, { desc = "Rename" })

vim.keymap.set("v", "zec", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      local title = action.title:lower()
      return title:match("extract") and title:match("constant") and title:match("enclosing")
    end,
    apply = true,
  })

  vim.defer_fn(function()
    vim.api.nvim_input(":IncRename ")
  end, 100)
end, { desc = "Extract local constant and rename" })

vim.keymap.set({ "n", "v" }, "zeg", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      local title = action.title:lower()
      return title:match("extract") and title:match("constant") and title:match("module")
    end,
    apply = true,
  })

  vim.defer_fn(function()
    vim.api.nvim_input(":IncRename ")
  end, 100)
end, { desc = "Extract global constant and rename" })

vim.keymap.set('n', 'zri', function()
  vim.lsp.buf.code_action({
    filter = function(action)
      return action.title:lower():match("inline") 
    end,
    apply = true
  })
end, { desc = "LSP: Inline Variable" })

vim.keymap.set(
  'n',
  'zrb',
  '"adi{va{"ap:s/return //e<CR>:s/;//e<CR>',
  { silent = true, desc = "Remove braces for an arrow function" }
)
