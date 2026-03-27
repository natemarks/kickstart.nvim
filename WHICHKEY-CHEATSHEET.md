# WhichKey Cheatsheet

This cheatsheet reflects the current keymaps in this config.

- Leader key: `,`
- Local leader key: `,`
- Tip: press `,` and pause to open WhichKey for leader mappings.

## Quick Help

| Key | Mode | What it does |
| --- | --- | --- |
| `<leader>?` | Normal | Open this cheatsheet in a new read-only tab. |

## Core

| Key | Mode | What it does |
| --- | --- | --- |
| `<Esc>` | Normal | Clear search highlight (`:nohlsearch`). |
| `<C-h>` | Normal | Focus left split. |
| `<C-j>` | Normal | Focus lower split. |
| `<C-k>` | Normal | Focus upper split. |
| `<C-l>` | Normal | Focus right split. |
| `\\` | Normal | Reveal current file in Neo-tree. |

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

## Git: Fugitive (`<leader>g`)

| Key | Mode | What it does |
| --- | --- | --- |
| `<leader>gg` | Normal | Open Fugitive status (`:Git`). |
| `<leader>gs` | Normal | Stage current file (`git add %`). |
| `<leader>gS` | Normal | Stage hunks interactively (`git add -p`). |
| `<leader>gc` | Normal | Commit staged changes. |
| `<leader>gC` | Normal | Amend last commit. |
| `<leader>gb` | Normal | Switch branch (prompts for branch name). |
| `<leader>gB` | Normal | Create + switch branch (prompts for name). |
| `<leader>gp` | Normal | Push current branch. |
| `<leader>gu` | Normal | Pull updates. |
| `<leader>gl` | Normal | Blame current file. |
| `<leader>gd` | Normal | Diff split (`:Gdiffsplit`). |
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

## Save, Quit, Diagnostics, Toggle

| Key | Mode | What it does |
| --- | --- | --- |
| `<leader>ss` | Normal/Visual | Save current buffer. |
| `<leader>sa` | Normal | Save all buffers. |
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
| `gsa` | Normal | Add surround (mini.surround). |
| `gsd` | Normal | Delete surround. |
| `gsr` | Normal | Replace surround. |
| `gsf` | Normal | Find right surround. |
| `gsF` | Normal | Find left surround. |
| `gsh` | Normal | Highlight surrounding pair. |
| `gsn` | Normal | Update surround search lines. |

## External Git UI

| Key | Mode | What it does |
| --- | --- | --- |
| `<leader>vv` | Normal | Open LazyGit terminal UI. |

## WhichKey usage tips

- `:WhichKey` -> open top-level popup.
- `:WhichKey ,` -> open leader-key tree directly.
- `,fk` -> Telescope keymaps picker (searchable cheatsheet).
- `,?` -> open `~/.config/nvim/WHICHKEY-CHEATSHEET.md` in a new read-only tab.
