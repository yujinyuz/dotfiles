local utils = require('my.utils')

local M = {}

M.auto_format = false
function M.format()
  if M.auto_format then
    vim.lsp.buf.format()
  end
end

function M.toggle()
  M.auto_format = not M.auto_format
  if M.auto_format then
    utils.info('enabled lsp format on save', 'Toggle')
  else
    utils.warn('disabled lsp format on save', 'Toggle')
  end
end

function M.on_attach(client, bufnr)
  local opts = {
    silent = true,
    buffer = bufnr,
  }

  if client.server_capabilities.documentFormattingProvider then
    vim.keymap.set('n', '<leader>cf', function()
      vim.lsp.buf.format { timeout_ms = 5000 }
    end, opts)

    vim.opt_local.formatexpr = 'v:lua.vim.lsp.formatexpr()'

    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = { '*' },
      callback = M.format,
      group = 'IDECallbacks',
    })
  end
end

return M
