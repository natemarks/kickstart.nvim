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

    -- Streaming configuration (v0.1.1+)
    enable_streaming = true, -- Enable streaming for manual trigger support
    poll_interval_ms = 999999, -- Disable auto-polling (manual only)
    filter_markers = true, -- Remove [BLANK_AUDIO], etc.
    manual_trigger_key = '<F99>', -- Set to unused key - we'll handle keybindings ourselves

    -- Debug settings (keep for troubleshooting)
    debug = false,
    debug_file = '/tmp/whisper-debug.log',
  }
end

return M
