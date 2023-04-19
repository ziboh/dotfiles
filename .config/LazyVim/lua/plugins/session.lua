return {
  -- session management
  {
    "folke/persistence.nvim",
    enabled = false,
  },
	{
		"Shatur/neovim-session-manager",
		enabled = true,
    name = 'session_manager',
		event = "UIEnter",
		opts = {
			autosave_ignore_filetypes = {
				"gitcommit",
				"toggleterm",
			},
			autosave_ignore_buftypes = {
				"terminal",
				"quickfix",
				"help",
				"nofile",
			},
			-- autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
		},
		config = function(_, opts)
			local session = require("session_manager")
			session.setup(opts)
			-- vim.cmd("SessionManager! load_current_dir_session")
		end,
    keys = {
      {'<leader>sf','<cmd>SessionManager load_session<cr>',desc='select session'}
    }
	},
}

