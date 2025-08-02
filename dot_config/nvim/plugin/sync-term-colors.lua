vim.api.nvim_create_user_command('SyncTermColors', function(opts)
  local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
  if not normal.bg then
    return
  end

  if vim.env.TMUX then
    io.write(string.format('\027Ptmux;\027\027]11;#%06x\007\027\\', normal.bg))
  else
    io.write(string.format('\027]11;#%06x\027\\', normal.bg))
  end
end, {})
