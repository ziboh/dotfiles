-- python provide
-- 判断是否有环境变量PYENV_ROOT
if vim.fn.getenv('PYENV_ROOT') ~= '' then
  -- 设置python3_host_prog
  vim.g.python3_host_prog = vim.fn.getenv('PYENV_ROOT') .. '/versions/pynvim/bin/python'
end


lvim.reload_config_on_save = true

-- colorscheme
-- lvim.colorscheme = "catppuccin"
lvim.colorscheme = "tokyonight"

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true

lvim.log.level = "info"
lvim.format_on_save = false

vim.opt.foldlevel = 99
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "expr"

-- keymap
lvim.leader = "space"
lvim.keys.insert_mode["<C-s>"] = "<esc>:w<cr>a"
lvim.keys.normal_mode["H"] = "^"
lvim.keys.normal_mode["L"] = "$"
lvim.keys.normal_mode["Q"] = "q"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["n"] = "nzzzv"
lvim.keys.normal_mode["N"] = "Nzzzv"
lvim.keys.normal_mode["<leader>q"] = ":bd<cr>"
lvim.keys.normal_mode["q"] = "<Nop>"
lvim.keys.normal_mode["<cr>"] = "o<esc>"
lvim.keys.normal_mode["<bs>"] = "ddk"
-- lvim.keys.normal_mode["J"] = "5j"
-- lvim.keys.normal_mode["K"] = "5k"
lvim.keys.normal_mode["]t"] = "<cmd>tabnext<cr>"
lvim.keys.normal_mode["[t"] = "<cmd>tabprevious<cr>"
lvim.keys.normal_mode["[d"] = "<cmd>lua vim.diagnostic.goto_prev()<cr>"
lvim.keys.normal_mode["]d"] = "<cmd>lua vim.diagnostic.goto_next()<cr>"

lvim.keys.visual_mode["p"] = "P"
lvim.keys.visual_mode["H"] = "^"
lvim.keys.visual_mode["L"] = "$h"
lvim.keys.visual_mode["J"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["K"] = ":m '<-2<CR>gv=gv"


vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions"


-- alpha dashboard options
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.alpha.dashboard = {
  config = {},
  section = require('user.dashboard').get_sections(),
  opts = { autostart = true },
}

-- dapui配置
lvim.builtin.dap.active = true
lvim.builtin.dap.ui.config.reset = true


-- buffer line
lvim.builtin.bufferline.highlights.buffer_selected = {
  bold = true,
  fg = "#ffd43b"
}

-- treesitter
lvim.builtin.treesitter.auto_install = true
lvim.builtin.treesitter.matchup.enable = true
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "cpp",
  "json",
  "lua",
  "python",
  "yaml",
  "html",
  "markdown"
}

-- terminal configuration
lvim.builtin.terminal.active = true
lvim.builtin.terminal.size = 40
lvim.builtin.terminal.open_mapping = '<C-t>'
lvim.builtin.terminal.direction = 'vertical'

--LspInstall jsonls statusline
local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_y = {
  function()
    return vim.fn.expand('%:t')
  end,
  function()
    return " " .. os.date("%R")
  end,
  components.spaces,
  components.location,
}


-- nvim-tree
lvim.builtin.nvimtree.active = true
lvim.builtin.nvimtree.setup.update_focused_file.ignore_list = { "toggleterm", "terminal", "" }


-- project
vim.list_extend(lvim.builtin.project.patterns, { "package.json", "lazy-lock.json", ".python-version", ".vscode" })
vim.list_extend(lvim.builtin.project.detection_methods, { "lsp" })
lvim.builtin.project.ignore_buftype = { "nofity", "nowrite" }
lvim.builtin.project.ignore_ft = { "startify", "dashboard" }

-- uodotree
-- Set the focus on undotree window when it's toggled
vim.g.undotree_SetFocusWhenToggle = 1

-- Set the custom undotree window width and diff panel height
vim.g.undotree_CustomUndotreeCmd = 'topleft vertical 30 new'
vim.g.undotree_CustomDiffpanelCmd = 'belowright 10 new'

-- gitsigns
lvim.builtin.gitsigns.opts.current_line_blame = true

-- translator
vim.g.translator_target_lang = 'zh'
vim.g.translator_source_lang = 'auto'

lvim.builtin.mason.registries = {
  "lua:mason-registry.index",
  "github:mason-org/mason-registry",
}

lvim.lsp.buffer_mappings.normal_mode = {
  -- ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover" },
  ["<leader>lh"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover" },
  ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto definition" },
  ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
  ["gr"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "Goto references" },
  ["gI"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto Implementation" },
  ["gh"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "show signature help" },
  ["gl"] = {
    function()
      local config = lvim.lsp.diagnostics.float
      config.scope = "line"
      ---@diagnostic disable-next-line: param-type-mismatch
      vim.diagnostic.open_float(0, config)
    end,
    "Show line diagnostics",
  }
}

lvim.lsp.automatic_configuration.skipped_filetypes = vim.tbl_filter(function(server)
  return server ~= 'markdown'
end, lvim.lsp.automatic_configuration.skipped_filetypes)


function _G.get_skipped_ft()
  -- 遍历skipped_filetypes
  local notify = ''
  for _, value in pairs(lvim.lsp.automatic_configuration.skipped_filetypes) do
    notify = notify .. value .. '\n'
  end
  vim.notify(notify)
end

vim.g.markdown_recommended_style = 0
