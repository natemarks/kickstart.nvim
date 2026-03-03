local M = {}

local data_site_path = vim.fn.stdpath 'data' .. '/site/'

M.opts = {
  ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'python', 'query', 'vim', 'vimdoc' },
  parser_install_dir = data_site_path,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { 'ruby' },
  },
  indent = { enable = true, disable = { 'ruby' } },
}

function M.setup()
  require('nvim-treesitter').setup(M.opts)
end

return M
