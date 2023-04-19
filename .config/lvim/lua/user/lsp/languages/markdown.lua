require("lvim.lsp.manager").setup("marksman", {
  settings = {
    cmd = { "marksman", "server" },
    filetypes = { "markdown" },
    single_file_support = true,
  },
})
