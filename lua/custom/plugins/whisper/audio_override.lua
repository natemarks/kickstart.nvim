-- Wrapper for whisper.nvim that tracks cumulative transcription state
-- Problem: whisper-stream writes cumulative output (each line contains all previous text)
-- Solution: Track what we've already inserted and only insert the delta

local M = {}

-- Store the cumulative text we've seen across this recording session
local cumulative_text = ""

-- Get the original audio module
local function get_original_audio()
  return require('whisper.audio')
end

-- Custom poll function that handles cumulative transcription
local function poll_with_cumulative_tracking(config)
  local state = require('whisper.state')
  local audio = get_original_audio()

  local temp_file = state.get_temp_file()
  if not temp_file then
    return false -- No text found
  end

  local readable = vim.fn.filereadable(temp_file)
  if readable ~= 1 then
    return false
  end

  -- Read all lines
  local ok, lines = pcall(vim.fn.readfile, temp_file)
  if not ok or not lines or #lines == 0 then
    return false
  end

  -- Get the LAST line only (most recent cumulative transcription)
  local current_text = lines[#lines]

  -- Apply filtering
  if config.filter_markers then
    current_text = audio.filter_text(current_text)
  else
    current_text = current_text:match('^%s*(.-)%s*$') or ''
  end

  -- Check if we have new text
  if current_text == '' or current_text == cumulative_text then
    state.set_last_read_line(#lines)
    return false -- No new text
  end

  -- Calculate what's new
  local new_text = current_text
  if cumulative_text ~= "" then
    -- Check if current starts with previous (it should for cumulative output)
    if vim.startswith(current_text, cumulative_text) then
      new_text = current_text:sub(#cumulative_text + 1)
      new_text = new_text:match('^%s*(.-)%s*$') or ''
    end
  end

  if new_text ~= '' then
    audio.insert_streaming_text(new_text)
    cumulative_text = current_text
    state.set_last_read_line(#lines)
    return true -- Text was inserted
  end

  state.set_last_read_line(#lines)
  return false
end

-- Custom manual trigger that uses our polling
M.manual_trigger_insertion = function()
  local config = require('whisper.config').get()
  local state = require('whisper.state')

  if not state.is_recording() then
    return
  end

  if not config.enable_streaming then
    return
  end

  state.set_processing(true)
  if config.notifications then
    vim.cmd('echohl WarningMsg | echo "Processing..." | echohl None')
  end

  local poll_count = 0
  local max_polls = 30

  local function poll_until_text()
    poll_count = poll_count + 1
    local found_text = poll_with_cumulative_tracking(config)

    if found_text then
      state.set_processing(false)
      if config.notifications then
        vim.cmd('echo ""')
      end
    elseif poll_count < max_polls then
      vim.defer_fn(poll_until_text, 500)
    else
      state.set_processing(false)
      if config.notifications then
        vim.cmd('echohl WarningMsg | echo "No new transcription" | echohl None')
        vim.defer_fn(function() vim.cmd('echo ""') end, 2000)
      end
    end
  end

  poll_until_text()
end

-- Reset tracking when recording starts/stops
M.reset_state = function()
  cumulative_text = ""
end

return M
