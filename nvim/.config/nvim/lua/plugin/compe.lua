local inoremap = vim.keymap.inoremap

require('compe').setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'enable',
  allow_prefix_unmatch = false,

  -- priority: Higher means top of the list
  source = {
    nvim_lsp = {
      priority = 100,
    },
    nvim_lua = {
      priority = 100,
    },
    omni = true,
    -- treesitter = {
    --   priority = 90,
    --   dup = false,
    -- },
    -- tags = {
    --   priority = 50,
    --   dup = false,
    -- },
    -- buffer = {
    --   priority = 40,
    --   dup = false,
    -- },
    path = true,
  }
}

inoremap { '<Tab>', [[pumvisible() ? "\<C-n>": "\<Tab>"]], expr = true, silent = true }
inoremap { '<S-Tab>', [[pumvisible() ? "\<C-p>": "\<S-Tab>"]], expr = true, silent = true }
inoremap { '<C-Space>', [[compe#complete() ]], silent = true, expr = true }
inoremap { '<C-y>', [[compe#confirm('<CR>')]], silent = true, expr = true }
inoremap { '<C-e>', [[compe#close()]], silent = true, expr = true }
