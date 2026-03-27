# Fugitive Git Workflow for This Neovim Config

Leader key in this config is `,`.

All Fugitive mappings live under `<leader>g` (for example `,gg`).

## Keymaps

| Keymap | Action | What it does | When to use |
| --- | --- | --- | --- |
| `<leader>gg` | Git status | Opens Fugitive status (`:Git`) | Start almost any Git task |
| `<leader>gs` | Stage file | Runs `:Git add %` for current file | You want to stage current buffer quickly |
| `<leader>gS` | Stage hunk (interactive) | Runs `:Git add -p -- %` | Stage only selected hunks from current file |
| `<leader>gc` | Commit | Opens `:Git commit` | Create a commit from staged changes |
| `<leader>gC` | Amend commit | Opens `:Git commit --amend` | Fix or extend the last local commit |
| `<leader>gb` | Checkout branch | Prompts for branch, runs `:Git switch <branch>` | Switch to an existing branch |
| `<leader>gB` | Create branch | Prompts for name, runs `:Git switch -c <branch>` | Create and switch in one step |
| `<leader>gp` | Push | Runs `:Git push` | Publish local commits |
| `<leader>gu` | Pull | Runs `:Git pull` | Bring remote updates into current branch |
| `<leader>gl` | Blame file | Opens `:Git blame` | Track who changed each line and why |
| `<leader>gd` | Diff split | Opens `:Gdiffsplit` | Review file-level diff in split views |
| `<leader>gr` | Interactive rebase | Prompts for base (default `HEAD~3`), runs `:Git rebase -i <base>` | Clean up/squash/reorder local commits |
| `<leader>gX` | Discard file changes | Confirm prompt, then `:Git restore --worktree -- %` | Throw away working-tree changes in current file |

## Common Neovim Git Workflows

### 1) Fast commit flow

1. `,gg` to open status and inspect changes.
2. `,gs` to stage current file (or `,gS` for patch mode).
3. `,gc` to commit.
4. `,gp` to push.

### 2) Partial staging flow (clean commits)

1. Open file with mixed edits.
2. `,gS` and select hunks interactively.
3. `,gc` to commit only what is staged.

### 3) Fix previous commit

1. Stage fix with `,gs` or `,gS`.
2. `,gC` to amend.

Use this only for commits that have not been shared yet.

### 4) Branch and review flow

1. `,gB` to create/switch to a feature branch.
2. Edit and stage with `,gs` / `,gS`.
3. Review with `,gd`.
4. Commit `,gc` and push `,gp`.

### 5) Investigate history

1. `,gl` for line-by-line blame.
2. `,gd` to inspect current diffs.
3. `,gg` for repo status and next actions.

## Safety notes

- `,gX` is intentionally uppercase and asks for confirmation before discarding file changes.
- `,gC` (amend) rewrites the most recent commit; avoid using it after pushing shared history.
- `,gr` (interactive rebase) rewrites commit history; use on local/private commits unless your team explicitly allows force-push workflows.
- For file-level undo, prefer reviewing in `,gd` before using `,gX`.

## Fugitive-native power tips

- Inside `:Git` status window, `-` toggles stage/unstage on file or hunk under cursor.
- In many Fugitive views, `cc` starts commit, `ca` amends, and `q` closes the window.
- `:help fugitive` and `:help fugitive-map` are worth bookmarking.
