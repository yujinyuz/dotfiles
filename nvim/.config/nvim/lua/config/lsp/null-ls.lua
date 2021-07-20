local nls = require('null-ls')

local M = {}

local sources = {
  nls.builtins.formatting.prettierd,
  nls.builtins.formatting.eslint_d,
  nls.builtins.formatting.black,
  nls.builtins.formatting.isort,
  nls.builtins.formatting.stylua,
  nls.builtins.diagnostics.misspell,
  nls.builtins.diagnostics.write_good,
  nls.builtins.diagnostics.flake8,
  -- nls.builtins.diagnostics.eslint.with({command = "eslint_d"}),
  nls.builtins.code_actions.gitsigns,
}

function M.setup()
  nls.config({
    debounce = 150,
    save_after_format = false,
    sources = sources,
    -- sources = {
    --   -- nls.builtins.formatting.stylua,
    --   -- nls.builtins.diagnostics.shellcheck,
    --   -- nls.builtins.diagnostics.markdownlint,
    --   -- nls.builtins.diagnostics.selene,
    -- },
  })
end

function M.has_formatter(ft)
  local config = require('null-ls.config')
  local formatters = config.generators('NULL_LS_FORMATTING')
  for _, f in ipairs(formatters) do
    if vim.tbl_contains(f.filetypes, ft) then
      return true
    end
  end
end

return M
