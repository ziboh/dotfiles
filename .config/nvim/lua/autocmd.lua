-- vim.cmd([[
--   augroup _fold_bug_solution  " https://github.com/nvim-telescope/telescope.nvim/issues/559
--     autocmd!
--     autocmd BufRead * autocmd BufWinEnter * ++once normal! zx
--   augroup end
--         ]])
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<C-_>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    -- Always save a special session named "last"
    require("resession").save("last")
  end,
})

-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		-- Only load the session if nvim was started with no args
-- 		if vim.fn.argc(-1) == 0 then
-- 			-- Save these to a different directory, so our manual sessions don't get polluted
-- 			require("resession").load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
-- 		end
-- 	end,
-- 	nested = true,
-- })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    require("resession").save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
  end,
})
