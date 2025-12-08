---@brief
---
--- https://github.com/microsoft/pyright
---
--- `pyright`, a static type checker and language server for python

-- This function is still useful for manually setting a non-standard python path.
local function set_python_path(path)
  local clients = vim.lsp.get_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = 'pyright',
  }
  for _, client in ipairs(clients) do
    local new_settings = {
      python = {
        pythonPath = path,
      },
    }
    client.config.settings = vim.tbl_deep_extend('force', client.config.settings, new_settings)
    client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
  end
end

return {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.git',
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
  on_attach = function(client, bufnr)
    -- START: New automatic venv detection
    -- This logic runs automatically when pyright attaches to a buffer.
    if client.config.root_dir then
      local venv_path = client.config.root_dir .. '/.venv/bin/python'
      -- Check if the venv path is an executable file
      if vim.fn.executable(venv_path) == 1 then
        -- Update the server settings with the correct pythonPath
        local new_settings = {
          python = {
            pythonPath = venv_path,
          },
        }
        client.config.settings = vim.tbl_deep_extend('force', client.config.settings, new_settings)
        -- Notify the server of the change
        client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
      end
    end
    -- END: New automatic venv detection

    -- Your existing user commands are preserved.
    
vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { 'source.organizeImports' },
          diagnostics = {},
        },
      })
    end, {
      desc = 'Organize Imports',
    })
    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', set_python_path, {
      desc = 'Reconfigure pyright with the provided python path',
      nargs = 1,
      complete = 'file',
    })
  end,
}
