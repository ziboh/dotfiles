return
{
  "zbirenbaum/copilot-cmp",
  cmd = "Copilot",
  dependencies = {
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      build = ":Copilot auth",
      event = { 'VimEnter' },
      config = function()
        vim.defer_fn(function()
          require("copilot").setup {
            suggestion = { enabled = false },
            panel = { enabled = false },
          }
        end, 100)
      end,
    },
  },
  opts = {}
}
