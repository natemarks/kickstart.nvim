local M = {}

-- nvim-treesitter `main` only installs parsers and queries; Neovim does the
-- highlighting and indent, started per buffer in the FileType autocmd below.
-- go/rust/python are needed by the neotest adapters and the LSP setup.
M.parsers = { 'bash', 'c', 'diff', 'go', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'python', 'query', 'rust', 'vim', 'vimdoc' }

function M.setup()
  local ts = require 'nvim-treesitter'
  ts.setup { install_dir = vim.fn.stdpath 'data' .. '/site' }

  -- building parsers needs the tree-sitter CLI (>= 0.26.1) and a C compiler
  if vim.fn.executable 'tree-sitter' == 1 then
    ts.install(M.parsers)
  else
    vim.schedule(function()
      vim.notify("nvim-treesitter: 'tree-sitter' CLI not found; run `make treesitter_cli` in the dotfiles repo", vim.log.levels.WARN)
    end)
  end

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('custom-treesitter-start', { clear = true }),
    callback = function(args)
      if pcall(vim.treesitter.start, args.buf) then
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })
end

return M
