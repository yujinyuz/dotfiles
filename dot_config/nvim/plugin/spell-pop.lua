local create_spell_pop = function()
  -- If the user has provided a count, then use the built-in spell suggestions
  if vim.v.count > 0 then
    vim.cmd(string.format('norm! %dz=', vim.v.count))
    return
  end

  local cursor_word = vim.fn.expand('<cword>')
  local spell_suggestions = vim.fn.spellsuggest(cursor_word, 15)

  -- I don't know a better way to handle this since I want to leverage
  -- the builtin message provided by spellsuggest if no suggestions are available
  -- without having to manually print the error message.
  -- So, calling the built-in z= if there are no suggestions for now
  if vim.tbl_isempty(spell_suggestions) then
    vim.cmd('norm! z=')
    return
  end

  local current_window = vim.api.nvim_get_current_win()
  local cursor_pos = vim.api.nvim_win_get_cursor(current_window)

  -- Define the popup window options
  local opts = {
    relative = 'cursor', -- Position the window relative to the cursor
    row = 1, -- Adjust the vertical position (rows below the cursor)
    col = 1, -- Adjust the horizontal position (columns to the right of the cursor)
    width = math.max(#cursor_word * 2, 25), -- Width of the popup window (min 20 chars
    height = #spell_suggestions, -- Height of the popup window
    style = 'minimal', -- Minimal style (no line numbers, etc.)
    border = 'rounded', -- Border style (none, single, double, rounded, solid, shadow)
    title = '> Spell Suggestions <',
    title_pos = 'center',
  }

  -- Create the popup window
  local buf = vim.api.nvim_create_buf(false, true)
  local popup_winid = vim.api.nvim_open_win(buf, true, opts)

  -- Prefercolemak homerow keys
  local keys = '1234567890neioarst'

  for index, suggestion in ipairs(spell_suggestions) do
    local key = keys:sub(index, index)

    vim.api.nvim_buf_set_lines(buf, index - 1, -1, false, { string.format('[%s] %s', key, suggestion) })

    vim.schedule(function()
      vim.keymap.set('n', key, function()
        vim.api.nvim_win_close(popup_winid, true)
        vim.cmd(string.format('norm! "_ciw%s', suggestion))
      end, { buffer = buf, noremap = true, nowait = true })
    end)
  end

  vim.api.nvim_set_option_value(
    'winhighlight',
    'Normal:SpellPopNormal,FloatBorder:SpellPopFloatBorder',
    { win = popup_winid }
  )
  vim.api.nvim_set_option_value('winfixbuf', true, { win = popup_winid })
  vim.api.nvim_set_option_value('cursorline', true, { win = popup_winid })
  vim.api.nvim_set_option_value('modifiable', false, { buf = buf })
  vim.api.nvim_set_option_value('filetype', 'spellpopup', { buf = buf })

  vim.keymap.set('n', '<Esc>', function()
    vim.api.nvim_win_close(popup_winid, true)
  end, { buffer = buf, nowait = true })

  vim.keymap.set('n', 'q', function()
    vim.api.nvim_win_close(popup_winid, true)
  end, { buffer = buf, nowait = true })

  -- IDK how other plugins handle things when you just confirm with <CR>
  -- But since the current cursor line has a 1:1 mapping with the suggestions
  -- we can use the cursor line to apply the spelling suggestion by accessing
  -- the index of the line in the spell_suggestions table
  vim.keymap.set('n', '<CR>', function()
    local line_pos = vim.api.nvim_win_get_cursor(popup_winid)[1]
    vim.api.nvim_win_close(popup_winid, true)
    vim.cmd(string.format('norm! "_ciw%s', spell_suggestions[line_pos]))
    vim.api.nvim_win_set_cursor(current_window, cursor_pos)
  end, { buffer = buf, nowait = true, desc = 'Apply spelling based on current selected line' })

  vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
    buffer = buf,
    once = true,
    callback = function()
      vim.api.nvim_win_close(popup_winid, true)
    end,
  })
end

-- Override default spellsuggest mapping
vim.keymap.set('n', 'z=', create_spell_pop, { noremap = true, silent = true })
