vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, {
  "pyright",
}
)

-- -- pyright settings
require("lvim.lsp.manager").setup("pyright", {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
        typeCheckingMode = "off",
        autoImportCompletions = true
      },
    }
  },
})

-- require("lvim.lsp.manager").setup("pylsp", {
--   settings = {
--     pylsp = {
--       plugins = {
--         ruff = { enabled = true, ignore = { 'E501' }, },
--         autopep8 = { enabled = false },
--         yapf = { enabled = true, based_on_style = "google", indent_width = 2 },
--         black = { enabed = false },
--         pycodestyle = { enabled = true, indentSize = 2, maxLineLength = 80 },
--         isort = { enabled = true, },
--         rope_autoimport  = {enabled = true}
--       },
--     },
--   },
-- })

-- Set a formatter.
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
}

-- Set a linter.
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" }, args = { "--ignore=E501" } }
}

local dap_python = require 'dap-python'

-- Setup dap for python
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  dap_python.setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

pcall(function()
  dap_python.test_runner = "unittest"
  dap_python.resolve_python = require "user.utils".get_workpath_python_resolve
end)
