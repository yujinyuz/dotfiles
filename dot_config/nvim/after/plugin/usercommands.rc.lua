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

vim.api.nvim_create_user_command('FormatJson', function(opts)
  local indent = tonumber(opts.args) or 2
  local start_line, end_line

  if opts.range == 0 then
    start_line, end_line = 1, vim.fn.line('$')
  else
    start_line, end_line = opts.line1, opts.line2
  end

  vim.cmd(start_line .. ',' .. end_line .. '!jq . --indent ' .. indent)
end, { nargs = '?', range = true })

vim.api.nvim_create_user_command('DiffOrig', function()
  local ft = vim.bo.filetype
  vim.cmd('leftabove vert new')
  vim.cmd('set ft=' .. ft)
  vim.cmd('set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis')
end, { desc = 'Diff Orig file' })
