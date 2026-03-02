local M = {}

function M.get()
  return {
    { '<leader>vv', '<cmd>LazyGit<cr>', desc = 'Open lazy git' },
  }
end

return M
