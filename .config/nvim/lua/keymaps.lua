local utils = require("utils")
local get_icon = utils.get_icon
local is_available = utils.is_available
local maps = require("utils").get_mappings_template()

local icons = {
  w = { desc = get_icon("Window", 1, true) .. "Window" },
  x = { desc = get_icon("DiagnosticWarn", 1, true) .. "Trouble" },
  r = { desc = get_icon("Replace", 1, true) .. "Replace" },
  f = { desc = get_icon("Search", 1, true) .. "Find" },
  p = { desc = get_icon("Package", 1, true) .. "Packages/" .. get_icon("Python", 1, true) .. "Python" },
  l = { desc = get_icon("ActiveLSP", 1, true) .. "LSP" },
  u = { desc = get_icon("Window", 1, true) .. "UI" },
  b = { desc = get_icon("Tab", 1, true) .. "Buffers" },
  bs = { desc = get_icon("Sort", 1, true) .. "Sort Buffers" },
  c = { desc = get_icon("Run", 1, true) .. "Compiler" },
  d = { desc = get_icon("Debugger", 1, true) .. "Debugger" },
  tt = { desc = get_icon("Test", 1, true) .. "Test" },
  dc = { desc = get_icon("Docs", 1, true) .. "Docs" },
  g = { desc = get_icon("Git", 1, true) .. "Git" },
  s = { desc = get_icon("Session", 1, true) .. "Session" },
  t = { desc = get_icon("Terminal", 1, true) .. "Terminal" },
}

-- Normal mode --
-----------------
-- vim.g.leader = " "
vim.keymap.set("n", "<C-n>", "5j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-p>", "5k", { noremap = true, silent = true })
vim.keymap.set("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.keymap.set("n", "<c-s>", "<cmd>w<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<Space>q", "<cmd>q<cr>", { noremap = true, silent = true, desc = "quit" })
-- vim.keymap.set("n", "<tab>", "w", { noremap = true, silent = true })

vim.keymap.set("n", "L", "$", { noremap = true, silent = true, desc = "Move to end of line" })
vim.keymap.set("n", "H", "^", { noremap = true, silent = true, desc = "Move to first non-blank character" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Increase window height" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Decrease window height" })
vim.keymap.set("n", "M", "J", { noremap = true, silent = true, desc = "Join the current line with the next line" })

vim.keymap.set(
  "n",
  "<C-_>",
  ":lua require('Comment.api').toggle.linewise.current(); vim.cmd('normal j')<CR>",
  { noremap = true, silent = true, desc = "Toggle Comment linewise" }
)
vim.keymap.set(
  "n",
  "<leader>/",
  ":lua require('Comment.api').toggle.linewise.current(); vim.cmd('normal j')<CR>",
  { noremap = true, silent = true, desc = "Toggle Comment linewise" }
)
vim.keymap.set(
  "v",
  "<C-_>",
  ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { noremap = true, desc = "Toggle Comment lineise" }
)
vim.keymap.set(
  "v",
  "<leader>/",
  ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { noremap = true, desc = "Toggle Comment lineise" }
)
vim.keymap.set(
  "n",
  "<C-\\>",
  ":lua require('Comment.api').toggle.blockwise.current(); vim.cmd('normal j')<CR>",
  { noremap = true, silent = true, desc = "Toggle blockwise Comment" }
)
vim.keymap.set(
  "v",
  "<C-\\>",
  ":lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>",
  { noremap = true, desc = "Toggle blockwise Comment" }
)

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
-- For toggletrem

-- buffers/tabs [buffers ]--------------------------------------------------
maps.n["<leader>c"] = { -- Close window and buffer at the same time.
  function()
    require("heirline-components.buffer").wipe()
  end,
  desc = "Wipe buffer",
}
maps.n["<leader>C"] = { -- Close buffer keeping the window.
  function()
    require("heirline-components.buffer").close()
  end,
  desc = "Close buffer",
}
-- Close buffer keeping the window → Without confirmation.
-- maps.n["<leader>X"] = {
--   function() require("heirline-components.buffer").close(0, true) end,
--   desc = "Force close buffer",
--
maps.n["<leader>ba"] = {
  function()
    vim.cmd("wa")
  end,
  desc = "Write all changed buffers",
}
maps.n["]b"] = {
  function()
    require("heirline-components.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
  end,
  desc = "Next buffer",
}
maps.n["[b"] = {
  function()
    require("heirline-components.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
  end,
  desc = "Previous buffer",
}
maps.n[">b"] = {
  function()
    require("heirline-components.buffer").move(vim.v.count > 0 and vim.v.count or 1)
  end,
  desc = "Move buffer tab right",
}
maps.n["<b"] = {
  function()
    require("heirline-components.buffer").move(-(vim.v.count > 0 and vim.v.count or 1))
  end,
  desc = "Move buffer tab left",
}

maps.n["<leader>b"] = icons.b
maps.n["<leader>bc"] = {
  function()
    require("heirline-components.buffer").close_all(true)
  end,
  desc = "Close all buffers except current",
}
maps.n["<leader>bC"] = {
  function()
    require("heirline-components.buffer").close_all()
  end,
  desc = "Close all buffers",
}
maps.n["<leader>bb"] = {
  function()
    require("heirline-components.all").heirline.buffer_picker(function(bufnr)
      vim.api.nvim_win_set_buf(0, bufnr)
    end)
  end,
  desc = "Select buffer from tabline",
}
maps.n["<leader>bd"] = {
  function()
    require("heirline-components.all").heirline.buffer_picker(function(bufnr)
      require("heirline-components.buffer").close(bufnr)
    end)
  end,
  desc = "Delete buffer from tabline",
}
maps.n["<leader>bl"] = {
  function()
    require("heirline-components.buffer").close_left()
  end,
  desc = "Close all buffers to the left",
}
maps.n["<leader>br"] = {
  function()
    require("heirline-components.buffer").close_right()
  end,
  desc = "Close all buffers to the right",
}
maps.n["<leader>bs"] = { desc = "Sort Buffer" }
maps.n["<leader>bse"] = {
  function()
    require("heirline-components.buffer").sort("extension")
  end,
  desc = "Sort by extension (buffers)",
}
maps.n["<leader>bsr"] = {
  function()
    require("heirline-components.buffer").sort("unique_path")
  end,
  desc = "Sort by relative path (buffers)",
}
maps.n["<leader>bsp"] = {
  function()
    require("heirline-components.buffer").sort("full_path")
  end,
  desc = "Sort by full path (buffers)",
}
maps.n["<leader>bsi"] = {
  function()
    require("heirline-components.buffer").sort("bufnr")
  end,
  desc = "Sort by buffer number (buffers)",
}
maps.n["<leader>bsm"] = {
  function()
    require("heirline-components.buffer").sort("modified")
  end,
  desc = "Sort by modification (buffers)",
}
maps.n["<leader>b\\"] = {
  function()
    require("heirline-components.all").heirline.buffer_picker(function(bufnr)
      vim.cmd.split()
      vim.api.nvim_win_set_buf(0, bufnr)
    end)
  end,
  desc = "Horizontal split buffer from tabline",
}
maps.n["<leader>b|"] = {
  function()
    require("heirline-components.all").heirline.buffer_picker(function(bufnr)
      vim.cmd.vsplit()
      vim.api.nvim_win_set_buf(0, bufnr)
    end)
  end,
  desc = "Vertical split buffer from tabline",
}

-- For which-key
maps.n["<leader>,"] = { ":WhichKey<CR>", desc = "Which key" }
maps.n["<leader>l"] = icons.l
maps.n["<leader>g"] = icons.g
maps.n["<leader>x"] = icons.x
maps.n["<leader>t"] = icons.t
maps.n["<leader>r"] = icons.r
maps.n["<leader>f"] = icons.f
maps.n["<leader>s"] = icons.s
maps.n["<leader>gn"] = { name = "Neogit" }

-- For telescope
if is_available("telescope.nvim") then
  maps.n["<leader>f"] = icons.f
  maps.n["<leader>gb"] = {
    function()
      require("telescope.builtin").git_branches()
    end,
    desc = "Git branches",
  }

  maps.n["<leader>gc"] = {
    function()
      require("telescope.builtin").git_commits()
    end,
    desc = "Git commits (repository)",
  }
  maps.n["<leader>gC"] = {
    function()
      require("telescope.builtin").git_bcommits()
    end,
    desc = "Git commits (current file)",
  }
  maps.n["<leader>gt"] = {
    function()
      require("telescope.builtin").git_status()
    end,
    desc = "Git status",
  }
  maps.n["<leader>f<CR>"] = {
    function()
      require("telescope.builtin").resume()
    end,
    desc = "Resume previous search",
  }
  maps.n["<leader>f'"] = {
    function()
      require("telescope.builtin").marks()
    end,
    desc = "Find marks",
  }
  maps.n["<leader>fa"] = {
    function()
      local cwd = vim.fn.stdpath("config") .. "/.."
      local search_dirs = { vim.fn.stdpath("config") }
      if #search_dirs == 1 then
        cwd = search_dirs[1]
      end -- if only one directory, focus cwd
      require("telescope.builtin").find_files({
        prompt_title = "Config Files",
        search_dirs = search_dirs,
        cwd = cwd,
        follow = true,
      }) -- call telescope
    end,
    desc = "Find nvim config files",
  }
  maps.n["<leader>fb"] = {
    function()
      require("telescope.builtin").buffers()
    end,
    desc = "Find buffers",
  }
  maps.n["<leader>fw"] = {
    function()
      require("telescope.builtin").grep_string()
    end,
    desc = "Find word under cursor in project",
  }
  maps.n["<leader>fc"] = {
    function()
      require("telescope.builtin").commands()
    end,
    desc = "Find commands",
  }
  maps.n["<leader>fh"] = {
    function()
      require("telescope.builtin").help_tags()
    end,
    desc = "Find help",
  }
  maps.n["<leader>fk"] = {
    function()
      require("telescope.builtin").keymaps()
    end,
    desc = "Find keymaps",
  }
  maps.n["<leader>fm"] = {
    function()
      require("telescope.builtin").man_pages()
    end,
    desc = "Find man",
  }

  if is_available("nvim-notify") then
    maps.n["<leader>fn"] = {
      function()
        require("telescope").extensions.notify.notify()
      end,
      desc = "Find notifications",
    }
  end
  maps.n["<leader>fo"] = {
    function()
      require("telescope.builtin").oldfiles()
    end,
    desc = "Find recent",
  }
  maps.n["<leader>fv"] = {
    function()
      require("telescope.builtin").registers()
    end,
    desc = "Find vim registers",
  }
  maps.n["<leader>ft"] = {
    function()
      -- load color schemes before listing them
      pcall(vim.api.nvim_command, "doautocmd User LoadColorSchemes")

      -- Open telescope
      pcall(require("telescope.builtin").colorscheme, { enable_preview = true })
    end,
    desc = "Find themes",
  }
  maps.n["<leader>ff"] = {
    function()
      require("telescope.builtin").live_grep()
    end,
    desc = "Find words in project",
  }

  maps.n["<leader> "] = {
    function()
      require("telescope.builtin").find_files()
    end,
    desc = "Find file",
  }
  maps.n["<leader>fH"] = {
    function()
      require("telescope.builtin").highlights()
    end,
    desc = "Lists highlights",
  }
  maps.n["<leader>f/"] = {
    function()
      require("telescope.builtin").current_buffer_fuzzy_find()
    end,
    desc = "Find words in current buffer",
  }

  -- Some lsp keymappings are here because they depend on telescope
  maps.n["<leader>l"] = icons.l
  maps.n["<leader>ls"] = {
    function()
      local aerial_avail, _ = pcall(require, "aerial")
      if aerial_avail then
        require("telescope").extensions.aerial.aerial()
      else
        require("telescope.builtin").lsp_document_symbols()
      end
    end,
    desc = "Search symbol in buffer", -- Useful to find every time a variable is assigned.
  }
  maps.n["gs"] = {
    function()
      local aerial_avail, _ = pcall(require, "aerial")
      if aerial_avail then
        require("telescope").extensions.aerial.aerial()
      else
        require("telescope.builtin").lsp_document_symbols()
      end
    end,
    desc = "Search symbol in buffer", -- Useful to find every time a variable is assigned.
  }

  -- extra - project.nvim
  if is_available("project.nvim") then
    maps.n["<leader>fp"] = {
      function()
        vim.cmd("Telescope projects")
      end,
      desc = "Find project",
    }
  end

  -- extra - spectre.nvim (search and replace in project)
  if is_available("nvim-spectre") then
    maps.n["<leader>fr"] = {
      function()
        require("spectre").toggle()
      end,
      desc = "Find and replace word in project",
    }
    maps.n["<leader>fb"] = {
      function()
        require("spectre").toggle({ path = vim.fn.expand("%:t:p") })
      end,
      desc = "Find and replace word in buffer",
    }
  end
  -- extra - luasnip
  if is_available("LuaSnip") and is_available("telescope-luasnip.nvim") then
    maps.n["<leader>fs"] = {
      function()
        require("telescope").extensions.luasnip.luasnip({})
      end,
      desc = "Find snippets",
    }
  end

  -- extra - nvim-neoclip (neovim internal clipboard)
  --         Specially useful if you disable the shared clipboard in options.
  if is_available("nvim-neoclip.lua") then
    maps.n["<leader>fy"] = {
      function()
        require("telescope").extensions.neoclip.default()
      end,
      desc = "Find yank history",
    }
    maps.n["<leader>fq"] = {
      function()
        require("telescope").extensions.macroscope.default()
      end,
      desc = "Find macro history",
    }
  end

  -- extra - undotree
  if is_available("telescope-undo.nvim") then
    maps.n["<leader>fu"] = {
      function()
        require("telescope").extensions.undo.undo()
      end,
      desc = "Find in undo tree",
    }
  end

  -- extra - compiler
  if is_available("compiler.nvim") and is_available("overseer.nvim") then
    maps.n["<leader>m"] = icons.c
    maps.n["<leader>mm"] = {
      function()
        vim.cmd("CompilerOpen")
      end,
      desc = "Open compiler",
    }
    maps.n["<leader>mr"] = {
      function()
        vim.cmd("CompilerRedo")
      end,
      desc = "Compiler redo",
    }
    maps.n["<leader>mt"] = {
      function()
        vim.cmd("CompilerToggleResults")
      end,
      desc = "compiler results",
    }
    maps.n["<F6>"] = {
      function()
        vim.cmd("CompilerOpen")
      end,
      desc = "Open compiler",
    }
    maps.n["<S-F6>"] = {
      function()
        vim.cmd("CompilerRedo")
      end,
      desc = "Compiler redo",
    }
    maps.n["<S-F7>"] = {
      function()
        vim.cmd("CompilerToggleResults")
      end,
      desc = "compiler resume",
    }
    maps.n["<leader>fn"] = {
      function()
        vim.cmd([[Telescope notify]])
      end,
      desc = "Search notify",
    }
  end
end

-- smart-splits.nivm
if is_available("smart-splits.nvim") then
  maps.n["<C-h>"] = {
    function()
      require("smart-splits").move_cursor_left()
    end,
    desc = "Move to left split",
  }
  maps.n["<C-j>"] = {
    function()
      require("smart-splits").move_cursor_down()
    end,
    desc = "Move to below split",
  }
  maps.n["<C-k>"] = {
    function()
      require("smart-splits").move_cursor_up()
    end,
    desc = "Move to above split",
  }
  maps.n["<C-l>"] = {
    function()
      require("smart-splits").move_cursor_right()
    end,
    desc = "Move to right split",
  }
  maps.n["<C-Up>"] = {
    function()
      require("smart-splits").resize_up()
    end,
    desc = "Resize split up",
  }
  maps.n["<C-Down>"] = {
    function()
      require("smart-splits").resize_down()
    end,
    desc = "Resize split down",
  }
  maps.n["<C-Left>"] = {
    function()
      require("smart-splits").resize_left()
    end,
    desc = "Resize split left",
  }
  maps.n["<C-Right>"] = {
    function()
      require("smart-splits").resize_right()
    end,
    desc = "Resize split right",
  }
else
  maps.n["<C-h>"] = { "<C-w>h", desc = "Move to left split" }
  maps.n["<C-j>"] = { "<C-w>j", desc = "Move to below split" }
  maps.n["<C-k>"] = { "<C-w>k", desc = "Move to above split" }
  maps.n["<C-l>"] = { "<C-w>l", desc = "Move to right split" }
  maps.n["<C-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
  maps.n["<C-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
  maps.n["<C-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
  maps.n["<C-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }
end

maps.n["<leader>w"] = icons.w
maps.n["<leader>wp"] = {
  function()
    local winid = require("window-picker").pick_window()
    if winid then
      vim.api.nvim_set_current_win(winid)
    end
  end,
  desc = "Pick window",
}
maps.n["<leader>ww"] = { "<c-w>w", desc = "other window" }
maps.n["<leader>wd"] = { "<c-w>c", desc = "delete window" }
maps.n["<leader>wl"] = { "<c-w>v", desc = "spite window right" }
maps.n["<leader>wj"] = { "<c-w>s", desc = "splite window below" }
maps.n["<leader>wo"] = { "<c-w>o", desc = "only window" }
maps.n["<leader>wx"] = { "<c-w>x", desc = "Swap current with next" }
maps.n["<leader>wf"] = { "<c-w>pa", desc = "switch window" }

maps.n["|"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" }
maps.n["\\"] = { "<cmd>split<cr>", desc = "Horizontal Split" }

maps.n["<leader>ss"] = {
  function()
    require("resession").save()
  end,
  desc = "Session Save",
}
maps.n["<leader>sf"] = {
  function()
    require("resession").load()
  end,
  desc = "Session load",
}
maps.n["<leader>sd"] = {
  function()
    require("resession").delete()
  end,
  desc = "Session delete",
}
maps.n["<leader>sl"] = {
  function()
    require("resession").load("last")
  end,
  desc = "Load last Session",
}
maps.n["<leader>o"] = { "<cmd>Oil<CR>", desc = "Oil" }

-- For package
maps.n["<leader>p"] = icons.p

maps.n["<leader>pl"] = { "<cmd>Lazy<CR>", desc = "Lazy" }

maps.n["<leader>pm"] = { "<cmd>Mason<CR>", desc = "Mason" }

maps.n["<leader><tab>"] = { "<cmd>tabNext<CR>", desc = "Next tab" }


-- For ToggleTerm
maps.n["<Leader>tf"] = { "<Cmd>ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }
maps.n["<Leader>th"] = { "<Cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "ToggleTerm horizontal split" }
maps.n["<Leader>tv"] = { "<Cmd>ToggleTerm size=50 direction=vertical<CR>", desc = "ToggleTerm vertical split" }
maps.n["<Leader>t<tab>"] = { "<Cmd>ToggleTerm  direction=tab<CR>", desc = "ToggleTerm new tab" }
maps.n["<leader>tt"] = { '<Cmd>execute v:count . "ToggleTerm"<CR>', desc = "Toggle terminal" }
maps.n["<F7>"] = { '<Cmd>execute v:count . "ToggleTerm"<CR>', desc = "Toggle terminal" }
maps.t["<F7>"] = { "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" }
maps.i["<F7>"] = { "<Esc><Cmd>ToggleTerm<CR>", desc = "Toggle terminl" }
maps.n["<C-'>"] = { '<Cmd>execute v:count . "ToggleTerm"<CR>', desc = "Toggle terminal" } -- requires terminal that supports binding <C-'>
maps.t["<C-'>"] = { "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" } -- requires terminal that supports binding <C-'>
maps.i["<C-'>"] = { "<Esc><Cmd>ToggleTerm<CR>", desc = "Toggle terminl" } -- requires terminal that supports binding <C-'>

require("utils").set_mappings(maps)
