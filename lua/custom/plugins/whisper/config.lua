local M = {}

function M.setup()
  local whisper = require 'whisper'
  whisper.setup {
    -- Point to your downloaded model from whisper.cpp build
    model_path = vim.fn.expand '~/whisper.cpp/models/ggml-base.en.bin',

    -- Alternative smaller/faster model:
    -- model_path = vim.fn.expand('~/whisper.cpp/models/ggml-tiny.en.bin'),

    -- Alternative larger/more accurate model:
    -- model_path = vim.fn.expand('~/whisper.cpp/models/ggml-small.en.bin'),

    -- Whisper processing parameters
    step_ms = 5000, -- Process audio every 5 seconds
    length_ms = 30000, -- Keep 30 seconds of audio in buffer (critical for non-streaming!)
    vad_thold = 0.6, -- Voice activity detection threshold (0.0-1.0)
    language = 'en',
    threads = 4,

    -- ALTERNATIVE 2: Non-streaming mode (current configuration)
    -- Speak everything, then text appears all at once when you stop recording
    -- This avoids duplication issues with whisper-stream's cumulative output
    enable_streaming = false,
    filter_markers = true, -- Remove [BLANK_AUDIO], (beeping), etc.

    -- ALTERNATIVE 1: Automatic timer-based insertion (NOT recommended - causes duplication)
    -- whisper-stream writes cumulative output, causing text to duplicate with polling
    -- To use Alternative 1 (at your own risk):
    -- enable_streaming = true,
    -- poll_interval_ms = 5000,
  }

  -- Override: Prevent trigger key insertion in insert mode
  -- This patches the audio module after whisper.setup() has run
  local audio = require 'whisper.audio'
  if audio and audio.start_recording then
    local original_start_recording = audio.start_recording
    audio.start_recording = function(config)
      original_start_recording(config)

      -- Re-map the insert mode trigger to not insert the key
      if config and config.trigger_key then
        local trigger_key = config.trigger_key
        -- Find the current buffer
        local buf = vim.api.nvim_get_current_buf()
        -- Override the insert mode mapping
        vim.keymap.set('i', trigger_key, function()
          require('whisper.audio').manual_trigger_insertion()
          return '' -- Don't insert the trigger key
        end, { buffer = buf, expr = true, desc = 'Whisper: manual trigger (no key insertion)' })
      end
    end
  end
end

return M
