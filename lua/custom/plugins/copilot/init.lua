return {
  'github/copilot.vim',
  event = 'InsertEnter',
  cmd = { 'Copilot' },
  init = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true

    vim.keymap.set('i', '<M-l>', 'copilot#Accept("")', {
      expr = true,
      replace_keycodes = false,
      desc = 'Copilot: Accept suggestion',
    })
    vim.keymap.set('i', '<M-.>', '<Plug>(copilot-next)', { remap = true, silent = true, desc = 'Copilot: Next suggestion' })
    vim.keymap.set('i', '<M-,>', '<Plug>(copilot-previous)', { remap = true, silent = true, desc = 'Copilot: Previous suggestion' })
    vim.keymap.set('i', '<M-;>', '<Plug>(copilot-dismiss)', { remap = true, silent = true, desc = 'Copilot: Dismiss suggestion' })
  end,
}
