return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			local is_ok, configs = pcall(require, "nvim-treesitter.configs")
			if not is_ok then
				return
			end

			configs.setup({
				modules = {},
				-- A list of parser names, or "all" (the four listed parsers should always be installed)
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"yaml",
					"toml",
					"rust",
					"python",
					"make",
					"json",
					"dockerfile",
					"git_rebase",
					"gitcommit",
					"gitattributes",
					"gitignore",
					"comment", -- for tags like TODO:, FIXME(user)
					"diff", -- git diff
					"markdown_inline",
				},
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,
				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,
				-- List of parsers to ignore installing (for "all")
				ignore_install = { "javascript" },
				-- If you need to change the installation directory of the parsers (see -> Advanced Setup)
				-- parser_install_dir = "/some/path/to/store/parsers",
				-- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

				highlight = {
					-- Should we enable this module for all supported languages?
					enable = true,

					-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
					-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
					-- the name of the parser)
					-- if you want to disable the module for some languages you can pass a list to the `disable` option.
					disable = { "c", "rust" },
					-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
					-- disable = function(lang, buf)
					--     local max_filesize = 100 * 1024 -- 100 KB
					--     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					--     if ok and stats and stats.size > max_filesize then
					--         return true
					--     end
					-- end,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
				-- Indentation based on treesitter for the = operator. NOTE: This is an experimental feature.
				-- indent = {
				--     enable = true
				-- },
				incremental_selection = {
					enable = true,
					-- init_selection: in normal mode, start incremental selection.
					-- node_incremental: in visual mode, increment to the upper named parent.
					-- scope_incremental: in visual mode, increment to the upper scope
					-- node_decremental: in visual mode, decrement to the previous named node.
					keymaps = {
						init_selection = "gss",
						node_incremental = "gsi",
						scope_incremental = "gsc",
						node_decremental = "gsd",
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		enabled = false,
		config = function()
			local is_ok, configs = pcall(require, "nvim-treesitter.configs")
			if not is_ok then
				return
			end

			local config = {
				textobjects = {
					select = {
						enable = true,

						-- automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- you can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							-- you can optionally set descriptions to the mappings (used in the desc parameter of
							-- nvim_buf_set_keymap) which plugins like which-key display
							["ic"] = { query = "@class.inner", desc = "select inner part of a class region" },
							-- you can also use captures from other query groups like `locals.scm`
							["as"] = { query = "@scope", query_group = "locals", desc = "select language scope" },
						},
						-- you can choose the select mode (default is charwise 'v')
						--
						-- can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'v', or '<c-v>') or a table
						-- mapping query_strings to modes.
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "v", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
						-- if you set this to `true` (default is `false`) then any textobject is
						-- extended to include preceding or succeeding whitespace. succeeding
						-- whitespace has priority in order to act similarly to eg the built-in
						-- `ap`.
						--
						-- can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * selection_mode: eg 'v'
						-- and should return true or false
						include_surrounding_whitespace = true,
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>a"] = "@parameter.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = { query = "@class.outer", desc = "next class start" },
							--
							-- you can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
							["]o"] = "@loop.*",
							-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
							--
							-- you can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
							-- below example nvim-treesitter's `locals.scm` and `folds.scm`. they also provide highlights.scm and indent.scm.
							["]s"] = { query = "@scope", query_group = "locals", desc = "next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "next fold" },
						},
						goto_next_end = {
							["]m"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[m"] = "@function.outer",
							["[]"] = "@class.outer",
						},
						-- below will go to either the start or the end, whichever is closer.
						-- use if you want more granular movements
						-- make it even more gradual by adding multiple queries and regex.
						goto_next = {
							["]D"] = "@conditional.outer",
						},
						goto_previous = {
							["[D"] = "@conditional.outer",
						},
					},
				},
			}
			configs.setup(config)
		end,
	},
}
