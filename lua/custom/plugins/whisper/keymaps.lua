local M = {}

function M.setup()
  local override = require('custom.plugins.whisper.audio_override')

  -- Toggle recording on/off
  vim.keymap.set('n', '<leader>ww', function()
    local whisper = require 'whisper'
    local state = require 'whisper.state'

    if state.is_recording() then
      whisper.toggle()
      override.reset_state() -- Reset cumulative tracking on stop
    else
      override.reset_state() -- Reset cumulative tracking on start
      whisper.toggle()
    end
  end, { desc = '[W]hisper toggle recording' })

  -- Manually trigger transcription insertion using our override
  vim.keymap.set('n', '<leader>wi', function()
    override.manual_trigger_insertion()
  end, { desc = '[W]hisper [I]nsert transcription' })

  -- Primary manual trigger (,ws) - uses our cumulative-aware override
  vim.keymap.set('n', '<leader>ws', function()
    override.manual_trigger_insertion()
  end, { desc = '[W]hisper in[S]ert (manual trigger)' })

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
