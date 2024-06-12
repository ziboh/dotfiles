return {
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      require("mason").setup {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focused = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
        -- TODO: remove check when dropping support for neovim v0.10
        jump = vim.fn.has "nvim-0.11" == 1 and { float = true } or nil,
      }
      require("mason-lspconfig").setup {
        -- A list of servers to automatically install if they're not already installed
        ensure_installed = { "pyright", "lua_ls", "bashls", "taplo" },
      }

      require("mason-nvim-dap").setup {
        -- A list of servers to automatically install if they're not already installed
        ensure_installed = { "codelldb", "python" },
      }
    end,
  },
}
