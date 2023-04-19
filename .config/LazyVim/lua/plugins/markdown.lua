return {
  'iamcco/markdown-preview.nvim',
  build = "cd app && npm install",
  ft = "markdown",
  event = "BufRead",
  enable = true,
  config = function()
    vim.g.mkdp_auto_start = 1
  end,
}
