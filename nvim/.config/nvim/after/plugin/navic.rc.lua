local has_navic, navic = pcall(require, 'nvim-navic')

if not has_navic then
  return
end

vim.keymap.set('n', '<C-s>', function()
  print(navic.get_location())
end, { desc = 'Show current location' })
