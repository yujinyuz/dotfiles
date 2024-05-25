-- Turn off relative numbers and a bunch of stuffs when collaborating
vim.api.nvim_create_user_command('MuggleFriendlyModeToggle', function()
  vim.g.muggle_friendly_mode = not vim.g.muggle_friendly_mode

  if vim.g.muggle_friendly_mode then
    -- Muggles don't understand relative numbers
    vim.opt.relativenumber = false
  else
    vim.opt.relativenumber = true
  end
end, {})

vim.api.nvim_create_user_command('CursorMiddleToggle', function()
  vim.opt.scrolloff = 999 - vim.o.scrolloff
end, { desc = 'Always keep the cursor in the middle of the screen' })
