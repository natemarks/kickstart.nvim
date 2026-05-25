return {
  'Avi-D-coder/whisper.nvim',
  -- Only load when explicitly called (lazy loading)
  cmd = { 'WhisperStart', 'WhisperStop', 'WhisperToggle' },
  keys = {
    { '<leader>w', desc = '+whisper' },
  },
  config = function()
    require('custom.plugins.whisper.config').setup()
    require('custom.plugins.whisper.keymaps').setup()
  end,
}
