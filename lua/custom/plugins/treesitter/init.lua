return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false, -- main does not support lazy-loading
  build = ':TSUpdate',
  config = function()
    require('custom.plugins.treesitter.config').setup()
  end,
}
