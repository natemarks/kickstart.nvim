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
    vad_thold = 0.6, -- Voice activity detection threshold (0.0-1.0)
    language = 'en',
    threads = 4,

    -- ALTERNATIVE 1: Automatic timer-based insertion (current configuration)
    -- Text automatically appears every 5 seconds while recording
    enable_streaming = true,
    poll_interval_ms = 5000, -- Auto-insert every 5 seconds (matches step_ms)
    filter_markers = true, -- Remove [BLANK_AUDIO], (beeping), etc.

    -- ALTERNATIVE 2: Non-streaming mode (insert all at once when stopping)
    -- To use Alternative 2, change enable_streaming to false:
    -- enable_streaming = false,
  }
end

return M
