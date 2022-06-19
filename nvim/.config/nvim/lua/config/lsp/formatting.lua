local utils = require('utils')

local M = {}

M.autoformat = false

function M.toggle()
  M.autoformat = not M.autoformat
  if M.autoformat then
    utils.info('enabled format on save', 'Toggle')
  else
    utils.warn('disabled format on save', 'Toggle')
  end
end

function M.format()
  if M.autoformat then
    vim.lsp.buf.formatting_sync(nil, 1000)
  end
end

function M.setup(client, buf)
  local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
  local nls = require('config.lsp.null-ls')

  local enable = false

  -- If both null-ls and X-LSP server have formatters, let's disable X-LSP's document_formatting
  if nls.has_formatter(ft) then
    enable = client.name == 'null-ls'
  end

  client.server_capabilities.documentFormattingProvider = enable
  client.server_capabilities.documentRangeFormattingProvider = enable

  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = { '*' },
      callback = M.format,
      group = 'IDECallbacks',
    })
  end
end

return M
