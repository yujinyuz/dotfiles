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

  local branch = vim.b.gitsigns_head and vim.b.gitsigns_head or vim.g.gitsigns_head

  if not branch or branch == '' then
    branch = '-'
  end

  return string.format('  %s ', branch)
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

H.gutter_padding = function()
  local line_count = #tostring(vim.api.nvim_buf_line_count(0))
  local hl = vim.bo.modified and '%4*' or '%1*'

  -- Minimum of 2 spaces for the padding
  local rep = math.max(line_count, 3)

  -- Only expand the mode to the same width as the line count if
  -- H
  -- Handling even numbers is quite tricky, so we'll just remove one space
  -- from the left padding if the line count is even
  local padding = string.rep(' ', rep)

  return string.format('%s%s', hl, padding)
end

_G.SimpleStatusline.render = function()
  return table.concat {
    -- Show mode
    H.gutter_padding(),
    -- Show git branch (if available)
    '%5*',
    H.git_branch { trunc_width = 80 },
    '%*',
    '%<',
    '%3*',
    string.format(' %s', H.fileprefix { trunc_width = 120 }),
    '%2*',
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
    '%1* ',
    H.loc_info { trunc_width = 80 },
  }
end

-- Set statusline
vim.opt.statusline = '%!v:lua.SimpleStatusline.render()'

-- Define custom highlights
vim.api.nvim_set_hl(0, 'StatusLineCommonInfo', { link = 'ColorColumn', default = true })
vim.api.nvim_set_hl(0, 'StatusLineMode', { link = 'Cursor', default = true })

vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
  callback = function()
    local tablinesel = vim.api.nvim_get_hl(0, { name = 'TabLineSel' })
    local conceal = vim.api.nvim_get_hl(0, { name = 'Conceal' })

    vim.api.nvim_set_hl(0, 'User1', { link = 'Cursor', default = true })
    vim.api.nvim_set_hl(0, 'User3', vim.tbl_extend('keep', conceal, {})) -- file prefix
    vim.api.nvim_set_hl(0, 'User2', { bold = true, bg = conceal.bg }) -- file name
    vim.api.nvim_set_hl(0, 'User4', { bg = '#e78285' }) -- gutter
    vim.api.nvim_set_hl(0, 'User5', vim.tbl_extend('keep', { fg = 'none' }, tablinesel)) -- git branch

    vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'none' })
  end,
})
