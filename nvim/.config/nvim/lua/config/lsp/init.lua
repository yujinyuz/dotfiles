require('config.lsp.diagnostics').setup()

-- Workaround to handle pyright: Unsupported command or any other commands that are sent
-- from null-ls to other lsp clients
-- @see https://github.com/jose-elias-alvarez/null-ls.nvim/issues/197#issuecomment-922792992
local default_exe_handler = vim.lsp.handlers['workspace/executeCommand']
vim.lsp.handlers['workspace/executeCommand'] = function(err, result, ctx, config)
  -- supress NULL_LS error msg
  local prefix = 'NULL_LS'

  if err and ctx.params.command:sub(1, #prefix) == prefix then
    return
  end

  return default_exe_handler(err, result, ctx, config)
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

local on_attach = function(client, bufnr)
  require('config.lsp.formatting').setup(client, bufnr)
  require('config.lsp.keys').setup(client, bufnr)

  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
  end

  -- Because some LSPs can have other possible values
  --    e.g. pyright has `client.server_capabilities.definitionProvider = { workDoneProgress = true}`
  --    and sumneko_lua has `client.server_capabilities.definitionProvider = true`
  -- we will just check if it's not false before setting tagfunc
  if client.server_capabilities.definitionProvider ~= false then
    vim.bo.tagfunc = 'v:lua.vim.lsp.tagfunc'
  end
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
  gopls = {},
  html = {},
  cssls = {},
  emmet_ls = {},
  tailwindcss = {},
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
  sumneko_lua = require('lua-dev').setup {},
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.foldRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

local options = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}


require('nvim-lsp-installer').setup {
  ensure_installed = vim.tbl_keys(servers),
}

for server, config in pairs(servers) do
  local opts = vim.tbl_deep_extend('force', options, config or {})
  require('lspconfig')[server].setup(opts)
end


require('config.lsp.null-ls').setup(options)
