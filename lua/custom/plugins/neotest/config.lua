local M = {}

function M.setup()
  local function resolve_python()
    local project_venv = vim.fn.getcwd() .. '/.venv/bin/python'
    if vim.fn.executable(project_venv) == 1 then
      return project_venv
    end

    local pyenv_venv = vim.fn.expand '$VIRTUAL_ENV/bin/python'
    if pyenv_venv ~= '/bin/python' and vim.fn.executable(pyenv_venv) == 1 then
      return pyenv_venv
    end

    local python3 = vim.fn.exepath 'python3'
    if python3 ~= '' then
      return python3
    end

    local python = vim.fn.exepath 'python'
    if python ~= '' then
      return python
    end

    return 'python3'
  end

  require('neotest').setup {
    adapters = {
      require 'neotest-python' {
        dap = { justMyCode = false },
        runner = 'pytest',
        python = resolve_python,
        pytest_discover_instances = true,
      },
      require 'neotest-go',
      require 'neotest-plenary',
    },
  }
end

return M
