require('config.lsp.diagnostics').setup()

local on_attach = function(client, bufnr)
  require('config.lsp.formatting').setup(client, bufnr)
  require('config.lsp.keys').setup(client, bufnr)
  -- FIXME: This has prevented me from upgrading to 0.5.1
  -- require('config.lsp.completion').setup(client, bufnr)

  -- TypeScript specific stuff
  require('config.lsp.ts-utils').setup(client)
end

local servers = {
  pyright = {
    settings = {
      python = {
        analysis = {
          diagnosticMode = 'openFilesOnly',
        },
      },
    },
  },
  html = {},
  cssls = {},
  jsonls = {},
  tsserver = {},
  sumneko_lua = require('lua-dev').setup(),
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local options = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

require('config.lsp.null-ls').setup(options)
require('config.lsp.install').setup(servers, options)
