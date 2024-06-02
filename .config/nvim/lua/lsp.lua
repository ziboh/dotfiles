-- Note: The order matters: mason -> mason-lspconfig -> lspconfig
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	-- A list of servers to automatically install if they're not already installed
	ensure_installed = { "pyright", "lua_ls", "bashls" },
})

-- Set different settings for different languages' LSP
-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--     - the settings table is sent to the LSP
--     - on_attach: a lua callback function to run after LSP attaches to a given buffer
local lspconfig = require("lspconfig")

-- Customized on_attach function
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "float in line" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "goto prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "goto next diagnostic" })
vim.keymap.set("n", "<leader>ll", vim.diagnostic.setloclist, { noremap = true, silent = true, desc = "setloclist" })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
	--
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set(
		"n",
		"gD",
		vim.lsp.buf.declaration,
		{ noremap = true, silent = true, buffer = bufnr, desc = "Lsp declaration" }
	)
	vim.keymap.set(
		"n",
		"gd",
		vim.lsp.buf.definition,
		{ noremap = true, silent = true, buffer = bufnr, desc = "Go to Definition" }
	)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, buffer = bufnr, desc = "Hover" })
	vim.keymap.set(
		"n",
		"gi",
		vim.lsp.buf.implementation,
		{ noremap = true, silent = true, buffer = bufnr, desc = "lsp implementation" }
	)
	vim.keymap.set(
		"n",
		"<C-k>",
		vim.lsp.buf.signature_help,
		{ noremap = true, silent = true, buffer = bufnr, desc = "Signature help" }
	)
	vim.keymap.set("n", "<leader>lL", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { noremap = true, silent = true, buffer = bufnr, desc = "List workspace folders" })
	vim.keymap.set(
		"n",
		"<leader>D",
		vim.lsp.buf.type_definition,
		{ noremap = true, silent = true, buffer = bufnr, desc = "Type definition" }
	)
	vim.keymap.set(
		"n",
		"<leader>ln",
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
		"<leader>lr",
		vim.lsp.buf.references,
		{ noremap = true, silent = true, buffer = bufnr, desc = "References" }
	)
	vim.keymap.set("n", "<leader>lf", function()
		vim.lsp.buf.format({
			async = true,
			-- Only request null-ls for formatting
			filter = function(client)
				return client.name == "null-ls"
			end,
		})
	end, { noremap = true, silent = true, buffer = bufnr, desc = "formatting" })
end

-- How to add a LSP for a specific language?
-- 1. Use `:Mason` to install the corresponding LSP.
-- 2. Add configuration below.
lspconfig.pyright.setup({
	on_attach = on_attach,
})

lspconfig.gopls.setup({
	on_attach = on_attach,
})

lspconfig.lua_ls.setup({
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
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

lspconfig.bashls.setup({})
