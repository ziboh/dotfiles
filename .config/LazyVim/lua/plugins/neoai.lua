return {
  "Bryley/neoai.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  cmd = {
    "NeoAI",
    "NeoAIOpen",
    "NeoAIClose",
    "NeoAIToggle",
    "NeoAIContext",
    "NeoAIContextOpen",
    "NeoAIContextClose",
    "NeoAIInject",
    "NeoAIInjectCode",
    "NeoAIInjectContext",
    "NeoAIInjectContextCode",
  },
  keys = {
    { "<leader>aa", desc = "summarize text" },
    { "<leader>as", desc = "summarize text" },
    { "<leader>ag", desc = "generate git message" },
    {
      "<leader>ac",
      function()
        local input = vim.fn.input("Input Context: ")
        if input == "" then
          return
        end
        vim.cmd("NeoAIContext " .. input)
      end,
      desc = "NeoAi Context",
      mode = "v",
    },
  },
  config = function()
    require("neoai").setup({
      -- Options go here
    })
  end,
}
