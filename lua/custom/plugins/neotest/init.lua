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
    require('custom.plugins.neotest.config').setup()
    require('custom.plugins.neotest.keymaps').setup()
  end,
}
