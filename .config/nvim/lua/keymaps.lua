-- require("Comment.api").toggle.linewise(vim.fn.visualmode())
-- Normal mode --
-----------------
vim.g.leader = " "
vim.keymap.set("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.keymap.set("n", "<c-s>", "<cmd>w<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<Space>q", ":q<cr>", { noremap = true, silent = true, desc = "quit" })
vim.keymap.set("n", "<Space>c", ":bd<cr>", { noremap = true, silent = true, desc = "close" })

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

vim.keymap.set("n", "L", "$", { noremap = true, silent = true, desc = "Move to end of line" })
vim.keymap.set("n", "H", "^", { noremap = true, silent = true, desc = "Move to first non-blank character" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Increase window height" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Decrease window height" })
vim.keymap.set("n", "M", "J", { noremap = true, silent = true, desc = "Join the current line with the next line" })

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true })

local map = vim.api.nvim_set_keymap
function nm(key, command)
	map("n", key, command, { noremap = true, silent = true })
end
function vm(key, command)
	map("v", key, command, { noremap = true })
end
nm("<C-_>", ":lua require('Comment.api').toggle.linewise.current(); vim.cmd('normal j')<CR>")
nm("<leader>/", ":lua require('Comment.api').toggle.linewise.current(); vim.cmd('normal j')<CR>")
vm("<C-_>", ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
vm("<leader>/", ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
nm("<C-\\>", ":lua require('Comment.api').toggle.blockwise.current(); vim.cmd('normal j')<CR>")
nm("<C-\\>", ":lua require('Comment.api').toggle.blockwise.current(); vim.cmd('normal j')<CR>")
vm("<C-\\>", ":lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>")

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set("v", "L", "$h", { noremap = true, silent = true, desc = "Move to end of line" })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true, desc = "Unindent line" })
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true, desc = "Unindent line" })
vim.keymap.set("v", "H", "^", { noremap = true, silent = true, desc = "Move to first non-blank character" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv-gv", { noremap = true, silent = true, desc = "Move line down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv-gv", { noremap = true, silent = true, desc = "Move line up" })

-- For nvim-treesitter
-- 1. Press `gss` to intialize selection. (ss = start selection)
-- 2. Now we are in the visual mode.
-- 3. Press `gsi` to increment selection by AST node. (si = selection incremental)
-- 4. Press `gsc` to increment selection by scope. (sc = scope)
-- 5. Press `gsd` to decrement selection. (sd = selection decrement)

-----------------
-- Insert mode --
-----------------
vim.keymap.set("i", "<c-s>", "<esc><cmd>w<cr>a", { noremap = true, silent = true })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true, desc = "Move line up" })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true, desc = "Move line down" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })
vim.keymap.set("o", "H", "^", { noremap = true, silent = true, desc = "Move to first non-blank character" })
vim.keymap.set("o", "L", "$", { noremap = true, silent = true, desc = "Move to end of line" })
