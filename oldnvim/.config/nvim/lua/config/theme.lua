require('kanagawa').setup {
  globalStatus = true,
  overrides = {
    FloatBorder = { bg = 'NONE' },
  },
}

vim.cmd('colorscheme kanagawa')
