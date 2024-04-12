local M = {}

M.t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.log = function(msg, hl, name)
  name = name or 'Neovim'
  hl = hl or 'Todo'
  vim.api.nvim_echo({ { name .. ': ', hl }, { msg } }, true, {})
end

M.warn = function(msg, name)
  M.log(msg, 'DiagnosticWarn', name)
end

M.error = function(msg, name)
  M.log(msg, 'DiagnosticError', name)
end

M.info = function(msg, name)
  M.log(msg, 'DiagnosticInfo', name)
end

-- @param option
-- @param [opt] silent
-- @usage require("utils").toggle('relativenumber')
M.toggle = function(option, silent)
  vim.opt_local[option] = not vim.opt_local[option]:get()

  if silent ~= true then
    if vim.opt_local[option]:get() then
      M.info('enabled vim.opt_local.' .. option, 'Toggle')
    else
      M.warn('disabled vim.opt_local.' .. option, 'Toggle')
    end
  end
end

function M.lsp_config()
  local ret = {}
  for _, client in pairs(vim.lsp.get_active_clients()) do
    ret[client.name] = { root_dir = client.config.root_dir, settings = client.config.settings }
  end
  print(vim.inspect(ret))
end

-- https://github.com/ibhagwan/nvim-lua/blob/main/lua/utils.lua#L280
M.sudo_exec = function(cmd, print_output)
  vim.fn.inputsave()
  local password = vim.fn.inputsecret('Password: ')
  vim.fn.inputrestore()
  if not password or #password == 0 then
    M.warn('Invalid password, sudo aborted')
    return false
  end
  local out = vim.fn.system(string.format("sudo -p '' -S %s", cmd), password)
  if vim.v.shell_error ~= 0 then
    print('\r\r')
    M.error(out)
    return false
  end
  if print_output then
    print('\r\n', out)
  end
  return true
end

M.sudo_write = function(tmpfile, filepath)
  if not tmpfile then
    tmpfile = vim.fn.tempname()
  end
  if not filepath then
    filepath = vim.fn.expand('%')
  end
  if not filepath or #filepath == 0 then
    M.error('E32: No file name')
    return
  end
  -- `bs=1048576` is equivalent to `bs=1M` for GNU dd or `bs=1m` for BSD dd
  -- Both `bs=1M` and `bs=1m` are non-POSIX
  local cmd = string.format('dd if=%s of=%s bs=1048576', vim.fn.shellescape(tmpfile), vim.fn.shellescape(filepath))
  -- no need to check error as this fails the entire function
  vim.api.nvim_exec2(string.format('write! %s', tmpfile), { output = true })
  if M.sudo_exec(cmd) then
    -- refreshes the buffer and prints the "written" message
    vim.cmd.edit { bang = true }
    -- exit command mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
    M.info(string.format('"%s" written', filepath))
  end
  vim.fn.delete(tmpfile)
end

return M
