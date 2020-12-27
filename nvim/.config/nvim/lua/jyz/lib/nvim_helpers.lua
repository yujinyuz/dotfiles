local M = {}

function M.cmd_map(cmd)
  return string.format('<Cmd>%s<CR>', cmd)
end

function M.vcmd_map(cmd)
  return string.format([[<Cmd>'<,'>%s<CR>]], cmd)
end

function M.set_keymap(mode, lhs, rhs, opts)
  vim.api.nvim_set_keymap(
    mode,
    lhs,
    rhs,
    {
      noremap = opts.noremap or true,
      silent = opts.silent or false,
      expr = opts.expr or false,
      script = opts.script or false,
      nowait = opts.nowait or false,
    }
  )
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
