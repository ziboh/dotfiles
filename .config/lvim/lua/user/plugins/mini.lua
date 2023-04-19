return {
  'echasnovski/mini.nvim',
  enable = false,
  config = function()
    require('mini.bufremove').setup()
  end
}
