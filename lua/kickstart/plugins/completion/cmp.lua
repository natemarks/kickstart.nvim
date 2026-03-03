local M = {}

function M.setup()
  local cmp = require 'cmp'
  local luasnip = require 'luasnip'

  local function copilot_visible()
    return vim.fn.exists '*copilot#Visible' == 1 and vim.fn['copilot#Visible']() == 1
  end

  local function copilot_accept()
    local ok, accepted = pcall(vim.fn['copilot#Accept'], '')
    if not ok or not accepted then
      return false
    end

    vim.api.nvim_feedkeys(accepted, 'i', true)
    return true
  end

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    completion = { completeopt = 'menu,menuone,noinsert' },
    mapping = cmp.mapping.preset.insert {
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-y>'] = cmp.mapping(function(fallback)
        if copilot_visible() and copilot_accept() then
          return
        end

        if cmp.visible() then
          cmp.confirm { select = true }
          return
        end

        fallback()
      end, { 'i' }),
      ['<CR>'] = cmp.mapping.confirm { select = true },
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<C-Space>'] = cmp.mapping.complete {},
      ['<C-l>'] = cmp.mapping(function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { 'i', 's' }),
      ['<C-h>'] = cmp.mapping(function()
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { 'i', 's' }),
    },
    sources = {
      {
        name = 'lazydev',
        group_index = 0,
      },
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
    },
  }
end

return M
