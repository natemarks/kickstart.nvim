local function run_git(command)
  return function()
    vim.cmd('Git ' .. command)
  end
end

local function input_git(opts)
  return function()
    vim.ui.input({ prompt = opts.prompt, default = opts.default }, function(value)
      if not value or value == '' then
        return
      end

      vim.cmd('Git ' .. opts.command_prefix .. ' ' .. value)
    end)
  end
end

local function discard_current_file()
  local filename = vim.api.nvim_buf_get_name(0)
  if filename == '' then
    vim.notify('No file in current buffer', vim.log.levels.WARN)
    return
  end

  local confirmed = vim.fn.confirm('Discard all changes in this file and restore from HEAD?', '&No\n&Yes', 1)
  if confirmed ~= 2 then
    return
  end

  vim.cmd 'Git restore --worktree -- %'
  vim.cmd 'edit!'
end

return {
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'Gdiffsplit', 'Gvdiffsplit' },
    keys = {
      { '<leader>gg', '<cmd>Git<CR>', desc = '[G]it status' },
      { '<leader>gs', '<cmd>Git add %<CR>', desc = '[G]it [S]tage file' },
      { '<leader>gS', '<cmd>Git add -p -- %<CR>', desc = '[G]it [S]tage hunk (patch)' },
      { '<leader>gc', '<cmd>Git commit -v<CR>', desc = '[G]it [C]ommit (verbose diff)' },
      { '<leader>gC', '<cmd>Git commit --amend<CR>', desc = '[G]it amend last [C]ommit' },
      { '<leader>gb', input_git { prompt = 'Switch to branch: ', command_prefix = 'switch' }, desc = '[G]it [B]ranch checkout' },
      { '<leader>gB', input_git { prompt = 'Create and switch to branch: ', command_prefix = 'switch -c' }, desc = '[G]it create [B]ranch' },
      { '<leader>gp', run_git 'push', desc = '[G]it [P]ush' },
      { '<leader>gu', run_git 'pull', desc = '[G]it p[U]ll' },
      { '<leader>gl', '<cmd>Git blame<CR>', desc = '[G]it b[L]ame file' },
      { '<leader>gd', '<cmd>Gdiffsplit<CR>', desc = '[G]it [D]iff split' },
      {
        '<leader>gr',
        input_git { prompt = 'Interactive rebase onto (default HEAD~3): ', default = 'HEAD~3', command_prefix = 'rebase -i' },
        desc = '[G]it interactive [R]ebase',
      },
      { '<leader>gX', discard_current_file, desc = '[G]it discard file changes (confirm)' },
    },
  },
}
