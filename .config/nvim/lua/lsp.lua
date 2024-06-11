local lspconfig = require "lspconfig"
local utils = require "utils"
local get_icon = utils.get_icon

-- See `:help vim.lsp.buf.inlay_hint` for documentation on the inlay_hint API
vim.lsp.inlay_hint.enable(true)
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.g.diagnostics_config = {
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = get_icon "DiagnosticError",
      [vim.diagnostic.severity.HINT] = get_icon "DiagnosticHint",
      [vim.diagnostic.severity.WARN] = get_icon "DiagnosticWarn",
      [vim.diagnostic.severity.INFO] = get_icon "DiagnosticInfo",
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
  -- TODOvm: remove check when dropping support for neovim v0.10
  jump = vim.fn.has "nvim-0.11" == 1 and { float = true } or nil,
}

vim.diagnostic.config(require("utils.diagnostics").diagnostics[vim.g.diagnostics_mode or 3])

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  vim.keymap.set("n", "<leader>uH", function()
    if vim.lsp.inlay_hint.is_enabled { bufnr = 0 } then
      vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
    else
      vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
    end
  end, { noremap = true, silent = true, buffer = bufnr, desc = "Toggle Lsp inlay hints(buffer)" })

  vim.keymap.set("n", "<leader>uh", function()
    if vim.lsp.inlay_hint.is_enabled {} then
      vim.lsp.inlay_hint.enable(false)
    else
      vim.lsp.inlay_hint.enable(true)
    end
  end, { noremap = true, silent = true, buffer = bufnr, desc = "Toggle Lsp inlay hints(global)" })
  vim.keymap.set(
    "n",
    "gD",
    vim.lsp.buf.declaration,
    { noremap = true, silent = true, buffer = bufnr, desc = "Lsp declaration" }
  )

  vim.keymap.set(
    "n",
    "<leader>ld",
    vim.diagnostic.open_float,
    { noremap = true, silent = true, buffer = bufnr, desc = "float in line" }
  )

  vim.keymap.set(
    "n",
    "[d",
    vim.diagnostic.goto_prev,
    { noremap = true, silent = true, buffer = bufnr, desc = "goto prev diagnostic" }
  )

  vim.keymap.set(
    "n",
    "]d",
    vim.diagnostic.goto_next,
    { noremap = true, silent = true, buffer = bufnr, desc = "goto next diagnostic" }
  )

  vim.keymap.set(
    "n",
    "<leader>ll",
    vim.diagnostic.setloclist,
    { noremap = true, buffer = bufnr, silent = true, desc = "setloclist" }
  )

  vim.keymap.set(
    "n",
    "gd",
    vim.lsp.buf.definition,
    { noremap = true, silent = true, buffer = bufnr, desc = "Go to Definition" }
  )

  vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, { noremap = true, silent = true, buffer = bufnr, desc = "Hover" })

  vim.keymap.set(
    "n",
    "<leader>lh",
    vim.lsp.buf.hover,
    { noremap = true, silent = true, buffer = bufnr, desc = "Hover" }
  )
  vim.keymap.set(
    "n",
    "gi",
    vim.lsp.buf.implementation,
    { noremap = true, silent = true, buffer = bufnr, desc = "lsp implementation" }
  )
  vim.keymap.set(
    "n",
    "<leader>lh",
    vim.lsp.buf.signature_help,
    { noremap = true, silent = true, buffer = bufnr, desc = "Signature help" }
  )
  vim.keymap.set(
    "n",
    "<leader>lL",
    function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    { noremap = true, silent = true, buffer = bufnr, desc = "List workspace folders" }
  )
  vim.keymap.set(
    "n",
    "<leader>D",
    vim.lsp.buf.type_definition,
    { noremap = true, silent = true, buffer = bufnr, desc = "Type definition" }
  )
  vim.keymap.set(
    "n",
    "<leader>lr",
    vim.lsp.buf.rename,
    { noremap = true, silent = true, buffer = bufnr, desc = "Rename" }
  )
  vim.keymap.set(
    "n",
    "<leader>la",
    vim.lsp.buf.code_action,
    { noremap = true, silent = true, buffer = bufnr, desc = "Code Action" }
  )
  vim.keymap.set(
    "n",
    "<leader>lR",
    vim.lsp.buf.references,
    { noremap = true, silent = true, buffer = bufnr, desc = "References" }
  )
  vim.keymap.set("n", "<leader>lf", function()
    vim.lsp.buf.format {
      async = true,
      -- Only request null-ls for formatting
      filter = function(client) return client.name == "null-ls" end,
    }
  end, { noremap = true, silent = true, buffer = bufnr, desc = "formatting" })
end

local rust_on_attach = function(client, bufnr)
  on_attach(client, bufnr)

  if client.server_capabilities.code_lens or client.server_capabilities.codeLensProvider then
    local group = vim.api.nvim_create_augroup("LSPRefreshLens", { clear = true })

    -- Code Lens
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
      desc = "Auto show code lenses",
      buffer = bufnr,
      callback = function() vim.lsp.codelens.refresh() end,
      group = group,
    })
  end

  vim.keymap.set(
    "n",
    "<leader>lf",
    "<cmd>RustFmt<CR>",
    { noremap = true, silent = true, buffer = bufnr, desc = "formatting" }
  )
  vim.keymap.set(
    "n",
    "<leader>h",
    "<cmd>RustLsp hover actions<CR>",
    { noremap = true, silent = true, buffer = bufnr, desc = "Hover actions" }
  )
end

local function get_dap_adapter()
  local adapter
  local success, package = pcall(function() return require("mason-registry").get_package "codelldb" end)
  local cfg = require "rustaceanvim.config"
  if success then
    local package_path = package:get_install_path()
    local codelldb_path = package_path .. "/codelldb"
    local liblldb_path = package_path .. "/extension/lldb/lib/liblldb"
    local this_os = vim.loop.os_uname().sysname

    -- The path in windows is different
    if this_os:find "Windows" then
      codelldb_path = package_path .. "\\extension\\adapter\\codelldb.exe"
      liblldb_path = package_path .. "\\extension\\lldb\\bin\\liblldb.dll"
    else
      -- The liblldb extension is .so for linux and .dylib for macOS
      liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
    end
    adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
  else
    adapter = cfg.get_codelldb_adapter()
  end
  return adapter
end

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
    test_executor = "toggleterm",
  },
  -- LSP configuration
  server = {
    on_attach = rust_on_attach,
    default_settings = {
      -- rust-analyzer language server configuration
      ["rust-analyzer"] = {},
    },
  },
  -- DAP configuration
  dap = { adapter = get_dap_adapter() },
}
-- How to add a LSP for a specific language?
-- 1. Use `:Mason` to install the corresponding LSP.
-- 2. Add configuration below.
lspconfig.pyright.setup {
  on_attach = on_attach,
}

lspconfig.gopls.setup {
  on_attach = on_attach,
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      -- workspace = {
      -- 	-- Make the server aware of Neovim runtime files
      -- 	library = vim.api.nvim_get_runtime_file("", true),
      -- },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

lspconfig.bashls.setup {}
