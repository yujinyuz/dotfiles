local M = {}

function M.cmd_map(cmd)
  return string.format('<Cmd>%s<CR>', cmd)
end

function M.vcmd_map(cmd)
  return string.format([[<Cmd>'<,'>%s<CR>]], cmd)
end

function M.create_mappings(mappings, bufnr)
  local fn = vim.api.nvim_set_keymap
  if bufnr then
    fn = function(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
  end

  for mode, rules in pairs(mappings) do
    for _, m in ipairs(rules) do
      fn(mode, m.lhs, m.rhs, m.opts or {})
    end
  end
end

function M.augroup(name, commands)
  vim.cmd('augroup ' .. name)
  vim.cmd('autocmd!')
  for _, c in ipairs(commands) do
    vim.cmd(string.format('autocmd %s %s %s %s', table.concat(c.events, ','),
                                                 table.concat(c.targets or {}, ','),
                                                 table.concat(c.modifiers or {}, ' '),
                          c.command))
  end
  vim.cmd('augroup END')
end

return M
