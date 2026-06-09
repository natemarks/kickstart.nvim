-- Override for whisper.nvim audio.lua to fix cumulative transcription issue
-- This assumes whisper-stream writes cumulative output (each line contains all text so far)

local M = {}
local original_audio = require('whisper.audio')

-- Store the last inserted text to detect what's new
local last_text = ""

-- Override the poll function to only read the LAST line (most recent cumulative output)
M.poll_transcription_file = function(config)
  local state = require('whisper.state')

  local temp_file = state.get_temp_file()
  if not temp_file then
    return
  end

  local readable = vim.fn.filereadable(temp_file)
  if readable ~= 1 then
    return
  end

  -- Read all lines
  local ok, lines = pcall(vim.fn.readfile, temp_file)
  if not ok or not lines or #lines == 0 then
    return
  end

  -- Get the LAST line only (cumulative transcription)
  local current_text = lines[#lines]

  if config.filter_markers then
    current_text = original_audio.filter_text(current_text)
  else
    current_text = current_text:match('^%s*(.-)%s*$') or ''
  end

  -- Only insert if there's new text beyond what we've already inserted
  if current_text ~= '' and current_text ~= last_text then
    -- Calculate the diff (new text only)
    local new_text = current_text
    if last_text ~= "" and vim.startswith(current_text, last_text) then
      -- Current text starts with last text, so extract only the new part
      new_text = current_text:sub(#last_text + 1)
      -- Trim leading whitespace from the new part
      new_text = new_text:match('^%s*(.-)%s*$') or ''
    end

    if new_text ~= '' then
      original_audio.insert_streaming_text(new_text)
      last_text = current_text
    end
  end

  -- Update line tracking (even though we only read the last line)
  state.set_last_read_line(#lines)
end

-- Override the manual trigger to use our poll function
M.manual_trigger_insertion = function()
  local config = require('whisper.config').get()
  local state = require('whisper.state')

  if state.is_recording() then
    if config.enable_streaming then
      state.set_processing(true)

      if config.notifications then
        vim.cmd('echohl WarningMsg | echo "Processing..." | echohl None')
      end

      local poll_count = 0
      local max_polls = 30
      local text_found = false

      local function poll_until_text()
        poll_count = poll_count + 1
        local before_text = last_text
        M.poll_transcription_file(config)

        if last_text ~= before_text then
          -- New text found!
          text_found = true
          state.set_processing(false)
          if config.notifications then
            vim.cmd('echo ""')
          end
        elseif poll_count < max_polls then
          vim.defer_fn(poll_until_text, 500)
        else
          -- Timeout
          state.set_processing(false)
          if config.notifications then
            vim.cmd('echohl WarningMsg | echo "No new transcription" | echohl None')
            vim.defer_fn(function() vim.cmd('echo ""') end, 2000)
          end
        end
      end

      poll_until_text()
    end
  end
end

-- Reset state when starting a new recording
local original_start = original_audio.start_recording
M.start_recording = function(config)
  last_text = ""
  return original_start(config)
end

-- Reset state when stopping
local original_stop = original_audio.stop_recording
M.stop_recording = function()
  last_text = ""
  return original_stop()
end

-- Expose all original functions that we didn't override
for k, v in pairs(original_audio) do
  if not M[k] then
    M[k] = v
  end
end

return M
