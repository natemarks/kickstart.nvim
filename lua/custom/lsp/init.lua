local M = {}

function M.setup()
  local core = require 'custom.lsp.core'
  local servers = require('custom.lsp.servers').get()
  local capabilities = core.get_capabilities()

  core.setup_on_attach()
  require('custom.lsp.mason').setup(servers, capabilities)
end

return M
