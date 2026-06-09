local M = {}

function M.setup()
  require('whisper').setup {
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
end

return M
