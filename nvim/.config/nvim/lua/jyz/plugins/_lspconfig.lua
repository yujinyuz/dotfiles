local lspconfig = require('lspconfig')
local helpers = require('jyz.lib.nvim_helpers')

-- When in need of help, just check documentation via :h lsp

local on_attach = function(client)
  local resolved_capabilities = client.resolved_capabilities

  helpers.create_mappings({
    n = {
      {lhs = 'gD', rhs = helpers.cmd_map([[lua vim.lsp.buf.declaration()]]), opts = {noremap = true, silent = true}},
      {lhs = 'gd', rhs = helpers.cmd_map([[lua vim.lsp.buf.definition()]]), opts = {noremap = true, silent = true}},
      {lhs = 'ga', rhs = helpers.cmd_map([[lua vim.lsp.buf.code_action()]]), opts = {noremap = true, silent = true}},
      {lhs = 'K', rhs = helpers.cmd_map([[lua vim.lsp.buf.hover()]]), opts = {noremap = true, silent = true}},
      {lhs = 'gi', rhs = helpers.cmd_map([[lua vim.lsp.buf.implementation()]]), opts = {noremap = true, silent = true}},
      {lhs = 'gr', rhs = helpers.cmd_map([[lua require'telescope.builtin'.lsp_references()]]), opts = {noremap = true, silent = true}},
      {lhs = '<leader>gr', rhs = helpers.cmd_map([[lua vim.lsp.buf.rename()]]), opts = {noremap = true, silent = true}},
      {lhs = '<leader>ld', rhs = helpers.cmd_map([[lua vim.lsp.diagnostic.show_line_diagnostics()]]), opts = {noremap = true, silent = true}},
      {lhs = '<C-s>', rhs = helpers.cmd_map([[lua vim.lsp.buf.signature_help()]]), opts = {noremap = true, silent = true}},
      {lhs = '<leader>lf', rhs = helpers.cmd_map([[lua vim.lsp.buf.formatting()]]), opts = {noremap = true, silent = true}},
      {lhs = ']w', rhs = helpers.cmd_map([[lua vim.lsp.diagnostic.goto_next()]]), opts = {noremap = true}},
      {lhs = '[w', rhs = helpers.cmd_map([[lua vim.lsp.diagnostic.goto_prev()]]), opts = {noremap = true}},
    },
    i = {
      {lhs = '<C-s>', rhs = helpers.cmd_map([[lua vim.lsp.buf.signature_help()]]), opts = {noremap = true, silent = true}},
    }
  }, 0)

  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  local buf_autocmds = {
    {
      events = {'CursorHold'},
      targets = {'<buffer>'},
      command = [[lua vim.lsp.diagnostic.show_line_diagnostics()]],
    }
  }

  if resolved_capabilities.documentFormatting then
    table.insert(buf_autocmds, {
      events = {'CursorHold', 'CursorHoldI'},
      targets = {'<buffer>'},
      command = [[lua vim.lsp.diagnostic.show_line_diagnostics()]]
    })

    table.insert(buf_autocmds, {
      events = {'CursorMoved'},
      targets = {'<buffer>'},
      command = [[lua vim.lsp.util.buf_clear_references()]]
    })
  end

  helpers.augroup('LspCallbacks',  buf_autocmds)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
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
    virtual_text = {
      spacing = 2,
      severity_limit = "Warning",
    },
    signs = false,
    update_in_insert = false,
    underline = true
  }
)

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end
local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local servers = {
  vimls = {},
  tsserver = {},
  jsonls = {},
  jedi_language_server = {},
  -- pyls_ms = {},
  -- pyright = {},
  sumneko_lua = {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          globals = { 'vim' }
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          }
        }
      }
    }
  },
}

local prettier = require('jyz.efm.prettier')
local eslint = require('jyz.efm.eslint')
local autopep8 = require('jyz.efm.autopep8')
local isort = require('jyz.efm.isort')
local flake8 = require('jyz.efm.flake8')
local jq = require('jyz.efm.jq')

local languages = {
  typescript = {prettier, eslint},
  javascript = {prettier, eslint},
  python = {isort, autopep8, flake8},
  json = {jq},
  -- css = {prettier},
  -- html = {prettier},
}

local efm = {
  init_options = {
    documentFormatting = true,
  },
  settings = {
    rootMarkers = {".git/"},
    languages = languages,
  },
  filetypes = vim.tbl_keys(languages),
}

servers.efm = efm



for server, config in pairs(servers) do
  config.on_attach = on_attach
  config.on_init = function(client)
    print('LSP: ' .. client.name .. ' started')
  end
  lspconfig[server].setup(config)
end
