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
If you want, I can turn this into a runnable checklist file in the repo (e.g., docs/lsp-migration-test-plan.md).

