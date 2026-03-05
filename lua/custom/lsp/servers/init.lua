local M = {}

function M.get()
  local servers = {}

  local modules = {
    require 'custom.lsp.servers.go',
    require 'custom.lsp.servers.python',
    require 'custom.lsp.servers.lua',
  }

  for _, module in ipairs(modules) do
    servers = vim.tbl_deep_extend('force', servers, module.get())
  end

  return servers
end

return M
