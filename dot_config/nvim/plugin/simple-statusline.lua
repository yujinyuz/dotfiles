_G.SimpleStatusline = {}

local H = {}

H.fileprefix = function()
  local basename = vim.fn.fnamemodify(vim.fn.expand('%:h'), ':p:~:.')
  if basename == '' or basename == '.' then
    return ''
  else
    return basename:gsub('/$', '') .. '/'
  end
end

_G.SimpleStatusline.default = function()
  return table.concat {
    -- Show mode
    '[%{mode()}] ',
    -- Show git branch (if available)
    vim.b.gitsigns_head and string.format(' %s ', vim.b.gitsigns_head) or '',
    -- Show filepath where filepath is dimmed and filename is bold
    '%<',
    '%#StatuslineFilePrefix#',
    H.fileprefix(),
    '%#StatuslineFilename#',
    '%t',
    -- Reset highlight
    '%* ',
    -- Show modified flag and readonly flag
    '%m ',
    '%r ',
    -- Start right aligned items
    '%=%*',
    -- Show filetype
    '%y ',
    -- Show filesize
    vim.b.bufsize_human and string.format('%s ', vim.b.bufsize_human) or '',
    -- Show current line and total lines
    'ℓ:%l/%L ',
    -- Show current column and total columns
    '𝚌:%2v/%-2{virtcol("$")-1} ',
    -- Show percentage
    '%p%%',
  }
end

-- Set statusline
vim.opt.statusline = '%!v:lua.SimpleStatusline.default()'
