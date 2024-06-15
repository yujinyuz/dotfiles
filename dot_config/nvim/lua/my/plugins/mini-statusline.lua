local config = function()
  local statusline = require('mini.statusline')

  local function section_location(args)
    if statusline.is_truncated(args.trunc_width) then
      return 'ℓ:%l 𝚌:%2v'
    end
    return 'ℓ:%l/%L 𝚌:%2v/%-2{virtcol("$")-1}'
  end

  local function shorten_path(path, sep, max_len)
    local len = #path
    if len <= max_len then
      return path
    end

    local segments = vim.split(path, sep)
    for idx = 1, #segments - 1 do
      if len <= max_len then
        break
      end

      local segment = segments[idx]
      local shortened = segment:sub(1, vim.startswith(segment, '.') and 2 or 1)
      segments[idx] = shortened
      len = len - (#segment - #shortened)
    end

    return table.concat(segments, sep)
  end

  local function section_fileprefix(args)
    local basename = vim.fn.fnamemodify(vim.fn.expand('%:h'), ':p:~:.')
    if basename == '' or basename == '.' then
      return ''
    else
      basename = basename:gsub('/$', '') .. '/'

      if statusline.is_truncated(args.trunc_width) then
        return shorten_path(basename, '/', 1)
      end

      return basename
    end
  end

  local H = {}

  H.get_filetype_icon = function()
    -- Have this `require()` here to not depend on plugin initialization order
    local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
    if not has_devicons then
      return ''
    end
    local file_name, file_ext = vim.fn.expand('%:t'), vim.fn.expand('%:e')
    local icon, hl_group = devicons.get_icon(file_name, file_ext, { default = true })

    return icon, hl_group
  end

  local function section_fileinfo(args)
    local filetype = vim.bo.filetype
    if (filetype == '') or vim.bo.buftype ~= '' then
      return filetype or vim.bo.buftype
    end

    local icon, hl_group = H.get_filetype_icon()
    local colored_icon = string.format('%%#%s# %s%%#MiniStatuslineFileinfo#', hl_group, icon)

    if icon ~= '' then
      filetype = string.format('%s %s', colored_icon, filetype)
    end

    if statusline.is_truncated(args.trunc_width) then
      return filetype
    end

    local size = vim.b.bufsize_human

    return string.format('%s %s', filetype, size)
  end

  local config = {
    content = {
      active = function()
        local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
        local git = statusline.section_git { trunc_width = 80 }
        local diagnostics = statusline.section_diagnostics { trunc_width = 80 }
        local fileinfo = section_fileinfo { trunc_width = 80 }
        local search = statusline.section_searchcount { trunc_width = 80 }
        local location = section_location { trunc_width = 80 }

        -- Highlight directory part of file name differently
        local filename = '%#MiniStatuslineFilePrefix#'
          .. section_fileprefix { trunc_width = 80 }
          .. '%#MiniStatuslineFilename#%t'

        return statusline.combine_groups {
          { hl = mode_hl, strings = { mode } },
          { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
          '%<', -- Mark general truncate point
          filename,
          '%=', -- End left alignment
          { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
          { hl = mode_hl, strings = { search, location } },
        }
      end,
    },
    set_vim_settings = false,
  }

  statusline.setup(config)
end

return {
  {
    'echasnovski/mini.statusline',
    event = 'VeryLazy',
    version = false,
    config = config,
  },
}
