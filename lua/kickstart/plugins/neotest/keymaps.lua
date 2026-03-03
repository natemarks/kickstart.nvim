local M = {}

function M.setup()
  local nt = require 'neotest'

  vim.keymap.set('n', '<leader>xt', function()
    nt.run.run()
  end, { desc = 'Run nearest test' })

  vim.keymap.set('n', '<leader>xs', function()
    nt.run.stop()
  end, { desc = 'Stop nearest test' })

  vim.keymap.set('n', '<leader>xd', function()
    nt.run.run { strategy = 'dap' }
  end, { desc = 'Debug nearest test' })

  vim.keymap.set('n', '<leader>xf', function()
    nt.run.run(vim.fn.expand '%')
  end, { desc = 'Run tests in file' })

  vim.keymap.set('n', '<leader>xS', function()
    nt.summary.toggle()
  end, { desc = 'Toggle test summary' })

  vim.keymap.set('n', '<leader>xO', function()
    nt.output_panel.toggle()
  end, { desc = 'Toggle test output panel' })

  vim.keymap.set('n', '<leader>xo', function()
    nt.output.open { enter = true, auto_close = true }
  end, { desc = 'Open nearest test output' })
end

return M
