-- @note: Anything related to globals that are required before neovim is loaded should be in here since
--        this is a file that gets loaded first when neovim starts
vim.g.tokyonight_style = 'storm'
vim.g.mapleader = ' '
vim.g.python3_host_prog = os.getenv('PYTHON_3_HOST_PROG')

vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

vim.g.did_load_filetypes = 1

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

