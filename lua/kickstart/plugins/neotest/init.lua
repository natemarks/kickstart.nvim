return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-go',
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-plenary',
  },
  config = function()
    require('kickstart.plugins.neotest.config').setup()
    require('kickstart.plugins.neotest.keymaps').setup()
  end,
}
