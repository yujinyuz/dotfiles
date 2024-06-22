_G.SimpleStatusline = {}

local H = {}

H.is_truncated = function(trunc_width)
  local cur_width = vim.o.laststatus == 3 and vim.o.columns or vim.api.nvim_win_get_width(0)
  return cur_width < (trunc_width or -1)
end

H.fileprefix = function(args)
  local basename = vim.fn.fnamemodify(vim.fn.expand('%:h'), ':p:~:.')
  if basename == '' or basename == '.' then
    return ''
  else
    basename = basename:gsub('/$', '') .. '/'

    if H.is_truncated(args.trunc_width) then
      return vim.fn.pathshorten(basename)
    end

    return basename
  end
end

H.git_branch = function(args)
  if H.is_truncated(args.trunc_width) then
    return ''
  end
  return vim.b.gitsigns_head and string.format('  %s ', vim.b.gitsigns_head) or ''
end

H.file_info = function(args)
  if H.is_truncated(args.trunc_width) then
    return ''
  end
  local file_size = vim.b.bufsize_human

  if not file_size then
    return '%y '
  end

  return string.format('%s %s ', '%y', file_size)
end

H.loc_info = function(args)
  if H.is_truncated(args.trunc_width) then
    return 'ℓ:%l 𝚌:%2v'
  end
  -- return 'ℓ:%l/%L 𝚌:%2v/%-2{virtcol("$")-1} %p%%'
  return 'ℓ:%l/%L 𝚌:%2v/%-2{virtcol("$")-1}'
end

_G.SimpleStatusline.render = function()
  return table.concat {
    -- Show mode
    '%#StatusLineCommonInfo#',
    string.format('[%s]', vim.api.nvim_get_mode().mode),
    -- Show git branch (if available)
    H.git_branch { trunc_width = 80 },
    '%*',
    '%<',
    '%#StatuslineFilePrefix#',
    string.format(' %s', H.fileprefix { trunc_width = 120 }),
    '%#StatuslineFilename#',
    '%t',
    -- Reset highlight
    '%* ',
    -- Show modified flag and readonly flag
    '%m%r%h%w',
    -- Start right aligned items
    '%=%*',
    -- Show filetype and file size
    H.file_info { trunc_width = 80 },
    -- Show current line and total lines
    '%#StatusLineLocInfo# ',
    H.loc_info { trunc_width = 80 },
  }
end

-- Set statusline
vim.opt.statusline = '%!v:lua.SimpleStatusline.render()'
