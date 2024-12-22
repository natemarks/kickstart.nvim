M = {}
-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
local ls = require 'luasnip'
local types = require 'luasnip.util.types'
ls.config.set_config {
  history = true,
  updateevents = 'TextChanged,TextChangedI',
  -- enable_autosnippets = true,
  -- ext_opts = nil,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { '<-', 'Error' } },
      },
    },
  },
}
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require('luasnip.extras').lambda
local rep = require('luasnip.extras').rep
local p = require('luasnip.extras').partial
local m = require('luasnip.extras').match
local n = require('luasnip.extras').nonempty
local dl = require('luasnip.extras').dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local conds = require 'luasnip.extras.conditions'
local conds_expand = require 'luasnip.extras.conditions.expand'

ls.add_snippets('python', {
  s('pyt', {
    t {
      '@pytest.mark.unit',
      '@pytest.mark.parametrize(',
      '    "',
    },
    i(1, "config_dir"),
    t{
      '",',
      '    [',
      '        pytest.param("config/sandbox/rel1977_1", id="sandbox_actual"),',
      '    ],',
      ')',
      'def ',
    },
    i(2, "test_app_vpc_stack"),
  }),
})
return M
