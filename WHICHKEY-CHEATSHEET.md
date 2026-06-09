# WhichKey Cheatsheet

This cheatsheet reflects the current keymaps in this config.

- Leader key: `,`
- Local leader key: `,`
- Tip: press `,` and pause to open WhichKey for leader mappings.

## Quick Help

| Key | Mode | What it does |
| --- | --- | --- |
| `<leader>?` | Normal | Open this cheatsheet in a new read-only tab. |
| `<leader>g?` | Normal | Open `FUGITIVE.md` in a new read-only tab. |
| `q` | Normal (in cheatsheet/docs tab) | Close the read-only tab and jump back to the tab you came from. |

## Core

| Key | Mode | What it does |
| --- | --- | --- |
| `<Esc>` | Normal | Clear search highlight (`:nohlsearch`). |
| `<C-h>` | Normal | Focus left split. |
| `<C-j>` | Normal | Focus lower split. |
| `<C-k>` | Normal | Focus upper split. |
| `<C-l>` | Normal | Focus right split. |
| `\\` | Normal | Reveal current file in Neo-tree. |

## Neo-tree

| Key | Mode | What it does |
| --- | --- | --- |
| `\\` | Normal (in Neo-tree window) | Close Neo-tree window. |
| `<CR>` or `o` | Normal (in Neo-tree, on file) | Open file in current window. |
| `s` | Normal (in Neo-tree, on file) | Open file in vertical split. |
| `S` | Normal (in Neo-tree, on file) | Open file in horizontal split. |
| `t` | Normal (in Neo-tree, on file) | Open file in new tab. |

## Find (`<leader>f`)

| Key | Mode | What it does |
| --- | --- | --- |
| `<leader>fh` | Normal | Telescope help tags. |
| `<leader>fk` | Normal | Telescope keymaps (great live cheatsheet). |
| `<leader>ff` | Normal | Telescope file finder. |
| `<leader>fb` | Normal | Telescope Git branches. |
| `<leader>fs` | Normal | Telescope builtins picker. |
| `<leader>fw` | Normal | Grep current word. |
| `<leader>fg` | Normal | Live grep project. |
| `<leader>fd` | Normal | Diagnostics picker. |
| `<leader>fr` | Normal | Resume last Telescope picker. |
| `<leader>ft` | Normal | Todo comments picker. |
| `<leader>f.` | Normal | Recent files. |
| `<leader>f/` | Normal | Live grep in open files only. |
| `<leader>fn` | Normal | Find files inside Neovim config. |
| `<leader>/` | Normal | Fuzzy-find inside current buffer. |
| `<leader><leader>` | Normal | Switch open buffers. |

### Telescope Result Actions

When a Telescope picker is open, use these keys on selected items:

| Key | Mode | What it does |
| --- | --- | --- |
| `<CR>` | Insert/Normal (in Telescope) | Open file in current window. |
| `<C-x>` | Insert/Normal (in Telescope) | Open file in horizontal split. |
| `<C-v>` | Insert/Normal (in Telescope) | Open file in vertical split. |
| `<C-t>` | Insert/Normal (in Telescope) | Open file in new tab. |

## Git: Fugitive (`<leader>g`)

| Key | Mode | What it does |
| --- | --- | --- |
| `<leader>gg` | Normal | Open Fugitive status (`:Git`). |
| `<leader>g?` | Normal | Open `FUGITIVE.md` in a new read-only tab. |
| `<leader>gs` | Normal | Stage current file (`git add %`). |
| `<leader>gS` | Normal | Stage hunks interactively (`git add -p`). |
| `<leader>gc` | Normal | Commit staged changes with verbose diff in message buffer (`git commit -v`). |
| `<leader>gC` | Normal | Amend last commit. |
| `<leader>gb` | Normal | Switch branch (prompts for branch name). |
| `<leader>gB` | Normal | Create + switch branch (prompts for name). |
| `<leader>gp` | Normal | Push current branch. |
| `<leader>gu` | Normal | Pull updates. |
| `<leader>gl` | Normal | Blame current file. |
| `<leader>gd` | Normal | Diff split for current file (`:Gdiffsplit`). |
| `<leader>gr` | Normal | Interactive rebase (default base `HEAD~3`). |
| `<leader>gX` | Normal | Discard current file changes with confirmation. |

## Git: Gitsigns Hunks (`<leader>h`)

| Key | Mode | What it does |
| --- | --- | --- |
| `]c` | Normal | Jump to next git hunk. |
| `[c` | Normal | Jump to previous git hunk. |
| `<leader>hs` | Normal/Visual | Stage hunk (or visual selection). |
| `<leader>hS` | Normal | Stage entire buffer. |
| `<leader>hu` | Normal | Undo staged hunk. |
| `<leader>hr` | Normal/Visual | Reset hunk (or visual selection). |
| `<leader>hR` | Normal | Reset entire buffer. |
| `<leader>hp` | Normal | Preview hunk. |
| `<leader>hb` | Normal | Blame current line. |
| `<leader>hd` | Normal | Diff against index. |
| `<leader>hD` | Normal | Diff against `HEAD`. |

## Yank (`<leader>y`)

| Key | Mode | What it does |
| --- | --- | --- |
| `<leader>yp` | Normal | Copy current file path relative to project root (`.git`) to clipboard. |
| `<leader>yf` | Normal | Copy current filename only (no path) to clipboard. |
| `<leader>ys` | Normal | Open current-directory scratch in a new tab if `./scratch.txt` exists; otherwise warn and do nothing. |

## Code (`<leader>c`)

| Key | Mode | What it does |
| --- | --- | --- |
| `<leader>cj` | Normal | Format current buffer as JSON via `jq` and keep cursor/view position. |

## Save, Quit, Diagnostics, Toggle

| Key | Mode | What it does |
| --- | --- | --- |
| `<leader>ss` | Normal/Visual | Save current buffer. |
| `<leader>sa` | Normal | Save all buffers. |
| `<leader>sr` | Normal | Reload all buffers from disk (manual check). |
| `<leader>q` | Normal | Open diagnostics quickfix list. |
| `<leader>ts` | Normal | Toggle spellcheck in current buffer. |
| `<leader>tb` | Normal | Toggle inline git blame (gitsigns). |
| `<leader>tD` | Normal | Toggle display of deleted lines (gitsigns). |
| `<leader>e` | Normal | Quit current window. |
| `<leader>E` | Normal | Quit all windows (`qa!`). |

## LSP (buffer-local when language server is attached)

| Key | Mode | What it does |
| --- | --- | --- |
| `gd` | Normal | Go to definition (Telescope). |
| `gr` | Normal | Go to references (Telescope). |
| `gI` | Normal | Go to implementation (Telescope). |
| `gD` | Normal | Go to declaration. |
| `<leader>D` | Normal | Go to type definition (Telescope). |
| `<leader>ds` | Normal | Document symbols (Telescope). |
| `<leader>ws` | Normal | Workspace symbols (Telescope). |
| `<leader>rn` | Normal | Rename symbol. |
| `<leader>ca` | Normal/Visual | Code action. |
| `<leader>th` | Normal | Toggle inlay hints (if supported). |

## Tests (`<leader>x`)

| Key | Mode | What it does |
| --- | --- | --- |
| `<leader>xt` | Normal | Run nearest test. |
| `<leader>xs` | Normal | Stop nearest test. |
| `<leader>xd` | Normal | Debug nearest test. |
| `<leader>xf` | Normal | Run tests in current file. |
| `<leader>xS` | Normal | Toggle neotest summary panel. |
| `<leader>xO` | Normal | Toggle neotest output panel. |
| `<leader>xo` | Normal | Open nearest test output. |

## Harpoon (`<leader>m`)

| Key | Mode | What it does |
| --- | --- | --- |
| `<leader>ma` | Normal | Add current file to Harpoon. |
| `<leader>mm` | Normal | Toggle Harpoon quick menu. |
| `<leader>m1` ... `<leader>m9` | Normal | Jump to Harpoon file slot 1-9. |

## Debug (DAP)

| Key | Mode | What it does |
| --- | --- | --- |
| `<F5>` | Normal | Start/continue debug session. |
| `<F1>` | Normal | Step into. |
| `<F2>` | Normal | Step over. |
| `<F3>` | Normal | Step out. |
| `<F7>` | Normal | Toggle DAP UI. |
| `<F8>` | Normal | Terminate debug session. |
| `<leader>b` | Normal | Toggle breakpoint. |
| `<leader>B` | Normal | Set conditional breakpoint. |

## AI Suggestions (Copilot, insert mode)

| Key | Mode | What it does |
| --- | --- | --- |
| `<M-l>` | Insert | Accept suggestion. |
| `<M-.>` | Insert | Next suggestion. |
| `<M-,>` | Insert | Previous suggestion. |
| `<M-;>` | Insert | Dismiss suggestion. |

## Extra Editing Helpers

| Key | Mode | What it does |
| --- | --- | --- |
| `gqap` | Normal | Format a paragraph (`ap` text object). Example: place cursor in a wrapped paragraph and press `gqap`. |
| `gq{motion}` | Normal | Format text covered by a motion. Example: `gq}` formats from cursor to end of paragraph. |
| `gsa` | Normal | Add surround (mini.surround). |
| `gsd` | Normal | Delete surround. |
| `gsr` | Normal | Replace surround. |
| `gsf` | Normal | Find right surround. |
| `gsF` | Normal | Find left surround. |
| `gsh` | Normal | Highlight surrounding pair. |
| `gsn` | Normal | Update surround search lines. |

## Voice/Whisper (`<leader>w`)

| Key | Mode | What it does |
| --- | --- | --- |
| `<leader>ww` | Normal | Toggle whisper recording (start/stop). Text automatically appears every ~5 seconds while recording. |

**Workflow:**
1. Press `,ww` to start recording
2. Speak naturally - text automatically appears as you talk
3. Press `,ww` to stop recording

See `WHISPER_WORKFLOWS.md` for alternative configurations (non-streaming mode).

## External Git UI

| Key | Mode | What it does |
| --- | --- | --- |
| `<leader>vv` | Normal | Open LazyGit terminal UI. |

## WhichKey usage tips

- `:WhichKey` -> open top-level popup.
- `:WhichKey ,` -> open leader-key tree directly.
- `,fk` -> Telescope keymaps picker (searchable cheatsheet).
- `,?` -> open `~/.config/nvim/WHICHKEY-CHEATSHEET.md` in a new read-only tab.
- `,g?` -> open `~/.config/nvim/FUGITIVE.md` in a new read-only tab.
