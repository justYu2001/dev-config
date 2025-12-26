-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("v", "vv", "<Esc>")
vim.keymap.set("n", "zh", "^")
vim.keymap.set("n", "zl", "$")

vim.keymap.set('n', '<D-b>', vim.lsp.buf.definition, { desc = "LSP Go to Definition" })

-- Comment
vim.keymap.set("n", "<D-/>", "gcc", { remap = true })

vim.keymap.set("n", "<M-d>", "yyp", { desc = "Duplicate line" })
vim.keymap.set("v", "<D-d>", "yPgv=gv", { desc = "Duplicate selection" })

-- Go to next error
vim.keymap.set("n", "zn", vim.diagnostic.goto_next)

-- Go to previous error
vim.keymap.set("n", "zk", vim.diagnostic.goto_prev)

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
