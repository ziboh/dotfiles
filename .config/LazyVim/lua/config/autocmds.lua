function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<C-]>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- dapui keymap
function _G.dapui_setup_console_mapping()
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
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

vim.cmd("autocmd! TermOpen  [dap-terminal* lua set_dap_terminal_keymaps()")

-- 将系统剪切板中的‘\r‘删除
function _G.__lvim_trim_cr()
  local text = vim.fn.getreg("+")
  text = text:gsub("\r", "")
  vim.fn.setreg("+", text)
end

-- 当vim重新获取焦点时替换’\r'
vim.cmd("autocmd FocusGained  * lua __lvim_trim_cr()")

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md",
  callback = function()
    vim.cmd('nnoremap "<C-CR>" "o"')
    vim.cmd('inoremap "<C-CR>" "<esc>o"')
  end,
})
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "*" },
  callback = function()
    vim.b.autoformat = false
  end,
})
