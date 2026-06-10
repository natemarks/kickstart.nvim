# Neovim 0.12+ Upgrade Guide

## What is Neovim 0.12?

Neovim 0.12 is an upcoming release (as of June 2026) that includes improvements to the built-in package management, LSP, and Treesitter capabilities.

---

## Built-in Package Manager

### Do You Need to Switch from lazy.nvim?

**Short Answer: No, you don't need to switch.**

Neovim has had a built-in package manager since 0.8 (`:h packages`), but it's **very basic**:
- It can load plugins from `~/.local/share/nvim/site/pack/*/start/` or `/opt/`
- No automatic installation
- No lazy loading
- No version pinning
- No automatic updates
- No dependency management

### What lazy.nvim Provides That Built-in Doesn't:

| Feature | Built-in Packages | lazy.nvim |
|---------|------------------|-----------|
| Auto-install from Git | ✗ | ✓ |
| Lazy loading | Manual only | Automatic |
| Dependency resolution | ✗ | ✓ |
| Version pinning | ✗ | ✓ |
| Update management | ✗ | ✓ |
| UI for managing plugins | ✗ | ✓ |
| Performance profiling | ✗ | ✓ |

**Recommendation:** Keep using lazy.nvim. The built-in package system is for people who manually manage plugins (clone repos, track updates themselves).

---

## Rustaceanvim: What You Get on Neovim 0.12+

### What is rustaceanvim?

`rustaceanvim` is a **modern, opinionated Rust development environment** that replaces the older `rust-tools.nvim`. It requires Neovim 0.12+ because it uses newer Neovim APIs.

### Current Setup (Without rustaceanvim):

```
┌─────────────────┐
│ rust-analyzer   │ ← LSP server (provides completion, diagnostics, etc.)
└─────────────────┘
┌─────────────────┐
│ nvim-lspconfig  │ ← Configures LSP manually
└─────────────────┘
┌─────────────────┐
│ codelldb        │ ← Debugger adapter (manual DAP setup)
└─────────────────┘
```

### With rustaceanvim (Neovim 0.12+):

```
┌──────────────────────────┐
│      rustaceanvim        │ ← All-in-one integration layer
│  ┌────────────────────┐  │
│  │  rust-analyzer     │  │ ← Auto-configured
│  └────────────────────┘  │
│  ┌────────────────────┐  │
│  │  codelldb          │  │ ← Auto-configured
│  └────────────────────┘  │
│  ┌────────────────────┐  │
│  │  Extra features    │  │ ← See below
│  └────────────────────┘  │
└──────────────────────────┘
```

### What rustaceanvim Adds:

#### 1. **Auto-Configuration**
- Zero-config rust-analyzer setup with sensible defaults
- Automatic codelldb integration (no manual DAP config needed)
- Detects Cargo.toml and adjusts settings per-project

#### 2. **Enhanced Commands**
| Command | Description |
|---------|-------------|
| `:RustLsp runnables` | Quick menu to run/debug tests, binaries, examples |
| `:RustLsp expandMacro` | Show expanded macro at cursor |
| `:RustLsp rebuildProcMacros` | Rebuild proc macros without full rebuild |
| `:RustLsp openCargo` | Open Cargo.toml |
| `:RustLsp parentModule` | Navigate to parent module |
| `:RustLsp joinLines` | Smart join lines (respects Rust syntax) |
| `:RustLsp explainError` | Open detailed error explanation in browser |

#### 3. **Test Integration**
```lua
-- Run the test under cursor with one command
:RustLsp testables

-- Shows UI like:
-- [1] Run test_something()
-- [2] Debug test_something()
-- [3] Run all tests in mod tests
```

#### 4. **Better Inlay Hints**
- More granular control over type hints, parameter hints, chaining hints
- Better performance than raw rust-analyzer hints

#### 5. **Cargo.toml Integration**
- Hover over dependency versions to see latest available
- Code actions to update dependencies
- Completion for crate names

#### 6. **Standalone Binary Debugging**
- Automatically finds the correct binary in `target/debug/`
- No need to manually type executable path
- Smart detection of test binaries vs main binaries

#### 7. **Proc Macro Support**
- Better handling of proc macro expansion
- Faster proc macro rebuilds
- Show expanded proc macro code inline

---

## What Changes When You Upgrade to Neovim 0.12+

### Files to Modify:

#### 1. **Remove Manual Rust DAP Config**
File: `lua/kickstart/plugins/debug.lua`

**Before (current):**
```lua
-- Manual DAP configuration for Rust
dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = codelldb_path,
    args = { '--port', '${port}' },
  },
}

dap.configurations.rust = {
  {
    name = 'Launch',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
```

**After (with rustaceanvim):**
```lua
-- Remove the manual config above
-- rustaceanvim handles it automatically
```

#### 2. **Simplify Rust LSP Config**
File: `lua/custom/lsp/servers/rust.lua`

**Before (current):**
```lua
local M = {}

function M.get()
  return {
    rust_analyzer = {
      settings = {
        ['rust-analyzer'] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = {
              enable = true,
            },
          },
          checkOnSave = {
            allFeatures = true,
            command = 'clippy',
            extraArgs = { '--no-deps' },
          },
          procMacro = {
            enable = true,
            ignored = {
              ['async-trait'] = { 'async_trait' },
              ['napi-derive'] = { 'napi' },
              ['async-recursion'] = { 'async_recursion' },
            },
          },
        },
      },
    },
  }
end

return M
```

**After (with rustaceanvim):**
```lua
local M = {}

function M.get()
  -- rustaceanvim takes over rust-analyzer config
  -- Remove rust_analyzer from here
  return {}
end

return M
```

#### 3. **Add rustaceanvim Plugin**
File: `lua/kickstart/plugins/debug.lua`

**Add to dependencies:**
```lua
dependencies = {
  -- ... existing deps ...
  'leoluz/nvim-dap-go',
  'mrcjkb/rustaceanvim', -- Add this back
},
```

#### 4. **Configure rustaceanvim**
Create new file: `lua/custom/plugins/rustacean.lua`

```lua
return {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended to pin to major version
  lazy = false, -- This plugin is already lazy (loads on Rust files)
  init = function()
    -- Configure rustaceanvim before it loads
    vim.g.rustaceanvim = {
      -- LSP settings
      server = {
        on_attach = function(client, bufnr)
          -- Optionally set custom keymaps here
          vim.keymap.set('n', '<leader>re', '<cmd>RustLsp explainError<CR>', 
            { buffer = bufnr, desc = '[R]ust [E]xplain error' })
          vim.keymap.set('n', '<leader>rr', '<cmd>RustLsp runnables<CR>',
            { buffer = bufnr, desc = '[R]ust [R]unnables' })
          vim.keymap.set('n', '<leader>rd', '<cmd>RustLsp debuggables<CR>',
            { buffer = bufnr, desc = '[R]ust [D]ebuggables' })
          vim.keymap.set('n', '<leader>rm', '<cmd>RustLsp expandMacro<CR>',
            { buffer = bufnr, desc = '[R]ust expand [M]acro' })
        end,
        default_settings = {
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
              buildScripts = {
                enable = true,
              },
            },
            checkOnSave = {
              command = 'clippy',
            },
            procMacro = {
              enable = true,
            },
          },
        },
      },
      -- DAP settings (auto-configured)
      dap = {},
    }
  end,
}
```

---

## Should You Upgrade to Neovim 0.12+?

### Pros:
- ✓ Better Rust experience with rustaceanvim
- ✓ Improved LSP performance
- ✓ Better Treesitter integration
- ✓ Access to latest Neovim features

### Cons:
- ✗ Need to test all plugins for compatibility
- ✗ Some plugins may not support 0.12 immediately
- ✗ Breaking changes may require config updates

### How to Check Your Current Version:
```bash
nvim --version | head -1
```

---

## Summary

| Aspect | Keep Current Setup | Upgrade to 0.12 + rustaceanvim |
|--------|-------------------|--------------------------------|
| **lazy.nvim** | Keep it | Keep it (don't switch to built-in) |
| **rust-analyzer** | Works great | Works great + easier config |
| **Debugging** | Manual setup | Automatic setup |
| **Extra features** | Basic LSP | Runnables, macro expansion, test integration |
| **Maintenance** | More manual config | Less manual config |

**Bottom Line:** If you're happy with your current setup, no rush to upgrade. But when you do upgrade to Neovim 0.12+, rustaceanvim will give you a better Rust development experience with less configuration.

---

## Checking Plugin Compatibility Before Upgrading

Before upgrading Neovim, check if your plugins support 0.12:

```bash
# Check plugins that might have version requirements
cd ~/.local/share/nvim/lazy/
for dir in */; do
  cd "$dir"
  if git log --all --grep="0.12\|nvim_0_12" --oneline | head -1 > /dev/null 2>&1; then
    echo "✓ ${dir%/} mentions 0.12"
  fi
  cd ..
done
```

Or check each plugin's README for minimum Neovim version requirements.

---

## Questions?

- **"Should I upgrade now?"** → Only if you need features from 0.12
- **"Will my config break?"** → Probably not, but test in a VM first
- **"Do I need rustaceanvim?"** → No, but it's nicer once you have 0.12+
- **"Can I keep lazy.nvim?"** → Yes! Don't switch to built-in packages

---

Last updated: 2026-06-10
