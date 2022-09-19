local utils = require('my.utils')

local M = {}

M.auto_format = false
function M.format()
  if M.auto_format then
    vim.lsp.buf.formatting_seq_sync()
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

return M
