return {
  "p00f/clangd_extensions.nvim",
  after = "mason-lspconfig.nvim",   -- make sure to load after mason-lspconfig
  config = function()
    local provider = "clangd"
    local clangd_flags = {
      -- 在后台自动分析文件（基于complie_commands)
      "--compile-commands-dir=build",
      "--background-index",
      "--completion-style=detailed",
      -- 同时开启的任务数量
      "--all-scopes-completion=true",
      "--recovery-ast",
      "--suggest-missing-includes",
      -- 告诉clangd用那个clang进行编译，路径参考which clang++的路径
      "--query-driver=/usr/locla/bin/clang++,/usr/bin/g++",
      "--clang-tidy",
      -- 全局补全（会自动补充头文件）
      "--all-scopes-completion",
      "--cross-file-rename",
      -- 更详细的补全内容
      "--completion-style=detailed",
      "--function-arg-placeholders=false",
      -- 补充头文件的形式
      "--header-insertion=never",
      -- pch优化的位置
      "--pch-storage=memory",
      "--offset-encoding=utf-16",
      "-j=12",
    }

    local custom_on_attach = function(client, bufnr)
      require("lvim.lsp").common_on_attach(client, bufnr)
      require("clangd_extensions.inlay_hints").setup_autocmd()
      require("clangd_extensions.inlay_hints").set_inlay_hints()
    end


    local custom_on_init = function(client, bufnr)
      require("lvim.lsp").common_on_init(client, bufnr)
      require("clangd_extensions.config").setup {}
      require("clangd_extensions.ast").init()
      vim.cmd [[
              command ClangdToggleInlayHints lua require('clangd_extensions.inlay_hints').toggle_inlay_hints()
              command -range ClangdAST lua require('clangd_extensions.ast').display_ast(<line1>, <line2>)
              command ClangdTypeHierarchy lua require('clangd_extensions.type_hierarchy').show_hierarchy()
              command ClangdSymbolInfo lua require('clangd_extensions.symbol_info').show_symbol_info()
              command -nargs=? -complete=customlist,s:memuse_compl ClangdMemoryUsage lua require('clangd_extensions.memory_usage').show_memory_usage('<args>' == 'expand_preamble')
              ]]
    end

    local opts = {
      cmd = { provider, unpack(clangd_flags) },
      on_attach = custom_on_attach,
      on_init = custom_on_init,
    }

    require("lvim.lsp.manager").setup("clangd", opts)
  end
}
