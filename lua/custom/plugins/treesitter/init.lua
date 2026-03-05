return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('custom.plugins.treesitter.config').setup()
  end,
}
