lvim.plugins = {
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"theHamsta/nvim-dap-virtual-text",
	"mfussenegger/nvim-dap-python",
	"tpope/vim-repeat",
	"moll/vim-bbye",
}
-- 获取plugins文件夹下的所有文件导入到lvim.plguins
---@diagnostic disable-next-line: param-type-mismatch
for _, plugin in ipairs(vim.fn.globpath("~/.config/lvim/lua/user/plugins", "*.lua", 0, 1)) do
	local plugins = require("user.plugins." .. plugin:match("([^/]+)%.lua$"))
	-- 判断是否是plugins是不是由table组成的table
	if type(plugins[1]) == "table" then
		vim.list_extend(lvim.plugins, plugins)
	else
		table.insert(lvim.plugins, plugins)
	end
end
