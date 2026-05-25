local M = {}

function M.setup()
  -- Override the default <C-g> keymaps with leader-based ones
  -- to avoid conflicts with Vim's built-in Ctrl-g (show file info)

  -- Toggle recording on/off
  vim.keymap.set('n', '<leader>ww', function()
    -- Use whisper.nvim's toggle function
    local whisper = require 'whisper'
    whisper.toggle()
  end, { desc = '[W]hisper toggle recording' })

  -- Manually trigger transcription insertion (while recording)
  vim.keymap.set('n', '<leader>wi', function()
    local audio = require 'whisper.audio'
    audio.manual_trigger_insertion()
  end, { desc = '[W]hisper [I]nsert transcription' })

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
