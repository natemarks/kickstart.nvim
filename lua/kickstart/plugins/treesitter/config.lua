local M = {}

local data_site_path = vim.fn.stdpath 'data' .. '/site/'

-- Fresh deploys may occasionally start before all parsers are present.
-- This guard installs python automatically when missing so neotest discovery
-- works without manual `:TSInstall python`.
-- If you hit the same issue for other languages, add similar checks below
-- (for example parser/<lang>.so + `:TSInstall <lang>`).
local function ensure_python_parser_installed()
  local parser_paths = vim.api.nvim_get_runtime_file('parser/python.so', true)
  if #parser_paths > 0 then
    return
  end

  if vim.fn.exists ':TSInstall' == 2 then
    vim.schedule(function()
      vim.notify('Treesitter python parser missing; running :TSInstall python', vim.log.levels.INFO)
      vim.cmd 'silent! TSInstall python'
    end)
  end
end

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
  ensure_python_parser_installed()
end

return M
