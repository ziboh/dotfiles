vim.opt.clipboard = "unnamedplus"
vim.g.leader = " "
vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>q", ":q<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n',"<c-s>","<cmd>w<cr>",{ noremap = true, silent = true })
vim.api.nvim_set_keymap('i',"<c-s>","<esc><cmd>w<cr>a",{ noremap = true, silent = true })

