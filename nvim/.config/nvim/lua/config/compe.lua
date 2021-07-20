require('compe').setup({
  enabled = true,
  debug = false,
  min_length = 1,
  preselect = 'disable',
  -- priority: Higher means top of the list
  source = {
    nvim_lsp = {
      priority = 100,
    },
    nvim_lua = {
      priority = 100,
    },
    tags = {
      priority = 50,
      dup = false,
      ignored_filetypes = { 'markdown' },
    },
    path = true,
    calc = true,
  },
})

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t('<C-n>')
    -- elseif vim.fn.call("vsnip#available", {1}) == 1 then
    --   return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t('<Tab>')
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t('<C-p>')
    -- elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    --   return t "<Plug>(vsnip-jump-prev)"
  else
    return t('<S-Tab>')
  end
end

-- From nvim-autopairs documentation
_G.completion_confirm = function()
  local npairs = require('nvim-autopairs')

  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info()['selected'] ~= -1 then
      return vim.fn['compe#confirm'](npairs.esc('<cr>'))
    else
      -- When using `pyright` language server, there are instances where typing `[` will trigger
      -- and autocompletion, and when I press enter, it doesn't work as intended
      -- e.g. `[|]` where | is the cursor, pressing enter will make it
      --  [
      -- |]
      -- vs. expected
      -- [
      --   |
      -- ]

      if vim.bo.filetype == 'python' then
        return npairs.autopairs_cr()
      end

      return npairs.esc('<cr>')
    end
  else
    return npairs.autopairs_cr()
  end
end

local inoremap = vim.keymap.inoremap

inoremap({ '<C-Space>', [[compe#complete()]], silent = true, expr = true })
inoremap({ '<CR>', [[v:lua.completion_confirm()]], silent = true, expr = true })

inoremap({ '<Tab>', [[v:lua.tab_complete()]], expr = true, silent = true })
inoremap({ '<S-Tab>', [[v:lua.s_tab_complete()]], expr = true, silent = true })
inoremap({ '<Up>', [[compe#scroll({ 'delta': +4})]], silent = true, expr = true })
inoremap({ '<Down>', [[compe#scroll({ 'delta': -4})]], silent = true, expr = true })
-- inoremap { '<C-e>', [[compe#close()]], silent = true, expr = true } -- conflicts with vim-rsi

au({ events = { 'CompeConfirmDone' }, command = 'lua vim.lsp.buf.signature_help()', user = true })
