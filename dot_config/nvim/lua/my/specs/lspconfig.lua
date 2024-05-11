local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
  return
end

local utils = require('my.utils')

-- Set up completion using nvim_cmp with LSP source
local common_capabilities = require('cmp_nvim_lsp').default_capabilities()
common_capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local common_on_init = function(client, _)
  -- Disabled due to https://github.com/neovim/neovim/issues/23164
  -- There has been a problem where there is a delay and then it changes the
  -- highlighting.
  client.server_capabilities.semanticTokensProvider = false
end

local common_on_attach_handler = function(client, bufnr)
  local opts = {
    buffer = bufnr,
    silent = true,
  }

  -- +lsp
  vim.keymap.set('n', '<leader>cla', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>clr', vim.lsp.buf.remove_workspace_folder, opts)

  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opts)
  vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, opts)

  if client.server_capabilities.definitionProvider ~= false then
    vim.opt_local.tagfunc = 'v:lua.vim.lsp.tagfunc'
  end

  if client.server_capabilities.documentSymbolProvider then
    local has_navic, navic = pcall(require, 'nvim-navic')
    if has_navic then
      navic.attach(client, bufnr)
    end
  end
end

-- Server config
local servers = {
  pyright = {
    enabled = false,
    settings = {
      pyright = {
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          -- Ignore all files for analysis to exclusively use Ruff for linting
          ignore = { '*' },
        },
      },
    },
  },
  basedpyright = {
    settings = {
      basedpyright = {
        disableOrganizeImports = true,
        -- https://github.com/DetachHead/basedpyright/issues/203
        typeCheckingMode = 'off',
      },
    },
  },
  jedi_language_server = {
    enabled = false,
    init_options = {
      completion = {
        disableSnippets = true,
      },
    },
  },
  ruff_lsp = {
    on_attach = function(client, bufnr)
      common_on_attach_handler(client, bufnr)
      client.server_capabilities.disableHoverProvider = false

      -- Create ruff commands
      vim.api.nvim_create_user_command('RuffAutoFix', function()
        vim.lsp.buf.execute_command {
          command = 'ruff.applyAutofix',
          arguments = {
            { uri = vim.uri_from_bufnr(0) },
          },
        }
      end, { desc = 'Ruff: Fix all auto-fixable problems' })

      vim.api.nvim_create_user_command('RuffOrganizeImports', function()
        vim.lsp.buf.execute_command {
          command = 'ruff.applyOrganizeImports',
          arguments = {
            { uri = vim.uri_from_bufnr(0) },
          },
        }
      end, { desc = 'Ruff: Format imports' })
    end,
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
        callSnippet = 'Disable',
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
  taplo = {},
}

local options = {
  enabled = true,
  on_init = common_on_init,
  on_attach = common_on_attach_handler,
  capabilities = common_capabilities,
  flags = {
    debounce_text_changes = 500, -- 150 seems to be the default by idk what this implies
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

-- Setup neoconfig before lspconfig
local has_neoconf, neoconf = pcall(require, 'neoconf')

if has_neoconf then
  neoconf.setup {}
end

for server, custom_cfg in pairs(servers) do
  local opts = vim.tbl_deep_extend('force', options, custom_cfg or {})
  if opts.enabled then
    lspconfig[server].setup(opts)
  end
end
