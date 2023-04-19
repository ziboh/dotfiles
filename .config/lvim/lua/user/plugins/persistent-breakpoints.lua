return {
  'Weissle/persistent-breakpoints.nvim',
  config = function()
    require('persistent-breakpoints').setup {
      save_dir = vim.fn.stdpath('data') .. '/nvim_checkpoints',
      -- when to load the breakpoints? "BufReadPost" is recommanded.
      load_breakpoints_event = { "BufReadPost" },
      -- record the performance of different function. run :lua require('persistent-breakpoints.api').print_perf_data() to see the result.
      perf_record = false,
    }
  end
}
