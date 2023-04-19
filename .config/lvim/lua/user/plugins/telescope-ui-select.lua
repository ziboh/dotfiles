return {
  "nvim-telescope/telescope-ui-select.nvim",
  init = function()
    ---@diognostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      require "lazy".load { plugins = { 'telescope-ui-select.nvim' } }
      return vim.ui.select(...)
    end
  end,
  lazy = true,
  config = function()
    require("telescope").load_extension("ui-select")
  end,
}
