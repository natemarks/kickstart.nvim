return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('kickstart.plugins.treesitter.config').setup()
  end,
}
