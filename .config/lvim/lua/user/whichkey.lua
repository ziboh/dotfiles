-- Buffer
lvim.builtin.which_key.mappings["bd"] = { "<cmd>Bdelete<CR>", "Close Buffer" }
lvim.builtin.which_key.mappings["bp"] = { "<cmd>BufferLineTogglePin<cr>", "Buffer Pinning" }
lvim.builtin.which_key.mappings["bo"] = { "<cmd>lua require('user.utils').delete_other_buffers()<CR>", "Buffer Only" }
lvim.builtin.which_key.mappings["ba"] = { "<cmd>lua require('user.utils').delete_other_buffers()<CR>", "Buffer Only" }
lvim.builtin.which_key.mappings.b.D = { "<cmd>bd!<CR>", "Close Buffer (force)" }

lvim.builtin.which_key.mappings["c"] = {}
lvim.builtin.which_key.mappings["<space>"] = { "<CMD>Telescope find_files<CR>", "Find File" }

-- lsp
lvim.builtin.which_key.mappings.l = {
	name = "LSP",
	a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
	d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
	w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
	f = { "<cmd>lua require('lvim.lsp.utils').format()<cr>", "Format" },
	i = { "<cmd>LspInfo<cr>", "Info" },
	m = { "<cmd>Mason<cr>", "Mason Info" },
	j = {
		"<cmd>lua vim.diagnostic.goto_next()<cr>",
		"Next Diagnostic",
	},
	k = {
		"<cmd>lua vim.diagnostic.goto_prev()<cr>",
		"Prev Diagnostic",
	},
	l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
	q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
	r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
	s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
	S = {
		"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
		"Workspace Symbols",
	},
	e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
}

-- dap
lvim.keys.normal_mode["<F12>"] = ":Telescope dap configurations<cr>"
lvim.builtin.which_key.mappings.d = {
	name = "Debug",
	h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
	x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
	t = { "<cmd>lua require'persistent-breakpoints.api'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
	B = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
	c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
	C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
	d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
	g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
	i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
	o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
	u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
	p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
	s = { "<cmd>Telescope dap configurations<CR>", "Start" },
	Q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
	q = { "<cmd>bd! dap-terminal<CR>", "Close dap-terminal" },
	U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
	b = {
		name = "Breakpoints",
		t = { "<cmd>lua require'persistent-breakpoints.api'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
		s = {
			"<cmd>lua require('persistent-breakpoints.api').set_conditional_breakpoint()<cr>",
			"Toggle Breakpoint With Condition",
		},
		c = { "<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>", "Clear all point" },
		r = { "<cmd>lua require'dap'.repl.open()<cr>", "Open REPL" },
		R = { "<cmd>lua require'dap'.repl.run_last()<cr>", "Run Last REPL" },
	},
}

-- Trouble
lvim.builtin.which_key.mappings["t"] = {
	name = "Trouble/Tab",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace_Diagnostics" },
	t = { "<cmd>TodoTrouble<CR>", "Todo Trouble" },
	n = { "<cmd>tabnew<CR>", "New Tab" },
	o = { "<cmd>tabonly<CR>", "Close all tab except current tab" },
	c = { "<cmd>tabclose<CR>", "Close current table" },
}

-- session
lvim.builtin.which_key.mappings.s = {
	name = "session/Replace",
	n = { '<cmd>lua require("spectre").open()<CR>', "open Spectre" },
	w = { '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', "Search current word" },
	p = { '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', "Search on current file" },
	f = { "<cmd>SearchSession<CR>", "Find Session" },
	s = { "<cmd>SaveSession<cr>", "Save Session" },
	r = { "<cmd>RestoreSession<cr>", "Restore Session" },
	d = { "<cmd>DeleteSession<cr>", "Delete Session" },
}

-- find keymaps
lvim.builtin.which_key.mappings.f = {
	name = "find",
	b = { "<cmd>Telescope git_branches<cr>", "checkout branch" },
	f = { "<cmd>Telescope find_files<cr>", "find file" },
	h = { "<cmd>Telescope help_tags<cr>", "find help" },
	H = { "<cmd>Telescope highlights<cr>", "find highlight groups" },
	m = { "<cmd>Telescope man_pages<cr>", "man pages" },
	r = { "<cmd>Telescope oldfiles<cr>", "open recent file" },
	R = { "<cmd>Telescope registers<cr>", "registers" },
	g = { "<cmd>Telescope live_grep<cr>", "live_grep" },
	k = { "<cmd>Telescope keymaps<cr>", "keymaps" },
	C = { "<cmd>Telescope commands<cr>", "commands" },
	l = { "<cmd>Telescope resume<cr>", "resume last search" },
	c = {
		"<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
		"colorscheme with preview",
	},
	y = { "<cmd>Telescope neoclip<cr>", "Yank history" },
	n = { "<cmd>Telescope notify<CR>", "notify" },
	p = { "<cmd>Telescope projects<CR>", "projects" },
	t = { "<cmd>TodoTelescope<CR>", "Find Todo" },
}

-- windows management
lvim.builtin.which_key.mappings["w"] = {
	name = "windows",
	p = { '<cmd>lua require"user.utils".pick_windows()<CR>', "pick window" },
	s = { '<cmd>lua require"user.utils".swap_windows()<CR>', "swap windows" },
	w = { "<C-w>p", "Other window" },
	d = { "<C-w>c", "Delete window" },
	l = { "<C-w>v", "Spite window right" },
	j = { "<C-w>s", "Splite window below" },
	o = { "<C-w>o", "Only window" },
}

-- translate
lvim.builtin.which_key.mappings["x"] = {
	name = "Translate",
	t = { "<Plug>Translate", "Echo translation in the cmdline" },
	w = { "<Plug>TranslateW", "Display translation in a window" },
	r = { "<Plug>TranslateR", "Replace the text with translation" },
	x = { "<Plug>TranslateX", "Translate the text in clipboard" },
}
lvim.builtin.which_key.vmappings["x"] = {
	name = "Translate",
	t = { "<Plug>TranslateV", "Echo translation in the cmdline" },
	w = { "<Plug>TranslateWV", "Display translation in a window" },
	r = { "<Plug>TranslateRV", "Replace the text with translation" },
}

-- lsp
lvim.builtin.which_key.mappings["ll"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Line Diagnostics" }
lvim.builtin.which_key.mappings["lL"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" }

-- project
lvim.builtin.which_key.mappings["p"] = { "<cmd>SearchSession<CR>", "projects" }

lvim.builtin.which_key.mappings["P"] = {
	name = "Plugins",
	i = { "<cmd>Lazy install<cr>", "Install" },
	s = { "<cmd>Lazy sync<cr>", "Sync" },
	S = { "<cmd>Lazy clear<cr>", "Status" },
	c = { "<cmd>Lazy clean<cr>", "Clean" },
	u = { "<cmd>Lazy update<cr>", "Update" },
	p = { "<cmd>Lazy profile<cr>", "Profile" },
	l = { "<cmd>Lazy log<cr>", "Log" },
	d = { "<cmd>Lazy debug<cr>", "Debug" },
}

-- overseer
lvim.builtin.which_key.mappings["o"] = {
	name = "overseer",
	o = { "<cmd>OverseerToggle<cr>", "Toggle the overseer window" },
	s = { "<cmd>OverseerSaveBundle<cr>", "Save the current tasks" },
	l = { "<cmd>OverseerLoadBundle<cr>", "Load tasks" },
	r = { "<cmd>OverseerRun<cr>", "Run a task from a template" },
	d = { "<cmd>OverseerDeleteBundle<cr>", "Delete a saved task bundle" },
}
