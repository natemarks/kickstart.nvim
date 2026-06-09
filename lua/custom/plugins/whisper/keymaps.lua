local M = {}

function M.setup()
  -- Simple keymapping for automatic timer-based insertion
  -- Text appears automatically every 5 seconds while recording

  -- Toggle recording on/off
  vim.keymap.set('n', '<leader>ww', function()
    local whisper = require 'whisper'
    whisper.toggle()
  end, { desc = '[W]hisper toggle recording' })

  -- Alternative: keep original keybinds if you prefer
  -- Uncomment these if you want both leader and Ctrl keymaps:
  --
  -- vim.keymap.set('n', '<C-g>', function()
  --   local whisper = require('whisper')
  --   if whisper.is_recording and whisper.is_recording() then
  --     whisper.stop()
  --   else
  --     whisper.start()
  --   end
  -- end, { desc = 'Whisper: toggle recording' })
  --
  -- vim.keymap.set('n', '<Space>', function()
  --   require('whisper').insert_transcription()
  -- end, { desc = 'Whisper: insert transcription' })
end

return M
