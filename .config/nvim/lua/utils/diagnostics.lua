local M = {}
M.diagnostics = {
  -- diagnostics off
  [0] = vim.tbl_deep_extend(
    "force",
    vim.g.diagnostics_config,
    { underline = false, virtual_text = false, signs = false, update_in_insert = false }
  ) --[[@as vim.diagnostic.Opts]],
  -- status only
  vim.tbl_deep_extend("force", vim.g.diagnostics_config, { virtual_text = false, signs = false }),
  -- virtual text off, signs on
  vim.tbl_deep_extend("force", vim.g.diagnostics_config, { virtual_text = false }),
  -- all diagnostics on
  vim.g.diagnostics_config,
}

return M
