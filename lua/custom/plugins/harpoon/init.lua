return {
  'ThePrimeagen/harpoon',
  branch = 'master',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = require('custom.plugins.harpoon.config').opts,
  config = function()
    require('custom.plugins.harpoon.config').setup()
    require('custom.plugins.harpoon.keymaps').setup()
  end,
}
