-- toggleterm keymap
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<C-]>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- dapui keymap
function _G.dapui_setup_console_mapping()
	---@diagnostic disable-next-line
	local bufname = vim.fn.bufname("%")
	if string.find(bufname, "DAP Console") then
		vim.api.nvim_buf_set_keymap(0, "t", "<ESC>", "<C-\\><C-n>", { noremap = true })
	end
end

vim.api.nvim_exec(
	[[
  autocmd FileType dapui_console lua dapui_setup_console_mapping()
]],
	false
)

-- dap termnal keymap
function _G.set_dap_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<leader>bd", "<cmd>bd!<cr>", opts)
	vim.keymap.set("n", "<leader>bd", "<cmd>bd!<cr>", opts)
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

vim.cmd("autocmd! TermOpen  [dap-terminal* lua set_dap_terminal_keymaps()")

-- nvim-tree
local api = require("nvim-tree.api")
local Event = api.events.Event
api.events.subscribe(Event.TreeOpen, function()
	vim.cmd("OverseerClose")
	require("user.utils").close_undotree()
end)

---@diagnostic disable-next-line: undefined-field
vim.api.nvim_create_autocmd({ "DirChanged" }, {
	callback = function()
		vim.defer_fn(function()
			vim.cmd("Copilot disable")
			vim.cmd("Copilot enable")
		end, 100)
	end,
})

-- 判断是否是wsl
if vim.fn.has("wsl") == 1 then
	---@diagnostic disable-next-line:undefined-field
	vim.api.nvim_create_autocmd({ "FocusGained" }, {
		callback = function()
			vim.defer_fn(function()
				local text = vim.fn.getreg("+")
				---@diagnostic disable-next-line: undefined-field
				text = text:gsub("\r", "")
				vim.fn.setreg("+", text)
			end, 0)
		end,
	})
end
