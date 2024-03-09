local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
  return
end

local utils = require('my.utils')

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local on_attach = function(client, bufnr)
  local opts = {
    buffer = bufnr,
    silent = true,
  }

  -- +actions
  vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', '<Cmd>FzfLua lsp_code_actions<CR>', opts)

  -- +lsp
  vim.keymap.set('n', '<leader>clc', utils.lsp_config, opts)
  vim.keymap.set('n', '<leader>cli', '<Cmd>LspInfo<CR>', opts)
  vim.keymap.set('n', '<leader>cla', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>clr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>clo', '<Cmd>LSoutlineToggle<CR>', opts)

  vim.keymap.set('n', 'gr', function()
    require('fzf-lua').lsp_references { ignore_current_line = true }
  end)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opts)
  vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, opts)

  vim.keymap.set({ 'n', 'v' }, 'K', vim.lsp.buf.hover, opts)

  if client.server_capabilities.definitionProvider ~= false then
    vim.opt_local.tagfunc = 'v:lua.vim.lsp.tagfunc'
  end

  if client.server_capabilities.documentSymbolProvider then
    local _, navic = pcall(require, 'nvim-navic')
    if navic then
      navic.attach(client, bufnr)
    end
  end
end

-- Diagnostic symbols in the sign column (gutter)
vim.fn.sign_define('DiagnosticSignError', { text = '✖', texthl = 'DiagnosticSignError', numhl = '' })
vim.fn.sign_define('DiagnosticSignHint', { text = '➤', texthl = 'DiagnosticSignHint', numhl = '' })
vim.fn.sign_define('DiagnosticSignInfo', { text = 'ℹ', texthl = 'DiagnosticSignInfo', numhl = '' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '⚠', texthl = 'DiagnosticSignWarn', numhl = '' })

vim.diagnostic.config {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 2, prefix = '●' },
  severity_sort = true,
  float = {
    source = 'always', -- or 'if_many'
  },
}

-- Server config
local servers = {
  -- pyright = {
  --   settings = {
  --     python = {
  --       analysis = {
  --         diagnosticMode = 'openFilesOnly',
  --       },
  --     },
  --   },
  -- },

  jedi_language_server = {
    init_options = {
      completion = {
        disableSnippets = true,
      },
    },
  },
  gopls = {},
  html = {},
  cssls = {},
  emmet_ls = {},
  tailwindcss = {},
  jsonls = {},
  tsserver = {},
  vuels = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      completion = {
        callSnippet = 'Replace',
      },
      -- https://github.com/LuaLS/lua-language-server/wiki/Formatter#json
      format = {
        enable = true,
        defaultConfig = {
          indent_style = 'space',
          indent_size = '2',
        },
      },
    },
  },
}

local options = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

local has_mason, mason = pcall(require, 'mason')

if has_mason then
  mason.setup {}
end

local has_mason_lspconfig, mason_lspconfig = pcall(require, 'mason-lspconfig')

if has_mason_lspconfig then
  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }
end

-- Setup neodev before lspconfig
local has_neodev, neodev = pcall(require, 'neodev')

if has_neodev then
  neodev.setup {}
end

for server, custom_cfg in pairs(servers) do
  local opts = vim.tbl_deep_extend('force', options, custom_cfg or {})
  lspconfig[server].setup(opts)
end
