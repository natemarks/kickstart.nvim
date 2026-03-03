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