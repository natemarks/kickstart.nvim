local M = {}

function M.setup()
  require('custom.luasnip.config').setup()
  require('custom.luasnip.snippets.python').register()
end

return M