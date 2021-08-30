-- @usage dump(vim.opt)
_G.dump = function(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
  return ...
end

-- Just a simple wrapper around :autocmd in vim
-- @field events See :h autocmd-events for a list of events
-- @field user See :h User
-- @field patterns List of patterns for the command to execute on
-- @field modifiers [++once], [++nested]
-- @field command Command to run
-- @table opts
-- @usage au { events = {'BufEnter'}, patterns = {'*.lua'}, command = 'setlocal ft=lua }
_G.au = function(opts)
  local events = table.concat(opts.events, ',')
  local user = opts.user or false
  local patterns = table.concat(opts.patterns or {}, ',')
  local modifiers = table.concat(opts.modifiers or {}, ' ')
  local command = opts.command

  if not command then
    error('no command provided')
  end

  if user then
    user = 'User'
  else
    user = ''
  end

  opts.user = nil

  local cmd = string.format('autocmd %s %s %s %s %s', user, events, patterns, modifiers, command)

  vim.cmd(cmd)
end

-- A simple wrapper around :augroup in vim
-- @usage aug('LuaConfig', {
--             { events = {'BufNewFile', 'BufRead'}, patterns = {'*.lua'}, command = 'setlocal ft=lua' },
--             { events = {'BufReadPost'}, patterns = {'*'}, command = 'echo hello' } })
_G.aug = function(name, commands)
  vim.cmd('augroup ' .. name)
  vim.cmd('autocmd!')
  for _, c in ipairs(commands) do
    local cmd = string.format(
      'autocmd %s %s %s %s',
      table.concat(c.events, ','),
      table.concat(c.patterns or {}, ','),
      table.concat(c.modifiers or {}, ' '),
      c.command
    )

    vim.cmd(cmd)
  end
  vim.cmd('augroup END')
end

local M = {}

M.functions = {}

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.log(msg, hl, name)
  name = name or 'Neovim'
  hl = hl or 'Todo'
  vim.api.nvim_echo({ { name .. ': ', hl }, { msg } }, true, {})
end

function M.warn(msg, name)
  M.log(msg, 'LspDiagnosticsDefaultWarning', name)
end

function M.error(msg, name)
  M.log(msg, 'LspDiagnosticsDefaultError', name)
end

function M.info(msg, name)
  M.log(msg, 'LspDiagnosticsDefaultInformation', name)
end

-- @param option
-- @param [opt] silent
-- @usage require("utils").toggle('relativenumber')
function M.toggle(option, silent)
  local info = vim.api.nvim_get_option_info(option)
  local scopes = { buf = 'bo', win = 'wo', global = 'o' }
  local scope = scopes[info.scope]
  local options = vim[scope]
  options[option] = not options[option]
  if silent ~= true then
    if options[option] then
      M.info('enabled vim.' .. scope .. '.' .. option, 'Toggle')
    else
      M.warn('disabled vim.' .. scope .. '.' .. option, 'Toggle')
    end
  end
end

function M.float_terminal(cmd)
  local buf = vim.api.nvim_create_buf(false, true)
  local vpad = 4
  local hpad = 10
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = vim.o.columns - hpad * 2,
    height = vim.o.lines - vpad * 2,
    row = vpad,
    col = hpad,
    style = 'minimal',
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
  })
  vim.fn.termopen(cmd)
  local autocmd = {
    'autocmd! TermClose <buffer> lua',
    string.format('vim.api.nvim_win_close(%d, {force = true});', win),
    string.format('vim.api.nvim_buf_delete(%d, {force = true});', buf),
  }
  vim.cmd(table.concat(autocmd, ' '))
  vim.cmd([[startinsert]])
end

function M.lsp_config()
  local ret = {}
  for _, client in pairs(vim.lsp.get_active_clients()) do
    ret[client.name] = { root_dir = client.config.root_dir, settings = client.config.settings }
  end
  dump(ret)
end

function M.execute(id)
  local func = M.functions[id]
  if not func then
    error('Function doest not exist: ' .. id)
  end
  return func()
end

-- https://github.com/ibhagwan/nvim-lua/blob/main/lua/utils.lua#L280
function M.sudo_exec(cmd, print_output)
local password = vim.fn.inputsecret("Password: ")
  if not password or #password == 0 then
      M.warn("Invalid password, sudo aborted")
      return false
  end
  local out = vim.fn.system(string.format("sudo -p '' -S %s", cmd), password)
  if vim.v.shell_error ~= 0 then
    print("\r\r")
    M.error(out)
    return false
  end
  -- if print_output then print("\r\n", out) end
  return true
end

function M.sudo_write(tmpfile, filepath)
  if not tmpfile then tmpfile = vim.fn.tempname() end
  if not filepath then filepath = vim.fn.expand("%") end
  if not filepath or #filepath == 0 then
    M.error("E32: No file name")
    return
  end
  -- `bs=1048576` is equivalent to `bs=1M` for GNU dd or `bs=1m` for BSD dd
  -- Both `bs=1M` and `bs=1m` are non-POSIX
  local cmd = string.format("dd if=%s of=%s bs=1048576",
    vim.fn.shellescape(tmpfile),
    vim.fn.shellescape(filepath))
  -- no need to check error as this fails the entire function
  vim.api.nvim_exec(string.format("write! %s", tmpfile), true)
  if M.sudo_exec(cmd) then
    vim.cmd("e!")
    M.info(string.format('"%s" written', filepath))
  end
  vim.fn.delete(tmpfile)
end

return M
