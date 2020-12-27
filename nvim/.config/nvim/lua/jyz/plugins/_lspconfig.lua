local lspconfig = require('lspconfig')
local completion = require('completion')
local helpers = require('jyz.lib.nvim_helpers')
local set_keymap = helpers.set_keymap

-- When in need of help, just check documentation via :h lsp

local on_attach = function(client)
  local resolved_capabilities = client.resolved_capabilities
  completion.on_attach(client)

  local opts = {noremap = true, silent = true}
  set_keymap('n', 'gD', helpers.cmd_map([[lua vim.lsp.buf.declaration()]]), opts)
  set_keymap('n', 'gd', helpers.cmd_map([[lua vim.lsp.buf.definition()]]), opts)
  set_keymap('n', 'ga', helpers.cmd_map([[lua vim.lsp.buf.code_action()]]), opts)
  set_keymap('n', 'K', helpers.cmd_map([[lua vim.lsp.buf.hover()]]), opts)
  set_keymap('n', 'gi', helpers.cmd_map([[lua vim.lsp.buf.implementation()]]), opts)
  set_keymap('n', '<leader>gr', helpers.cmd_map([[lua vim.lsp.buf.rename()]]), opts)
  set_keymap('n', 'gr', helpers.cmd_map([[lua require'telescope.builtin'.lsp_references()]]), opts)
  set_keymap('n', '<leader>ld', helpers.cmd_map([[lua vim.lsp.diagnostic.show_line_diagnostics()]]), opts)

  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  vim.cmd([[augroup LSPCallbacks]])
  vim.cmd([[autocmd!]])
  vim.cmd([[autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()]])
  if resolved_capabilities.document_highlight then
    vim.cmd([[autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()]])
    vim.cmd([[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]])
    vim.cmd([[autocmd CursorMoved <buffer> lua vim.lsp.util.buf_clear_references()]])
  end
  vim.cmd([[augroup END]])
end


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
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
  jsonls = {},
  -- jedi_language_server = {},
  pyls_ms = {},
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
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

set_keymap('i', '<Tab>', [[pumvisible() ? "\<C-n>": "\<Tab>"]], {expr = true, noremap = true, silent = true})
set_keymap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>": "\<S-Tab>"]], {expr = true, noremap = true, silent = true})
set_keymap('i', '<C-Space>', [[<Plug>(completion_trigger)]], {silent = true})
set_keymap(
  'i',
  '<CR>',
  [[ pumvisible() ? complete_info()["selected"] != "-1" ? "\<Plug>(completion_confirm_completion)" : "\<C-e>\<CR>" : "\<CR>" ]],
  {expr = true, silent = true}
)
