local M = {}

function M.setup()
  local core = require 'kickstart.lsp.core'
  local servers = require('kickstart.lsp.servers').get()
  local capabilities = core.get_capabilities()

  core.setup_on_attach()
  require('kickstart.lsp.mason').setup(servers, capabilities)
end

return M
