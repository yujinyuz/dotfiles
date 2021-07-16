local lspconfig = require('lspconfig')
local lspinstall = require('lspinstall')

local nnoremap = vim.keymap.nnoremap
local inoremap = vim.keymap.inoremap
local vnoremap = vim.keymap.vnoremap

local augroup = require('modules.lib.nvim_helpers').augroup
local cmd = require('modules.lib.nvim_helpers').cmd_map

-- When in need of help, just check documentation via :h lsp
local on_attach = function(client)
  local resolved_capabilities = client.resolved_capabilities

  nnoremap {'gD', function() vim.lsp.buf.declaration() end, buffer = true}
  nnoremap {'gd', function() vim.lsp.buf.definition() end, buffer = true}

  nnoremap {'<leader>gd', function() vim.cmd [[Lspsaga preview_definition]] end, buffer = true}
  nnoremap {'ga', function() vim.cmd [[Lspsaga code_action]] end, buffer = true}
  nnoremap {'K', function() vim.lsp.buf.hover() end, buffer = true}

  nnoremap {'gi', function () vim.lsp.buf.implementation() end, buffer = true}

  nnoremap {'gr', function() vim.lsp.buf.references() end, buffer = true}
  -- nnoremap {'gr', cmd [[Lspsaga lsp_finder]], buffer = true}

  -- nnoremap {'<leader>gr', cmd [[Lspsaga rename]], buffer = true}
  nnoremap {'<leader>gr', function() vim.lsp.buf.rename() end, buffer = true}
  nnoremap {'<leader>ld', function() vim.cmd [[Lspsaga show_line_diagnostics]] end, buffer = true}
  nnoremap {'<C-s>', function() vim.lsp.buf.signature_help() end, buffer = true}
  inoremap {'<C-s>', function() vim.lsp.buf.signature_help() end, buffer = true}
  -- nnoremap {'<C-s>', cmd [[Lspsaga signature_help]], buffer = true}
  -- inoremap {'<C-s>', cmd [[Lspsaga signature_help]], buffer = true}

  nnoremap {'<leader>lf', function() vim.lsp.buf.formatting() end, buffer = true}

  nnoremap {']w', cmd [[Lspsaga diagnostic_jump_next]], buffer = true}
  nnoremap {'[w', cmd [[Lspsaga diagnostic_jump_prev]], buffer = true}

  vnoremap {'ga', cmd [[<C-u>Lspsaga range_code_action]], buffer = true}

  nnoremap {'<leader>lr', cmd [[LspRestart]], buffer = true}

  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  local buf_autocmds = {
    {
      events = {'CursorHold'},
      targets = {'<buffer>'},
      command = [[lua require('lspsaga.diagnostic').show_line_diagnostics()]],
    },
  }

  if resolved_capabilities.documentFormatting then
    table.insert(
      buf_autocmds, {
        events = {'CursorHold', 'CursorHoldI'},
        targets = {'<buffer>'},
        command = [[lua require('lspsaga.diagnostic').show_line_diagnostics()]],
        -- command = [[lua vim.lsp.diagnostic.show_line_diagnostics()]]
      }
    )

    table.insert(
      buf_autocmds, {
        events = {'CursorMoved'},
        targets = {'<buffer>'},
        command = [[lua vim.lsp.util.buf_clear_references()]],
      }
    )
  end

  -- allow_incremental_sync (bool, default false): Allow using on_line callbacks for lsp
  if client.config.flags then client.config.flags.allow_incremental_sync = true end

  augroup('LspCallbacks', buf_autocmds)
end

-- vim.lsp.handlers["textDocument/hover"] = require('lspsaga.hover').handler
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- underline = false,
    -- virtual_text = false,
    -- signs = true,
    -- update_in_insert = false,
    -- virtual_text = {
    --   prefix = "»",
    --   spacing = 4,
    -- },
    -- virtual_text = true,
    virtual_text = {spacing = 2, severity_limit = 'Error'},
    signs = false,
    update_in_insert = false,
    underline = true,
  }
)

local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {'vim'},
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
  },
}

local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
    on_init = function(client) print('LSP: ' .. client.name .. ' started') end,
    flags = {debounce_text_changes = 150},
  }
end

lspinstall.setup()
local servers = lspinstall.installed_servers()


for _, lang in pairs(servers) do
  local config = make_config()

  if lang == 'lua' then
    config.settings = lua_settings
    -- config = require('lua-dev').setup(config)
     -- config.settings = require('lua-dev').setup({}).settings
  end

  if lang == 'typescript' then
    config.on_attach = function(client)
      -- https://jose-elias-alvarez.medium.com/configuring-neovims-lsp-client-for-typescript-development-5789d58ea9c
      -- disable document formatting for typescript so it doesn't conflict with eslint/prettier
      client.resolved_capabilities.document_formatting = false
      on_attach(client)
    end
  end

  if lang == 'efm' then
    local prettier = require('modules.lsp.efm.prettier')
    local eslint = require('modules.lsp.efm.eslint')
    local autopep8 = require('modules.lsp.efm.autopep8')
    local isort = require('modules.lsp.efm.isort')
    local flake8 = require('modules.lsp.efm.flake8')
    local jq = require('modules.lsp.efm.jq')
    local luafmt = require('modules.lsp.efm.luafmt')
    local misspell = require('modules.lsp.efm.misspell')

    local languages = {
      ['='] = {misspell},
      lua = {luafmt},
      typescript = {prettier, eslint},
      javascript = {prettier, eslint},
      python = {isort, autopep8, flake8},
      json = {jq},
    }
    config.init_options = {documentFormatting = true, gotoDefinition = false}

    config.settings = {
      languages = languages,
      lintDebounce = 0.5 * (1000 * 1000 * 1000), -- coz go uses nanoseconds instead of milliseconds
    }
    config.filetypes = vim.tbl_keys(languages)
  end

  lspconfig[lang].setup(config)
end
