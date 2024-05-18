local utils = require('my.utils')

local M = {}

M._enabled = true

function M.is_enabled(bufnr)
  -- If the file is not in the ~/Sources directory, do not autoformat.
  -- If there is a .disable-autoformat file in the root of the project, do not autoformat.
  -- Otherwise, return the value of M._enabled

  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(bufnr)

  -- Only perform autoformat it the file is in the ~/Sources directory
  if not bufname:match('/Sources/') then
    return false
  end

  -- Check if there is a .disable-autoformat file in the root of the project
  local disable_autoformat =
    not vim.tbl_isempty(vim.fs.find('.disable-autofmt', { upward = true, path = vim.fs.dirname(bufname) }))

  if disable_autoformat then
    return false
  end

  return M._enabled
end

function M.format()
  -- This will format the code even when not enabled
  require('conform').format { async = true, lsp_fallback = true }
end

function M.toggle()
  M._enabled = not M._enabled
  if M._enabled then
    utils.info('enabled format on save', 'Toggle')
  else
    utils.warn('disabled format on save', 'Toggle')
  end
end

return M
