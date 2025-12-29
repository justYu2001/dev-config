return {
  {
    "folke/snacks.nvim",
    opts = {
      notifier = {
        timeout = 10000,
      },
      styles = {
        notification = {
          border = true,
          zindex = 100,
          ft = "markdown",
          wo = {
            winblend = 5,
            wrap = true,
            conceallevel = 2,
            colorcolumn = "",
          },
          bo = { filetype = "snacks_notif" },
        },
      },
    },
  },
}
