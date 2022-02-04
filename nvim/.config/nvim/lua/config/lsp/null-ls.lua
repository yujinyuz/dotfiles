local M = {}

function M.setup(options)
  local nls = require('null-ls')
  local sources = {
    nls.builtins.formatting.prettierd,
    -- nls.builtins.formatting.prettier,
    nls.builtins.formatting.eslint_d,
    nls.builtins.formatting.black,
    nls.builtins.formatting.codespell.with { filetypes = { 'markdown', 'txt' } },
    nls.builtins.formatting.reorder_python_imports,
    -- nls.builtins.formatting.isort,
    nls.builtins.formatting.stylua,
    nls.builtins.diagnostics.codespell.with { filetypes = { 'markdown', 'txt' } },
    nls.builtins.formatting.fish_indent,
    nls.builtins.formatting.fixjson.with { filetypes = { 'jsonc' } },
    -- nls.builtins.diagnostics.write_good,
    nls.builtins.diagnostics.flake8,
    nls.builtins.diagnostics.eslint.with { command = 'eslint_d' },
    -- nls.builtins.diagnostics.eslint,
    nls.builtins.code_actions.gitsigns,
    nls.builtins.code_actions.refactoring,
  }

  local opts = vim.tbl_extend('force', options, { sources = sources })
  nls.setup(opts)
end

function M.has_formatter(ft)
  local sources = require('null-ls.sources')
  local formatting_method = require('null-ls.methods').internal.FORMATTING
  local available = sources.get_available(ft, formatting_method)
  return #available > 0
end

return M
