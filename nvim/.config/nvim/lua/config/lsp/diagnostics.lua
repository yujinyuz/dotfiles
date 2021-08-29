-- My settings
-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     -- underline = false,
--     -- virtual_text = false,
--     -- signs = true,
--     -- update_in_insert = false,
--     -- virtual_text = {
--     --   prefix = "»",
--     --   spacing = 4,
--     -- },
--     -- virtual_text = true,
--     virtual_text = {spacing = 2, severity_limit = 'Error'},
--     signs = false,
--     update_in_insert = false,
--     underline = true,
--   }
-- )
local M = {}

M.setup = function()
  -- Automatically update diagnostics
  -- from folke/dot
  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = '●' },
    severity_sort = true,
  })

  local signs = { Error = ' ', Warning = ' ', Hint = ' ', Information = ' ' }

  for type, icon in pairs(signs) do
    local hl = 'LspDiagnosticsSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
  end
end

return M
