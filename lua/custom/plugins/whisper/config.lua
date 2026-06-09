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
    poll_interval_ms = 999999, -- Effectively disable auto-polling (use manual trigger only)
    filter_markers = true, -- Remove [BLANK_AUDIO], (beeping), etc.

    -- Use Ctrl+Space instead of Space to avoid double-space bug in insert mode
    -- The plugin has a bug where <Space> gets inserted twice in insert mode
    manual_trigger_key = '<C-Space>',

    -- Override the default keybind notification
    keybind = '<leader>ww',
    notifications = true,

    -- Enable debug logging to troubleshoot duplication
    debug = true,
    debug_file = vim.fn.expand('~/.whisper-debug.log'),
  }

  -- BUGFIX: Complete replacement of manual trigger logic
  -- Root cause: poll_until_text() loops every 500ms and re-reads the SAME lines
  local audio = require('whisper.audio')
  local state = require('whisper.state')
  local insert = require('whisper.insert')

  -- Replace manual_trigger_insertion completely with single-shot logic
  audio.manual_trigger_insertion = function()
    local config = require('whisper.config').get()

    -- Prevent re-entrance
    if state.is_processing() then
      return
    end

    if not state.is_recording() then
      return
    end

    if not config.enable_streaming then
      return
    end

    -- Set processing state
    state.set_processing(true)

    -- Read temp file ONCE
    local temp_file = state.get_temp_file()
    if not temp_file or vim.fn.filereadable(temp_file) ~= 1 then
      state.set_processing(false)
      return
    end

    local ok, lines = pcall(vim.fn.readfile, temp_file)
    if not ok or not lines or #lines == 0 then
      state.set_processing(false)
      vim.notify('No transcription available yet', vim.log.levels.WARN)
      return
    end

    -- Get only NEW lines since last read
    local last_read = state.get_last_read_line()
    local new_lines = {}

    for i = last_read + 1, #lines do
      local line = lines[i]
      if config.filter_markers then
        -- Remove markers
        line = line:gsub('%[.-%]', ''):gsub('%(.-%)', '')
      end
      line = line:match('^%s*(.-)%s*$') or ''
      if line ~= '' then
        table.insert(new_lines, line)
      end
    end

    if #new_lines == 0 then
      state.set_processing(false)
      vim.notify('No new text (silence detected)', vim.log.levels.WARN)
      return
    end

    -- Insert text ONCE
    local text = table.concat(new_lines, ' ')
    insert.insert_text(text)

    -- Update state
    state.set_last_read_line(#lines)
    state.set_processing(false)
  end

  -- Override start_recording to fix keymap and notification
  local original_start_recording = audio.start_recording
  audio.start_recording = function(config)
    -- Call original function
    original_start_recording(config)

    -- Re-bind insert mode keymap with correct behavior (don't return the key)
    local buf = state.get_recording_buffer()
    if buf and vim.api.nvim_buf_is_valid(buf) then
      local trigger_key = config.manual_trigger_key or '<Space>'

      -- Override both normal and insert mode keymaps
      vim.keymap.set('n', trigger_key, function()
        audio.manual_trigger_insertion()
      end, { buffer = buf, desc = 'Insert transcribed text' })

      vim.keymap.set('i', trigger_key, function()
        audio.manual_trigger_insertion()
        return '' -- FIX: Don't return trigger_key which causes recursive triggering
      end, { buffer = buf, expr = true, desc = 'Insert transcribed text' })

      -- Show correct notification
      local display_key = trigger_key:gsub('[<>]', '')
      vim.notify(
        'Recording... (' .. display_key .. '=insert, <leader>ww=stop)',
        vim.log.levels.INFO
      )
    end
  end
end

return M
