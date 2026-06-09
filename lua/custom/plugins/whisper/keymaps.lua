local M = {}

function M.setup()
  -- Override whisper.audio with our fixed version
  package.loaded['whisper.audio'] = require('custom.plugins.whisper.audio_override')

  -- Override the default <C-g> keymaps with leader-based ones
  -- to avoid conflicts with Vim's built-in Ctrl-g (show file info)

  -- Toggle recording on/off
  vim.keymap.set('n', '<leader>ww', function()
    -- Use our overridden audio module
    local audio = require 'whisper.audio'
    local config = require('whisper.config').get()
    if require('whisper.state').is_recording() then
      audio.stop_recording()
    else
      audio.start_recording(config)
    end
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
