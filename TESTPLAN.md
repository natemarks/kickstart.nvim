# Test Plan

This checklist verifies behavior after migrating most modules from `lua/kickstart/` to `lua/custom/`.

## Scope

- Confirm startup and lazy loading are unchanged.
- Confirm moved modules resolve from `custom.*` paths.
- Confirm the vendor plugin exceptions still load from `kickstart.*`.

Vendor exceptions expected to remain in `lua/kickstart/plugins/`:

- `autopairs.lua`
- `debug.lua`
- `gitsigns.lua`
- `indent_line.lua`
- `lint.lua`
- `neo-tree.lua`

## 1) Startup and Health

1. Launch Neovim: `nvim`
2. Run `:messages`
   - Pass: no module resolution errors (`module 'kickstart....' not found`) for moved modules.
3. Run `:checkhealth`
   - Pass: no new failures introduced by refactor.

## 2) Plugin Resolution

1. Run `:Lazy`
2. Confirm these load from `custom.*` modules:
   - Telescope, Completion, Harpoon, Mini, Treesitter, Neotest, Copilot
3. Confirm these still load from `kickstart.*` modules:
   - `kickstart.plugins.debug`
   - `kickstart.plugins.indent_line`
   - `kickstart.plugins.autopairs`
   - `kickstart.plugins.neo-tree`
   - `kickstart.plugins.gitsigns`
   - Optional: `kickstart.plugins.lint` if uncommented

## 3) LSP Regression

1. Open one file each: Lua, Go, Python
2. Run `:LspInfo`
   - Pass: expected servers attach (`lua_ls`, `gopls`, `pyright`)
3. Validate common mappings in attached buffer:
   - `gd`, `gr`, `gI`, `<leader>D`, `<leader>rn`, `<leader>ca`, `gD`
4. Validate diagnostics mapping:
   - `<leader>q`

## 4) Completion + LuaSnip

1. Enter Insert mode in Lua/Go/Python file
2. Verify completion menu appears and keymaps work:
   - `<C-n>`, `<C-p>`, `<C-Space>`, confirm with `<CR>`/`<C-y>`
3. Verify snippet jump mappings:
   - `<C-l>` forward, `<C-h>` backward
4. In Python file, expand your custom `ppyt` snippet
   - Pass: snippet inserts expected scaffold

## 5) Treesitter Runtimepath Check

1. Run `:checkhealth` after startup settles
2. Confirm no runtimepath regression for data site path, especially:
   - `~/.local/share/nvim/site/` remains discoverable

## 6) Neotest Regression

1. Open Python test file, run nearest test
2. Open Go test file, run nearest test
3. Verify keymaps execute:
   - `<leader>xt`, `<leader>xs`, `<leader>xd`, `<leader>xf`
4. Verify debug path works for `<leader>xd`

## 7) Vendor File Integrity

1. Confirm only these files remain under `lua/kickstart/plugins/`:
   - `autopairs.lua`, `debug.lua`, `gitsigns.lua`, `indent_line.lua`, `lint.lua`, `neo-tree.lua`
2. Confirm there are no additional Lua modules under `lua/kickstart/`.

## Pass Criteria

- No startup/module resolution errors.
- All moved modules function via `custom.*` imports.
- Vendor exceptions continue to work from `kickstart.*` imports.
- LSP, completion, snippets, treesitter, and neotest behavior unchanged.

---

## Legacy Notes (Original TESTPLAN.md Content)

# Test PLan

These are noes about how to verify important functionality



### LSP
Great question. For your current setup, a good post-migration plan is:

1) Startup / Load

Launch Neovim with the migrated config and confirm no startup errors.
Run :checkhealth and :messages for hidden warnings.
Open init.lua and verify Lua-only plugins load as expected (lazydev, luvit-meta path hints).
2) Tooling Install Path

Run :Mason and confirm required tools/servers from your current config are present (lua_ls, gopls, pyright, stylua, debugpy).
Validate mason-tool-installer still auto-ensures the same set.
# Test Plan

These are notes about how to verify important functionality.

## LSP

Great question. For your current setup, a good post-migration plan is:

1) Startup / Load

Launch Neovim with the migrated config and confirm no startup errors.
Run :checkhealth and :messages for hidden warnings.
Open init.lua and verify Lua-only plugins load as expected (lazydev, luvit-meta path hints).

2) Tooling Install Path

Run :Mason and confirm required tools/servers from your current config are present (lua_ls, gopls, pyright, stylua, debugpy).
Validate mason-tool-installer still auto-ensures the same set.

3) LSP Attach Behavior

Open one file per language (Lua, Go, Python) and run :LspInfo.
Confirm each expected server attaches with no duplicate/missing clients.

4) Keymap Regression

In an attached buffer, test mapped LSP actions: gd, gr, gI, <leader>D, <leader>rn, <leader>ca, gD.
Confirm Telescope-backed LSP pickers still open and return results.

5) Feature Regression

Verify document highlight on cursor hold and clear on move.
Test inlay hints toggle (<leader>th) in a server that supports it.
Confirm diagnostics list mapping (<leader>q) still works.

6) Completion / Lua UX

In Lua files, verify Neovim API completion quality and vim.uv hints (lazydev + luvit-meta behavior).
In Go/Python, verify nvim-cmp still completes from LSP.

7) Negative / Edge Checks

Open non-LSP filetypes to confirm no unexpected LSP attach.
Save/reopen to ensure no autocommand duplication (highlights, detach cleanup).

## Treesitter

Treesitter has special path requirements. Use :checkhealth to see if this error is present.
Note: it's present immediately after Neovim starts in some setups, so wait a moment before running :checkhealth.

```
179 - /home/natepm/.local/share/nvim/site/
1 - ✅ OK is writable.
2 - ❌ ERROR is not in runtimepath
```

## Autocomplete (nvim-cmp refactor)

Goal: confirm the completion refactor keeps behavior unchanged.

1) Startup / load

- Launch Neovim and run :messages.
- Confirm no startup errors mentioning kickstart.plugins.completion.

2) Plugin/module wiring

- Run :Lazy and confirm these are installed and load on InsertEnter:
   - hrsh7th/nvim-cmp
   - L3MON4D3/LuaSnip
   - saadparwaiz1/cmp_luasnip
   - hrsh7th/cmp-nvim-lsp
   - hrsh7th/cmp-path
   - rafamadriz/friendly-snippets

3) Completion behavior

- In Lua/Go/Python buffers, type a prefix in Insert mode.
- Verify completion opens and keymaps work:
   - <C-n> / <C-p> navigate
   - <CR> or <C-y> confirm
   - <C-Space> triggers completion manually

4) Snippet behavior

- Confirm snippet entries expand from completion.
- Verify snippet jump keymaps:
   - <C-l> jump forward
   - <C-h> jump backward

5) Source regression checks

- Confirm completion includes nvim_lsp, luasnip, and path sources.
- In Lua files, verify lazydev-aware completion still appears.

6) Optional build check

- If make exists, ensure no LuaSnip jsregexp build errors appear in :messages.
- If make does not exist, confirm startup and completion still work.

Pass criteria: no new startup errors, same completion/snippet UX, expected sources available.

## Neotest

Goal: verify neotest plugin wiring, adapters, keymaps, and debug flow after extraction.

1) Startup / plugin load

- Launch Neovim and run :messages.
- Confirm no startup errors mentioning kickstart.plugins.neotest.
- Run :Lazy and verify neotest stack is installed:
   - nvim-neotest/neotest
   - nvim-neotest/neotest-python
   - nvim-neotest/neotest-go
   - nvim-neotest/neotest-plenary
   - nvim-neotest/neotest-vim-test

2) Adapter sanity checks

- Open a Python test file and run :lua require('neotest').run.run().
- Open a Go test file and run :lua require('neotest').run.run().
- Confirm tests start through the correct adapter for each language.

3) Keymap checks

- Verify these keymaps work in normal mode:
   - <leader>xt = run nearest test
   - <leader>xs = stop nearest test (current config calls run; confirm intended behavior)
   - <leader>xd = debug nearest test (DAP strategy)
   - <leader>xf = run tests in current file

4) DAP integration check

- Run <leader>xd in a Python test file.
- Confirm debug session starts and no adapter executable/path warnings appear.

5) Output and state checks

- Trigger a passing and failing test.
- Verify neotest output/summary updates and failures are visible.
- Re-run after editing a test to confirm state refresh works.

6) Regression checks

- Restart Neovim and repeat one Python + one Go run.
- Ensure no duplicate keymaps or duplicate adapter registrations.
- Confirm no circular dependency symptoms (load order issues, delayed adapters, missing commands).

Pass criteria: all neotest keymaps execute, Python/Go adapters run, DAP debug path works, and no startup/runtime warnings are introduced.
