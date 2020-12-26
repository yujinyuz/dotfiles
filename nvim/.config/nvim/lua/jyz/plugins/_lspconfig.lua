local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')
local completion = require('completion')

local nvim_set_keymap = vim.api.nvim_set_keymap


local on_attach = function(client)
  local resolved_capabilities = client.resolved_capabilities
  completion.on_attach(client)

  local opts = {noremap = true, silent = true}
  nvim_set_keymap('n', 'gD', [[<Cmd>lua vim.lsp.buf.declaration()<CR>]], opts)
  nvim_set_keymap('n', 'gd', [[<Cmd>lua vim.lsp.buf.definition()<CR>]], opts)
  nvim_set_keymap('n', 'ga', [[<Cmd>lua vim.lsp.buf.code_action()<CR>]], opts)
  nvim_set_keymap('n', 'K', [[<Cmd>lua vim.lsp.buf.hover()<CR>]], opts)
  nvim_set_keymap('n', 'gi', [[<Cmd>lua vim.lsp.buf.implementation()<CR>]], opts)
  nvim_set_keymap('n', '<leader>gr', [[<Cmd>lua vim.lsp.buf.rename()<CR>]], opts)
  nvim_set_keymap('n', 'gr', [[<Cmd>lua require'telescope.builtin'.lsp_references()<CR>]], opts)
  nvim_set_keymap('n', '<leader>ld', [[<Cmd>lua vim.lsp.util.show_line_diagnostics()<CR>]], opts)

  vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

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


local servers = {
  vimls = {},
  jsonls = {},
  -- jedi_language_server = {},
  pyls_ms = {},
}


for server, config in pairs(servers) do
  config.on_attach = on_attach
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

vim.cmd([[
  set completeopt=menuone,noinsert,noselect
]])

nvim_set_keymap('i', '<Tab>', [[ pumvisible() ? "\<C-n>": "\<Tab>" ]], {expr = true, noremap = true, silent = true})
nvim_set_keymap('i', '<S-Tab>', [[ pumvisible() ? "\<C-p>": "\<S-Tab>" ]], {expr = true, noremap = true, silent = true})
nvim_set_keymap('i', '<C-Space>', [[<Plug>(completion_trigger)]], {silent = true})
nvim_set_keymap(
  'i',
  '<CR>',
  [[ pumvisible() ? complete_info()["selected"] != "-1" ? "\<Plug>(completion_confirm_completion)" : "\<C-e>\<CR>" : "\<CR>" ]],
  {expr = true, silent = true}
)
