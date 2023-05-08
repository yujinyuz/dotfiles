local has_nls, nls = pcall(require, 'null-ls')

if not has_nls then
  return
end

local sources = {

  nls.builtins.diagnostics.dotenv_linter,
  nls.builtins.diagnostics.fish,
  nls.builtins.diagnostics.hadolint,
  -- nls.builtins.diagnostics.write_good,

  -- Formatting
  nls.builtins.formatting.prettierd,
  nls.builtins.formatting.djhtml.with { extra_args = { '--tabwidth', '2' } },
  nls.builtins.formatting.eslint_d,
  nls.builtins.formatting.black,
  -- nls.builtins.formatting.codespell.with { filetypes = { 'markdown', 'txt' } },
  nls.builtins.formatting.reorder_python_imports,
  nls.builtins.formatting.taplo,
  nls.builtins.formatting.stylua,
  nls.builtins.formatting.fish_indent,
  nls.builtins.formatting.fixjson.with { filetypes = { 'jsonc' } },
  nls.builtins.formatting.ruff,

  -- Diagnostics
  -- nls.builtins.diagnostics.codespell.with { filetypes = { 'markdown', 'txt' } },
  nls.builtins.diagnostics.eslint.with { command = 'eslint_d' },
  nls.builtins.diagnostics.ruff,
}

local lsp_format = require('my.lsp-format')

nls.setup {
  sources = sources,
  on_attach = function(client, bufnr)
    lsp_format.on_attach(client, bufnr)
  end,
}
