local utils = require('utils')

local M = {}

M.autoformat = false

function M.toggle()
  M.autoformat = not M.autoformat
  if M.autoformat then
    utils.info('enabled format on save', 'Formatting')
  else
    utils.warn('disabled format on save', 'Formatting')
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
  local efm_formatted = {}
  -- local efm_formatted = require("config.lsp.efm").formatted_languages

  local enable = false
  if nls.has_formatter(ft) then
    enable = client.name == 'null-ls'
  elseif efm_formatted[ft] then
    enable = client.name == 'efm'
  else
    enable = not (client.name == 'efm' or client.name == 'null-ls')
  end

  client.resolved_capabilities.document_formatting = enable
  -- format on save
  if client.resolved_capabilities.document_formatting then
    aug('LspFormat', {
      { events = { 'BufWritePre' }, command = 'lua require("config.lsp.formatting").format()' },
    })
  end
end

return M
