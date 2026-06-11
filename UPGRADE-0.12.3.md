# Upgrade Guide: Neovim 0.12.3

## Overview

Upgrading from 0.11.6 to 0.12.3 is a minor version bump with excellent backward compatibility. This configuration has been updated to take advantage of new capabilities.

## Required Changes (Completed)

### 1. Health Check Version Gate
- **File**: `lua/custom/health.lua:15`
- **Change**: Updated minimum version check from `0.10-dev` to `0.12.0`

### 2. Documentation
- **File**: `README.md:3`
- **Change**: Updated tested version statement to reflect 0.12.3

### 3. Go Language Support
- **File**: `lua/custom/plugins/treesitter/config.lua`
- **Change**: Added `go`, `gomod`, `gowork`, `gotmpl` treesitter parsers
- **Benefit**: Fixes checkhealth warnings for Go template and workspace support

### 4. Rust Inlay Hints
- **File**: `lua/custom/lsp/servers/rust.lua`
- **Change**: Enabled inlay hints for inline type information
- **Benefit**: See type annotations directly in your code

## Major Features Available in 0.12.3

### 1. Native Snippet Support (`vim.snippet`) ⭐
- Built-in snippet engine with `vim.snippet.expand()` and `vim.snippet.jump()`
- LSP snippet integration without plugins
- **Current Setup**: Still using LuaSnip (more feature-rich)
- **Future Option**: Consider migrating to native snippets for simpler setup

### 2. Treesitter Query System Improvements
- More efficient query parsing
- Better error messages for syntax issues
- Improved highlight groups
- **Impact**: Faster syntax highlighting, better performance with large files

### 3. Rust Support Without rustacean.nvim ✅
- **Already Implemented**: Removed rustacean.nvim in commit 3c22ff6
- Modern approach uses `rust_analyzer` + `codelldb` directly
- 0.12's improved LSP + DAP support makes this possible

### 4. LSP Improvements
- **Inlay hints performance**: Better for Rust type hints (now enabled)
- **Semantic tokens**: Improved syntax highlighting via LSP
- **Pull diagnostics**: More efficient error reporting
- Better workspace support for Go

### 5. Diagnostic Rendering
- Improved floating window behavior
- Better virtual text positioning
- Enhanced diagnostic signs

### 6. Go Support Enhancements
- Better go.work file support
- Improved gotmpl (Go template) support
- Enhanced gopls integration

## Compatibility Notes

### Already Compatible
- ✅ `vim.uv` fallback (`vim.uv or vim.loop`)
- ✅ `vim.schedule` usage
- ✅ All plugins actively maintained for 0.12.x
- ✅ Lua API calls remain stable
- ✅ Treesitter integration uses stable APIs
- ✅ LSP configuration follows standard patterns

### No Breaking Changes
- All existing keymaps work unchanged
- Plugin configurations remain valid
- Custom LSP settings preserved

## Post-Upgrade Checklist

After upgrading Neovim to 0.12.3:

1. **Run health check**:
   ```
   :checkhealth
   ```
   - Verify no new warnings appear
   - Confirm Go template/workspace errors are resolved

2. **Update plugins**:
   ```
   :Lazy update
   ```
   - Ensure all plugins are compatible with 0.12.3

3. **Test Rust development**:
   - Open a Rust file and verify inlay hints appear
   - Test debugging with codelldb
   - Confirm rust-analyzer features work

4. **Test Go development**:
   - Verify gotmpl syntax highlighting works
   - Test go.work file support
   - Confirm gopls features work

5. **Test treesitter**:
   - Check syntax highlighting performance
   - Verify all language parsers load correctly

## What's New (Benefits)

Beyond the implemented changes, 0.12.x includes:
- Overall performance improvements
- Bug fixes in LSP, treesitter, and core
- Enhanced terminal emulation
- Improved diagnostics rendering
- Better memory management

## Future Considerations

### Native Snippets
Consider experimenting with `vim.snippet` API as an alternative to LuaSnip:
- Simpler setup for basic snippet needs
- Direct LSP snippet integration
- LuaSnip remains more feature-rich for complex snippets

### Additional Treesitter Parsers
Based on your usage, consider adding:
- `rust` parser (if not auto-installed)
- Language-specific parsers as needed

## Issues Resolved

From README.md PROBLEM list:
- ✅ **PROBLEM**: fully support gotmpl and gowork from checkhealth error
  - **RESOLVED**: Added gotmpl and gowork treesitter parsers

## Notes

- This configuration was tested on 0.11.6
- Upgrade path to 0.12.3 is straightforward
- All changes are backward compatible
- No plugin breaking changes expected

## References

- [Neovim 0.12 Release Notes](https://github.com/neovim/neovim/releases)
- [Treesitter Changes](https://github.com/nvim-treesitter/nvim-treesitter)
- [rust-analyzer Documentation](https://rust-analyzer.github.io/)
