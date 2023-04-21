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
        { "<leader>as", desc = "fix text with AI" },
        { "<leader>ag", desc = "generate git message" },
        { "<leader>aa", "<cmd>NeoAIToggle<cr>",desc = "NeoAi toggle" },
    },
    config = function()
        require("neoai").setup({
            -- Options go here
        })
    end,
}
