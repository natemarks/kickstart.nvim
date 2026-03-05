local M = {}

function M.add(bufnr, has_inlay_hints)
  local wk = require 'which-key'

  local spec = {
    { 'gd', desc = 'LSP: [G]oto [D]efinition', buffer = bufnr },
    { 'gr', desc = 'LSP: [G]oto [R]eferences', buffer = bufnr },
    { 'gI', desc = 'LSP: [G]oto [I]mplementation', buffer = bufnr },
    { 'gD', desc = 'LSP: [G]oto [D]eclaration', buffer = bufnr },
    { '<leader>D', desc = 'LSP: Type [D]efinition', buffer = bufnr },
    { '<leader>ds', desc = 'LSP: [D]ocument [S]ymbols', buffer = bufnr },
    { '<leader>ws', desc = 'LSP: [W]orkspace [S]ymbols', buffer = bufnr },
    { '<leader>rn', desc = 'LSP: [R]e[n]ame', buffer = bufnr },
    { '<leader>ca', desc = 'LSP: [C]ode [A]ction', mode = { 'n', 'x' }, buffer = bufnr },
  }

  if has_inlay_hints then
    table.insert(spec, { '<leader>th', desc = 'LSP: [T]oggle Inlay [H]ints', buffer = bufnr })
  end

  wk.add(spec)
end

return M
