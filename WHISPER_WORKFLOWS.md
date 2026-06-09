# Whisper Voice-to-Text Workflows

This document describes the available workflows for using whisper.nvim voice transcription in your Neovim configuration.

## Current Configuration: Alternative 1 (Recommended)

**Automatic Timer-Based Insertion** - Text appears automatically as you speak.

### Configuration

```lua
-- In lua/custom/plugins/whisper/config.lua
enable_streaming = true,
poll_interval_ms = 5000,  -- Auto-insert every 5 seconds
filter_markers = true,    -- Remove [BLANK_AUDIO], (beeping), etc.
step_ms = 5000,           -- Process audio every 5 seconds
```

### Workflow

1. **Start recording**: Press `,ww` (leader key is comma)
   - Notification: "Loading model..." (first time only)
   - Notification: "Ready to record"
   
2. **Speak naturally**: Just talk - no other actions needed
   - Text automatically appears every ~5 seconds
   - Continues inserting as you keep speaking
   - No need to press any keys while speaking

3. **Stop recording**: Press `,ww` again
   - Any remaining text is inserted
   - Notification: "Transcription complete"

### Example

```
You: Press ,ww
You: "The quick brown fox jumped over the lazy dog."
[5 seconds pass]
Editor: "The quick brown fox jumped over the lazy dog."
You: "The window is open. The hat is red."
[5 seconds pass]
Editor: " The window is open. The hat is red."
You: Press ,ww (stops recording)
```

### Pros

✅ **Simplest workflow** - just start, speak, stop  
✅ **Real-time feedback** - see text appear as you talk  
✅ **Natural rhythm** - matches your speaking pace  
✅ **No manual triggers** - hands stay on keyboard or off entirely  
✅ **No duplication** - plugin handles timing automatically  

### Cons

❌ May insert mid-sentence if you pause  
❌ Less control over exact insertion timing  
❌ Text appears even if you're not ready to see it  

### Best For

- Continuous dictation (emails, documentation, notes)
- When you want to see transcription in real-time
- Hands-free operation (no need to press keys while speaking)
- Most general-purpose voice-to-text use cases

---

## Alternative 2: Non-Streaming Mode

**One-Shot Insertion** - Speak everything, then see all text at once.

### Configuration

```lua
-- In lua/custom/plugins/whisper/config.lua
-- Change enable_streaming to false:
enable_streaming = false,

-- You can comment out or remove:
-- poll_interval_ms = 5000,
```

### Workflow

1. **Start recording**: Press `,ww`
   - Notification: "Loading model..." (first time only)
   - Notification: "Ready to record"

2. **Speak your complete thought**: Say everything you want to transcribe
   - NO text appears while speaking
   - NO visual feedback during recording
   - Whisper is still processing in the background

3. **Stop recording**: Press `,ww`
   - All transcribed text appears at once
   - Notification shows first ~50 characters

### Example

```
You: Press ,ww
You: "The quick brown fox jumped over the lazy dog. The window is open. The hat is red."
[You see nothing appear yet]
You: Press ,ww (stops recording)
Editor: "The quick brown fox jumped over the lazy dog. The window is open. The hat is red."
```

### Pros

✅ **Simplest configuration** - minimal settings  
✅ **Complete thoughts** - speak entire paragraph before seeing result  
✅ **No mid-sentence interruptions** - clean insertion  
✅ **Predictable** - always inserts on stop, never during  
✅ **Lower CPU usage** - no polling/streaming overhead  

### Cons

❌ Zero real-time feedback while speaking  
❌ Can't see/correct until finished  
❌ If transcription is wrong, you've said everything already  
❌ No way to tell if it's working until you stop  

### Best For

- Short, complete thoughts (sentences or paragraphs)
- When you don't need real-time feedback
- Dictating pre-planned content
- Quick voice notes or comments
- Lower-resource environments

---

## Comparison Table

| Feature | Alternative 1 (Auto) | Alternative 2 (One-Shot) |
|---------|---------------------|--------------------------|
| **Real-time feedback** | ✅ Every 5 seconds | ❌ Only at end |
| **Hands-free** | ✅ Fully automatic | ✅ Fully automatic |
| **Configuration complexity** | Simple | Simplest |
| **CPU usage** | Moderate | Lower |
| **Best for long dictation** | ✅ Yes | ⚠️  Okay |
| **Best for short notes** | ✅ Yes | ✅ Yes |
| **Can correct mid-session** | ✅ Yes | ❌ No |
| **Insertion timing control** | ⚠️  Automatic | ✅ Manual (on stop) |

---

## Switching Between Alternatives

### To Switch from Alternative 1 to Alternative 2

1. Edit `lua/custom/plugins/whisper/config.lua`
2. Change:
   ```lua
   enable_streaming = false,
   ```
3. Restart Neovim or reload config

### To Switch from Alternative 2 to Alternative 1

1. Edit `lua/custom/plugins/whisper/config.lua`
2. Change:
   ```lua
   enable_streaming = true,
   poll_interval_ms = 5000,
   ```
3. Restart Neovim or reload config

---

## Keybindings

Both alternatives use the same keybinding:

- **`,ww`** - Toggle recording on/off (leader key `,` + `ww`)

The difference is WHEN text appears:
- **Alternative 1**: Automatically every 5 seconds
- **Alternative 2**: When you press `,ww` to stop

---

## Troubleshooting

### No text appears (Alternative 1)

**Check:**
- Is `enable_streaming = true`?
- Is `poll_interval_ms` set to 5000 (not 999999)?
- Wait at least 5 seconds after speaking

### No text appears (Alternative 2)

**Check:**
- Is `enable_streaming = false`?
- Did you press `,ww` to STOP recording?
- Text only appears when recording stops

### Text appears but is duplicated

This shouldn't happen with either alternative. If it does:
- Check that you're on the correct branch (`whisper`)
- Make sure `audio_override.lua` does NOT exist
- Try restarting Neovim

### Enable Debug Mode

To see what's happening under the hood:

```lua
-- In config.lua, add:
debug = true,
debug_file = '/tmp/whisper-debug.log',
```

Then check `/tmp/whisper-debug.log` after recording to see:
- When transcription starts/stops
- What text was transcribed
- When insertions occur
- Any errors

---

## Technical Details

### How Alternative 1 Works

1. Press `,ww` → starts `whisper-stream` subprocess
2. Subprocess writes transcription to temp file continuously
3. Timer polls temp file every 5 seconds
4. New text is extracted and inserted into buffer
5. Press `,ww` → stops subprocess, final insertion

### How Alternative 2 Works

1. Press `,ww` → starts `whisper-stream` subprocess
2. Subprocess writes transcription to temp file continuously
3. You speak (no polling happens)
4. Press `,ww` → stops subprocess
5. Final line of temp file is read and inserted

### Whisper Processing Settings

Both alternatives use the same Whisper parameters:

- **`step_ms = 5000`**: Process audio every 5 seconds
  - Smaller = faster response, higher CPU
  - Larger = slower response, lower CPU
  
- **`vad_thold = 0.6`**: Voice activity detection (0.0-1.0)
  - Lower = captures more (including quiet sounds/noise)
  - Higher = only captures clear speech
  
- **`threads = 4`**: CPU threads for processing
  - Match your CPU core count (up to ~8)

### Model Selection

```lua
-- Base model (recommended balance)
model_path = vim.fn.expand '~/whisper.cpp/models/ggml-base.en.bin',

-- Faster but less accurate
-- model_path = vim.fn.expand '~/whisper.cpp/models/ggml-tiny.en.bin',

-- Slower but more accurate  
-- model_path = vim.fn.expand '~/whisper.cpp/models/ggml-small.en.bin',
```

---

## Recommendation

**Start with Alternative 1** (automatic timer-based insertion). 

It provides the best balance of:
- Real-time feedback
- Simplicity
- Natural workflow
- Hands-free operation

Try it for a few days. If you find the automatic insertion timing disruptive or don't actually use the real-time feedback, switch to Alternative 2.

Most users find Alternative 1 works perfectly because the 5-second interval matches natural speaking rhythm - you don't even notice when text appears, it just flows naturally as you speak.
