local M = {}

M.opts = {
  ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { 'ruby' },
  },
  indent = { enable = true, disable = { 'ruby' } },
}

local function ensure_data_site_in_rtp()
  local data_site_path = vim.fn.stdpath 'data' .. '/site'
  if not vim.tbl_contains(vim.opt.rtp:get(), data_site_path) then
    vim.opt.rtp:append(data_site_path)
  end
end

function M.setup()
  ensure_data_site_in_rtp()
  require('nvim-treesitter').setup(M.opts)
end

return M
