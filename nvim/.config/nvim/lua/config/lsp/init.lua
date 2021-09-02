local nvim_lsp = require('lspconfig')
local utils = require('utils')

require('config.lsp.diagnostics').setup()

local on_attach = function(client, bufnr)
  require('config.lsp.formatting').setup(client, bufnr)
  require('config.lsp.keys').setup(client, bufnr)
  require('config.lsp.completion').setup(client, bufnr)

  -- TypeScript specific stuff
  require('config.lsp.ts-utils').setup(client)
end

local lua_cmd = {vim.env.HOME .. '/.local/share/nvim/lspinstall/lua/./sumneko-lua-language-server' }

local servers = {
  pyright = {},
  html = {
    init_options = {
      provideFormatter = true,
    },
    root_dir = require'lspconfig'.util.root_pattern(".git", vim.fn.getcwd()),
  },
  cssls = {
    root_dir = require'lspconfig'.util.root_pattern(".git", vim.fn.getcwd()),
    init_options = {
      provideFormatter = true,
    }
  },
  ['null-ls'] = {},
  -- sumneko_lua = { { cmd = lua_cmd } },
  sumneko_lua = require('lua-dev').setup({
    lspconfig = { cmd = lua_cmd },
  }),
  tsserver = {},
  jsonls = {
    init_options = {
      provideFormatter = true,
    },
    root_dir = require'lspconfig'.util.root_pattern(".git", vim.fn.getcwd()),
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

require('config.lsp.null-ls').setup()

for server, config in pairs(servers) do
  nvim_lsp[server].setup(vim.tbl_deep_extend('force', {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
  }, config))

  local cfg = nvim_lsp[server]
  if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
    utils.error(server .. ': cmd not found: ' .. vim.inspect(cfg.cmd))
  end
  -- end
end
