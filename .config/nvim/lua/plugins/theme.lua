return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon", 
      on_highlights = function(hl, c)
        -- Set color for inactive relative line numbers
        hl.LineNrAbove = { fg = c.comment }
        hl.LineNrBelow = { fg = c.comment }
      end,
    },
  },
}
