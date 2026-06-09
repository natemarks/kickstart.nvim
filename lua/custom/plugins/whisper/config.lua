local M = {}

-- Debug command to check keymaps
vim.api.nvim_create_user_command('WhisperDebugKeymaps', function()
  local state = require('whisper.state')
  local buf = state.get_recording_buffer()
  if not buf then
    print('Not recording')
    return
  end

  print('Buffer: ' .. buf)
  print('Is recording: ' .. tostring(state.is_recording()))

  -- Check <C-Space> keymap
  local n_map = vim.fn.maparg('<C-Space>', 'n', false, true)
  local i_map = vim.fn.maparg('<C-Space>', 'i', false, true)

  print('\nNormal mode <C-Space>:')
  print(vim.inspect(n_map))

  print('\nInsert mode <C-Space>:')
  print(vim.inspect(i_map))
end, {})

function M.setup()
  -- BUGFIX: Replace manual_trigger_insertion BEFORE setup runs
  -- This ensures the plugin's keymap captures our fixed function
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

  -- Now run setup with our fixed function already in place
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

  -- Override start_recording to show correct notification
  local original_start_recording = audio.start_recording
  audio.start_recording = function(config)
    -- Call original function (which now uses our fixed manual_trigger_insertion)
    original_start_recording(config)

    -- Show correct notification after a brief delay
    vim.schedule(function()
      local trigger_key = config.manual_trigger_key or '<C-Space>'
      local display_key = trigger_key:gsub('[<>]', '')
      vim.notify(
        'Recording... (' .. display_key .. '=insert, <leader>ww=stop)',
        vim.log.levels.INFO
      )
    end)
  end
end

return M
