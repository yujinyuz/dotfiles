local lspconfig = require('lspconfig')
local completion = require('completion')
local helpers = require('jyz.lib.nvim_helpers')

-- When in need of help, just check documentation via :h lsp

local on_attach = function(client)
  local resolved_capabilities = client.resolved_capabilities
  completion.on_attach(client)

  helpers.create_mappings{
    n = {
      {lhs = 'gD', rhs = helpers.cmd_map([[lua vim.lsp.buf.declaration()]]), opts = {noremap = true, silent = true}},
      {lhs = 'gd', rhs = helpers.cmd_map([[lua vim.lsp.buf.definition()]]), opts = {noremap = true, silent = true}},
      {lhs = 'ga', rhs = helpers.cmd_map([[lua vim.lsp.buf.code_action()]]), opts = {noremap = true, silent = true}},
      {lhs = 'K', rhs = helpers.cmd_map([[lua vim.lsp.buf.hover()]]), opts = {noremap = true, silent = true}},
      {lhs = 'gi', rhs = helpers.cmd_map([[lua vim.lsp.buf.implementation()]]), opts = {noremap = true, silent = true}},
      {lhs = 'gr', rhs = helpers.cmd_map([[lua require'telescope.builtin'.lsp_references()]]), opts = {noremap = true, silent = true}},
      {lhs = '<leader>gr', rhs = helpers.cmd_map([[lua vim.lsp.buf.rename()]]), opts = {noremap = true, silent = true}},
      {lhs = '<leader>ld', rhs = helpers.cmd_map([[lua vim.lsp.diagnostic.show_line_diagnostics()]]), opts = {noremap = true, silent = true}},
    },
    i = {
      {lhs = '<C-s>', rhs = helpers.cmd_map([[lua vim.lsp.buf.signature_help()]]), opts = {noremap = true, silent = true}},
    }
  }

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
    virtual_text = {
      prefix = "»",
      spacing = 4,
    },
    signs = false,
    update_in_insert = false,
    underline = true
  }
)

local servers = {
  vimls = {},
  efm = {
    init_options = {
      documentFormatting = true,
    },
  },
  jsonls = {},
  jedi_language_server = {},
  -- pyls_ms = {},
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { 'vim', 'use', }
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

for server, config in pairs(servers) do
  config.on_attach = on_attach
  config.on_init = function()
    print('Language Protocol Server started!')
  end
  lspconfig[server].setup(config)
end

-- completion-lua
vim.g.completion_sorting = 'length'
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
vim.g.completion_chain_complete_list = {
  default = {
    default = {
      {complete_items = { 'lsp', 'tags' } },
      {complete_items = { 'buffers' } },
      {mode = '<c-p>'},
      {mode = '<c-n>'},
    },
    string = {
      { complete_items = { 'path' } },
    }
  }
}

vim.g.completion_matching_smart_case = 1
vim.g.completion_confirm_key = ""

helpers.create_mappings{
  i = {
    {lhs = '<Tab>', rhs = [[pumvisible() ? "\<C-n>": "\<Tab>"]], opts = {expr = true, silent = true}},
    {lhs = '<S-Tab>', rhs = [[pumvisible() ? "\<C-p>": "\<S-Tab>"]], opts = {expr = true, noremap = true, silent = true}},
    {lhs = '<C-Space>', rhs = [[<Plug>(completion_trigger)]], opts = {silent = true}},
    {lhs = '<CR>', rhs = [[pumvisible() ? complete_info()["selected"] != "-1" ? "\<Plug>(completion_confirm_completion)" : "\<C-e>\<CR>" : "\<CR>"]], opts = {expr = true, silent = true}}
  }
}
