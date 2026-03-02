local M = {}

M.commands = {
  'LazyGit',
  'LazyGitConfig',
  'LazyGitCurrentFile',
  'LazyGitFilter',
  'LazyGitFilterCurrentFile',
}

M.dependencies = {
  'nvim-lua/plenary.nvim',
}

function M.setup()
  -- lazygit.nvim does not require setup by default.
end

return M
