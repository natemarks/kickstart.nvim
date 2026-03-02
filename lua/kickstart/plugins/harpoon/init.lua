return {
  'ThePrimeagen/harpoon',
  branch = 'master',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = require('kickstart.plugins.harpoon.config').opts,
  config = function()
    require('kickstart.plugins.harpoon.config').setup()
    require('kickstart.plugins.harpoon.keymaps').setup()
  end,
}
