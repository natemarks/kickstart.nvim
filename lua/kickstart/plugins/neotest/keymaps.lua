local M = {}

function M.setup()
  local nt = require 'neotest'

  vim.keymap.set('n', '<leader>xt', function()
    nt.run.run()
  end, { desc = 'Run nearest test' })

  vim.keymap.set('n', '<leader>xs', function()
    nt.run.run()
  end, { desc = 'Stop nearest test' })

  vim.keymap.set('n', '<leader>xd', function()
    nt.run.run { strategy = 'dap' }
  end, { desc = 'Debug nearest test' })

  vim.keymap.set('n', '<leader>xf', function()
    nt.run.run(vim.fn.expand '%')
  end, { desc = 'Run tests in file' })
end

return M
