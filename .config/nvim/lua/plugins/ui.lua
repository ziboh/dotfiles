return {
  {
    "AstroNvim/astrotheme",
    config = function()
      require("astrotheme").setup({
        opts = {
          palette = "astrodark",
          plugins = { ["dashboard-nvim"] = true },
        },
      })
    end,
  },
}
