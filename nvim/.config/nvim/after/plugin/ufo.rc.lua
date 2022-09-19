local has_ufo, ufo = pcall(require, 'ufo')
if not has_ufo then
  return
end

require('ufo').setup {}

vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'Open all folds' })
vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = 'Close all folds' })
