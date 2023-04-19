return {
  {
    "rmagatti/auto-session",
    enabled = true,
    opts = {
      log_level = "error",
      auto_session_enable_last_session = true,
      auto_session_root_dir = vim.fn.stdpath("cache") .. "/auto_sessions/",
      auto_session_enabled = true,
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_suppress_dirs = { "/home/zibo" },
      auto_session_use_git_branch = nil,
      -- the configs below are lua only
      bypass_session_save_file_types = nil,
      pre_save_cmds = {
        function()
          require("user.utils").delete_from_ft("checkhealth")
          require("user.utils").delete_from_ft("")
        end,
      },
    },
  },
  {
    "rmagatti/session-lens",
    dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    enabled = true,
    config = function()
      require("session-lens").setup({
        path_display = { "shorten" },
        theme = "dropdown", -- default is dropdown
        theme_conf = { border = true },
        previewer = true,
        prompt_title = "SESSIONS",
      })
    end,
  },
}
