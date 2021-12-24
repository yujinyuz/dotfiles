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
    vim.lsp.buf.formatting_sync()
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

  client.resolved_capabilities.document_formatting = enable
  -- format on save
  if client.resolved_capabilities.document_formatting then
    vim.cmd([[
      augroup LspFormatCallback
        autocmd!
        autocmd BufWritePre * lua require('config.lsp.formatting').format()
      augroup END
    ]])
  end
end

return M
