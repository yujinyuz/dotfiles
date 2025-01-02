local M = {}

-- Thin wrapper around the live-server npm plugin

M.config = {
  port = '5555',
}

M.start = function()
  -- NOTE: uv.spawn or vim.system does not automatically close child processes when nvim closes
  -- so let's stick with the vim.fn.jobstart

  if not vim.fn.executable('live-server') then
    vim.notify('live-server is not installed. Please run npm -g install live-server', vim.log.levels.ERROR)
    return
  end

  M.pid = vim.fn.jobstart({ 'live-server', string.format('--port=%s', M.config.port) }, {
    on_exit = function()
      M.pid = nil
    end,
  })
end

M.stop = function()
  if not M.pid then
    return
  end
  vim.fn.jobstop(M.pid)
end

M.preview = function()
  if not M.pid then
    M.start()
  end

  vim.ui.open(string.format('http://127.0.0.1:%s', M.config.port))
end

vim.api.nvim_create_user_command('LiveServer', function(opts)
  if opts.args == 'stop' then
    M.stop()
  else
    M.preview()
  end
end, {
  nargs = '?',
  complete = function(args)
    print(args)
    return { 'start', 'stop', 'preview' }
  end,
})
