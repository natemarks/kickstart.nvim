local luasnip_config = require 'kickstart.plugins.completion.luasnip'

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      build = luasnip_config.build(),
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            luasnip_config.load_friendly_snippets()
          end,
        },
      },
    },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
  },
  config = function()
    luasnip_config.setup()
    require('kickstart.plugins.completion.cmp').setup()
  end,
}
