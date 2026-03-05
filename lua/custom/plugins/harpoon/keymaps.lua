local M = {}

function M.setup()
  local wk = require 'which-key'

  wk.add {
    { '<leader>m', group = 'Harpoon [M]ark' },
    { '<leader>ma', require('harpoon.mark').add_file, desc = 'Add File', mode = 'n' },
    { '<leader>mm', require('harpoon.ui').toggle_quick_menu, desc = 'Show UI', mode = 'n' },
    {
      '<leader>m1',
      function()
        require('harpoon.ui').nav_file(1)
      end,
      desc = 'Harpoon:1',
      mode = 'n',
    },
    {
      '<leader>m2',
      function()
        require('harpoon.ui').nav_file(2)
      end,
      desc = 'Harpoon:2',
      mode = 'n',
    },
    {
      '<leader>m3',
      function()
        require('harpoon.ui').nav_file(3)
      end,
      desc = 'Harpoon:3',
      mode = 'n',
    },
    {
      '<leader>m4',
      function()
        require('harpoon.ui').nav_file(4)
      end,
      desc = 'Harpoon:4',
      mode = 'n',
    },
    {
      '<leader>m5',
      function()
        require('harpoon.ui').nav_file(5)
      end,
      desc = 'Harpoon:5',
      mode = 'n',
    },
    {
      '<leader>m6',
      function()
        require('harpoon.ui').nav_file(6)
      end,
      desc = 'Harpoon:6',
      mode = 'n',
    },
    {
      '<leader>m7',
      function()
        require('harpoon.ui').nav_file(7)
      end,
      desc = 'Harpoon:7',
      mode = 'n',
    },
    {
      '<leader>m8',
      function()
        require('harpoon.ui').nav_file(8)
      end,
      desc = 'Harpoon:8',
      mode = 'n',
    },
    {
      '<leader>m9',
      function()
        require('harpoon.ui').nav_file(9)
      end,
      desc = 'Harpoon:9',
      mode = 'n',
    },
  }
end

return M
