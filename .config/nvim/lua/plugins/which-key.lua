return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		local wk = require("which-key")
		-- As an example, we will create the following mappings:
		--  * <leader>ff find files
		--  * <leader>fr show recent files
		--  * <leader>fb Foobar
		-- we'll document:
		--  * <leader>fn new file
		--  * <leader>fe edit file
		-- and hide <leader>1

		wk.register({
			f = {
				name = "File", -- optional group name
			},
			g = {
				name = "Git",
			},
			b = {
				name = "Buffer",
			},
			l = {
				name = "Lsp",
			},
			m = {
				name = "Muren",
			},
			x = {
				name = "Trouble",
			},
		}, { prefix = "<leader>" })
	end,
}
