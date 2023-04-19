lvim.lsp.installer.setup.automatic_installation = false
---@diagnostic disable-next-line: param-type-mismatch
for _, plugin in ipairs(vim.fn.globpath("~/.config/lvim/lua/user/lsp/languages", "*.lua", 0, 1)) do
  require("user.lsp.languages." .. plugin:match("([^/]+)%.lua$"))
end

lvim.lsp.null_ls.setup.on_init = function(new_client, _)
  new_client.offset_encoding = "utf-16"
end

