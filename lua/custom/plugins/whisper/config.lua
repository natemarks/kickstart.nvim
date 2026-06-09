local M = {}

function M.setup()
  require('whisper').setup {
    -- Point to your downloaded model from whisper.cpp build
    -- Adjust this path to match where you cloned whisper.cpp
    model_path = vim.fn.expand '~/whisper.cpp/models/ggml-base.en.bin',

    -- Alternative smaller/faster model:
    -- model_path = vim.fn.expand('~/whisper.cpp/models/ggml-tiny.en.bin'),

    -- Alternative larger/more accurate model:
    -- model_path = vim.fn.expand('~/whisper.cpp/models/ggml-small.en.bin'),

    -- Performance tuning: 5s is more responsive than default 20s
    step_ms = 5000,

    -- Voice activity detection threshold (0.0-1.0)
    -- Higher = more aggressive filtering of silence
    vad_thold = 0.6,

    -- Language (default is auto-detect)
    language = 'en',

    -- Number of threads to use
    threads = 4,

    -- Streaming configuration (real-time transcription)
    enable_streaming = true,
    poll_interval_ms = 5000, -- Match step_ms for consistency
    filter_markers = true, -- Remove [BLANK_AUDIO], (beeping), etc.

    -- Use Ctrl+Space instead of Space to avoid double-space bug in insert mode
    -- The plugin has a bug where <Space> gets inserted twice in insert mode
    manual_trigger_key = '<C-Space>',
  }

  -- BUGFIX: Override the plugin's buggy keymap setup to prevent duplicate insertions
  -- The upstream plugin returns trigger_key in insert mode expr mapping, causing infinite recursion
  local audio = require('whisper.audio')
  local original_start_recording = audio.start_recording

  audio.start_recording = function(config)
    -- Call original function
    original_start_recording(config)

    -- Re-bind insert mode keymap with correct behavior (don't return the key)
    local state = require('whisper.state')
    local buf = state.get_recording_buffer()
    if buf and vim.api.nvim_buf_is_valid(buf) then
      local trigger_key = config.manual_trigger_key or '<Space>'
      -- Override insert mode keymap to return empty string instead of trigger_key
      vim.keymap.set('i', trigger_key, function()
        audio.manual_trigger_insertion()
        return '' -- FIX: Don't return trigger_key which causes recursive triggering
      end, { buffer = buf, expr = true, desc = 'Insert transcribed text' })
    end
  end
end

return M
