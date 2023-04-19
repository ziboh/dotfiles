vim.api.nvim_buf_set_keymap(
  0,
  "v",
  "<leader>d",
  "<ESC><cmd>lua require('dap-python').debug_selection()<cr>",
  { noremap = true, silent = true, desc = "Debug python Selection" }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>dm",
  "<cmd>lua require('dap-python').test_method()<cr>",
  { noremap = true, silent = true, desc = "Test Method" }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>de",
  "<cmd>lua require('dap-python').test_class()<cr>",
  { noremap = true, silent = true, desc = "Test Class" }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>dr",
  "<cmd>lua require('user.utils').run_current_python()<cr>",
  { noremap = true, silent = true, desc = "Run python with terminal" }
)

-- 获取当前工作目录
local workpath = vim.fn.getcwd()
-- 判断当前目录是否存在.python_version文件
local python_version_file = workpath .. "/.python-version"
local file_exist = io.open(python_version_file, "r") ~= nil
if file_exist then
  -- 读取python版本号
  local python_version = io.open(python_version_file, "r"):read("*l")
  -- 获取pyenv的安装目录
  local pyenv_root = vim.fn.getenv("PYENV_ROOT")
  vim.fn.setenv("VIRTUAL_ENV", pyenv_root .. "/versions/" .. python_version)
else
  vim.fn.setenv("VIRTUAL_ENV", nil)
end

local dap = require("dap")
dap.configurations.python = {

  {
    type = "python",
    request = "launch",
    name = "launch current file",
    program = "${file}",
    console = "integratedTerminal",
    cwd = "${workspaceFolder}",
    args = {},
    pythonPath = require("user.utils").get_workpath_python_resolve(),
  },
  {
    type = "python",
    request = "launch",
    name = "launch current file for args",
    program = "${file}",
    console = "integratedTerminal",
    args = function()
      local input = vim.fn.input("Input args: ")
      return require("user.utils").str2argtable(input)
    end,
    cwd = "${workspaceFolder}",
    pythonPath = require("user.utils").get_workpath_python_resolve(),
  },
}
