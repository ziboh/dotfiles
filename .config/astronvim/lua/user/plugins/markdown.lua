return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
    cmd = {"MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle"}
  },
  { "ellisonleao/glow.nvim", opts = {border = 'single'}, cmd = "Glow" },

}
