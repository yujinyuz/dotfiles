local has_nls, nls = pcall(require, 'null-ls')

if not has_nls then
  return
end

local sources = {
  nls.builtins.formatting.prettierd,
  nls.builtins.formatting.djhtml.with { extra_args = { '--tabwidth', '2' } },
  -- nls.builtins.formatting.prettier,
  nls.builtins.formatting.eslint_d,
  nls.builtins.formatting.black,
  nls.builtins.formatting.codespell.with { filetypes = { 'markdown', 'txt' } },
  nls.builtins.formatting.reorder_python_imports,
  nls.builtins.formatting.taplo,
  nls.builtins.formatting.fish_indent,
  -- nls.builtins.formatting.isort,
  nls.builtins.formatting.stylua,
  nls.builtins.diagnostics.codespell.with { filetypes = { 'markdown', 'txt' } },
  nls.builtins.formatting.fish_indent,
  nls.builtins.formatting.fixjson.with { filetypes = { 'jsonc' } },
  -- nls.builtins.diagnostics.write_good,
  nls.builtins.diagnostics.flake8,
  nls.builtins.diagnostics.eslint.with { command = 'eslint_d' },
}

nls.setup {
  sources = sources,
  on_attach = function(client, bufnr)
    local opts = {
      silent = true,
      buffer = bufnr,
    }

    if client.server_capabilities.documentFormattingProvider then
      vim.keymap.set('n', '<leader>cf', function()
        vim.lsp.buf.formatting_seq_sync {}
      end, opts)
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      vim.keymap.set({ 'x', 'v' }, '<leader>cf', function()
        vim.lsp.buf.range_formatting()
      end, opts)
    end
  end,
}
