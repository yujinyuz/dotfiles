-- local lspconfig = require("lspconfig")
local nvim_lsp = require('lspconfig')
local utils = require('utils')

require('config.lsp.diagnostics').setup()
require('config.lsp.kind').setup()

local on_attach = function(client, bufnr)
  utils.info(client.name, 'LSP')
  require('config.lsp.formatting').setup(client, bufnr)
  require('config.lsp.keys').setup(client, bufnr)
  require('config.lsp.completion').setup(client, bufnr)
  -- require("config.lsp.highlighting").setup(client)

  -- TypeScript specific stuff
  if client.name == 'typescript' or client.name == 'tsserver' then
    require('config.lsp.ts-utils').setup(client)
  end
end

local lua_cmd = { '/Users/trafalgar/.local/share/nvim/lspinstall/lua/./sumneko-lua-language-server' }

local servers = {
  pyright = {},
  ['null-ls'] = {},
  -- sumneko_lua  = { cmd = {sumneko_binary, '-E', sumneko_root .. '/main.lua'}  },
  sumneko_lua = require('lua-dev').setup({
    lspconfig = { cmd = lua_cmd },
  }),
  -- bashls = {},
  -- dockerls = {},
  tsserver = {},
  -- cssls = { cmd = { "css-languageserver", "--stdio" } },
  -- rnix = {},
  -- jsonls = { cmd = { "vscode-json-languageserver", "--stdio" } },
  -- html = { cmd = { "html-languageserver", "--stdio" } },
  -- clangd = {},
  -- gopls = {},
  -- intelephense = {},
  -- sumneko_lua = require("lua-dev").setup({
  --   -- library = { plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" } },
  --   lspconfig = { cmd = lua_cmd },
  -- }),
  -- efm = require("config.lsp.efm").config,
  -- vimls = {},
  -- tailwindcss = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

require('config.lsp.null-ls').setup()

for server, config in pairs(servers) do
  if not nvim_lsp[server] then
    utils.error('Warning ' .. server, 'Lsp Error')
  end

  nvim_lsp[server].setup(vim.tbl_deep_extend('force', {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }, config))

  local cfg = nvim_lsp[server]
  if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
    utils.error(server .. ': cmd not found: ' .. vim.inspect(cfg.cmd))
  end
  -- end
end
