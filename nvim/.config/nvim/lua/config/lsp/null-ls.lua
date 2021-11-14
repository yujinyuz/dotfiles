local M = {}

function M.setup(options)
  local nls = require('null-ls')
  local sources = {
    nls.builtins.formatting.prettierd,
    -- nls.builtins.formatting.prettier,
    nls.builtins.formatting.eslint_d,
    nls.builtins.formatting.black,
    nls.builtins.formatting.codespell.with({ filetypes = { 'markdown', 'txt' } }),
    nls.builtins.formatting.reorder_python_imports,
    -- nls.builtins.formatting.isort,
    nls.builtins.formatting.stylua,
    nls.builtins.diagnostics.codespell.with({ filetypes = { 'markdown', 'txt' } }),
    nls.builtins.formatting.fish_indent,
    nls.builtins.formatting.fixjson.with({ filetypes = { 'jsonc' } }),
    -- nls.builtins.diagnostics.write_good,
    nls.builtins.diagnostics.flake8,
    nls.builtins.diagnostics.eslint.with({ command = 'eslint_d' }),
    -- nls.builtins.diagnostics.eslint,
    nls.builtins.code_actions.gitsigns,
  }

  nls.config({
    debounce = 150,
    save_after_format = false,
    sources = sources,
  })
  require('lspconfig')['null-ls'].setup(options)
end

function M.has_formatter(ft)
  local sources = require('null-ls.sources')
  local all_sources = sources.get_all()
  local formatting_method = require('null-ls.methods').internal.FORMATTING

  for _, source in ipairs(all_sources) do
    if sources.is_available(source, ft, formatting_method) then
      return true
    end
  end
end

return M
