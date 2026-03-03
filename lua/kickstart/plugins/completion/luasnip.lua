local M = {}

function M.build()
  if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
    return
  end
  return 'make install_jsregexp'
end

function M.setup()
  require('luasnip').config.setup {}
end

function M.load_friendly_snippets()
  require('luasnip.loaders.from_vscode').lazy_load()
end

return M
