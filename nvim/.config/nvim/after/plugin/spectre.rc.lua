local has_spectre, spectre = pcall(require, 'spectre')

if not has_spectre then
  return
end

vim.keymap.set('n', '<leader>S', function()
  spectre.open()
end, { desc = 'Search and Replace' })

vim.keymap.set('n', '<leader>sw', function()
  spectre.open_visual { select_word = true }
end, { desc = 'Grep word under cursor' })

vim.keymap.set('n', '<leader>sp', function()
  vim.cmd([[normal! viw]])
  spectre.open_file_search()
end, { desc = 'Search current file' })
