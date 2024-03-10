local utils = require('my.utils')

local M = {}

M.auto_format = true

function M.format()
  require('conform').format { async = true, lsp_fallback = true }
end

function M.toggle()
  M.auto_format = not M.auto_format
  if M.auto_format then
    utils.info('enabled format on save', 'Toggle')
  else
    utils.warn('disabled format on save', 'Toggle')
  end
end

return M
