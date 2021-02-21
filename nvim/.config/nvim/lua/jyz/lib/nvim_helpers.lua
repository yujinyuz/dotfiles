local M = {}

function M.cmd_map(cmd)
  return string.format('<Cmd>%s<CR>', cmd)
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

-- TODO: Remove when https://github.com/neovim/neovim/pull/13479 is merged
-- There isn't an alternative to `set <option>` in Lua as of writing this
-- so we need to set the global `vim.o` first and then set is as a window local or a buffer local
function M.get_vim_opts()
  local opts_info = vim.api.nvim_get_all_options_info()
  local opt = setmetatable({}, {
    __index = vim.o,
    __newindex = function(_, key, value)
      vim.o[key] = value
      local scope = opts_info[key].scope
      if scope == "win" then
        vim.wo[key] = value
        elseif scope == "buf" then
        vim.bo[key] = value
      end
    end,
  })
  return opt
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
