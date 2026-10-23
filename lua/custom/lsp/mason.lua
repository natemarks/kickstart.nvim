local M = {}

function M.setup(servers, capabilities)
  require('mason').setup()

  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, require('custom.lsp.tools').get())
  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  -- mason-lspconfig v2 dropped `handlers`; settings go through Neovim's native
  -- vim.lsp.config, which merges over nvim-lspconfig's lsp/<name>.lua defaults
  vim.lsp.config('*', { capabilities = capabilities })
  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
  end

  require('mason-lspconfig').setup {
    -- only our servers; keeps tools like stylua from starting as LSP clients
    automatic_enable = vim.tbl_keys(servers),
  }
end

return M
