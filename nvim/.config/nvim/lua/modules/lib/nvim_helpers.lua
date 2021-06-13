local M = {}

function M.cmd_map(cmd) return string.format('<Cmd>%s<CR>', cmd) end

function M.augroup(name, commands)
  vim.cmd('augroup ' .. name)
  vim.cmd('autocmd!')
  for _, c in ipairs(commands) do
    vim.cmd(
      string.format(
        'autocmd %s %s %s %s', table.concat(c.events, ','),
        table.concat(c.targets or {}, ','),
        table.concat(c.modifiers or {}, ' '), c.command
      )
    )
  end
  vim.cmd('augroup END')
end

function M.save_and_execute()
  local filetype = vim.bo.filetype

  if filetype == 'vim' then
    vim.cmd [[silent! write]]
    vim.cmd [[source %]]
  elseif filetype == 'lua' then
    vim.cmd [[silent! write]]
    vim.cmd [[luafile %]]
  end
end

return M
