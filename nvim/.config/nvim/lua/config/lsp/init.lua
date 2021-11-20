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
  jsonls = {
    settings = {
      json = {
        -- Schemas https://www.schemastore.org
        schemas = {
          {
            fileMatch = { 'package.json' },
            url = 'https://json.schemastore.org/package.json',
          },
          {
            fileMatch = { 'tsconfig*.json' },
            url = 'https://json.schemastore.org/tsconfig.json',
          },
          {
            fileMatch = {
              '.prettierrc',
              '.prettierrc.json',
              'prettier.config.json',
            },
            url = 'https://json.schemastore.org/prettierrc.json',
          },
          {
            fileMatch = { '.eslintrc', '.eslintrc.json' },
            url = 'https://json.schemastore.org/eslintrc.json',
          },
          {
            fileMatch = { '.babelrc', '.babelrc.json', 'babel.config.json' },
            url = 'https://json.schemastore.org/babelrc.json',
          },
          {
            fileMatch = { 'lerna.json' },
            url = 'https://json.schemastore.org/lerna.json',
          },
          {
            fileMatch = { 'now.json', 'vercel.json' },
            url = 'https://json.schemastore.org/now.json',
          },
          {
            fileMatch = {
              '.stylelintrc',
              '.stylelintrc.json',
              'stylelint.config.json',
            },
            url = 'http://json.schemastore.org/stylelintrc.json',
          },
        },
      },
    },
  },
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
