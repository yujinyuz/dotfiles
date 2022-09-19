local has_cmp, cmp = pcall(require, 'cmp')
if not has_cmp then
  return
end

local has_luasnip, luasnip = pcall(require, 'luasnip')

local _, lspkind = pcall(require, 'lspkind')

local utils = require('my.utils')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local M = {}
M.enable_cmp = true

function M.toggle()
  M.enable_cmp = not M.enable_cmp
  if M.enable_cmp then
    utils.info('enabled autocomplete ', 'Toggle')
  else
    utils.warn('disabled autocomplete', 'Toggle')
  end
end

--- disabling redundant-parameter because `cmp.setup` uses setmetatable
---@diagnostic disable-next-line:redundant-parameter
cmp.setup {
  enabled = function()
    if M.enable_cmp and vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' then
      return true
    end
    return false
  end,
  preselect = cmp.PreselectMode.None,
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    {
      name = 'buffer',
      max_item_count = 10,
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
  }),
  window = {
    documentation = cmp.config.window.bordered {},
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require('cmp-under-comparator').under, -- for python
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  snippet = {
    expand = function(args)
      if has_luasnip then
        luasnip.lsp_expand(args.body)
      end
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping { i = cmp.mapping.close(), c = cmp.mapping.close() },
    ['<C-y>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm { select = true }
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<C-j>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i' }),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i' }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
  },
  formatting = {
    format = lspkind.cmp_format {
      mode = 'text_symbol',
      with_text = true,
      max_width = 50,
      before = function(entry, vim_item)
        return vim_item
      end,
    },
  },
  experimental = {
    ghost_text = {
      hl_group = 'LspCodeLens',
    },
  },
}

cmp.setup.filetype('html', {
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'rg', max_item_count = 10 },
    { name = 'buffer', max_item_count = 10 },
  }),
})

cmp.setup.filetype('markdown', {
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'rg', max_item_count = 10 },
    { name = 'buffer', max_item_count = 10 },
  },
})

-- Following the vim philosophy keybindings
-- @see `:h ins-completion`
vim.keymap.set('i', '<C-x><C-o>', function()
  cmp.complete {
    config = {
      sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
      },
    },
  }
end, { desc = 'LSP completion' })

vim.keymap.set('i', '<C-x><C-s>', function()
  cmp.complete {
    config = {
      sources = {
        { name = 'luasnip' },
      },
    },
  }
end, { desc = 'Snippet completion' })

vim.keymap.set('i', '<C-x><C-]>', function()
  cmp.complete {
    config = {
      sources = {
        { name = 'tags', max_item_count = 10 },
      },
    },
  }
end, { desc = 'ctags completion' })

vim.keymap.set('i', '<C-x><C-x>', function()
  cmp.complete {
    config = {
      sources = {
        { name = 'rg', max_item_count = 10 },
      },
    },
  }
end, { desc = 'ripgrep completion' })

vim.keymap.set('i', '<C-x><C-f>', function()
  cmp.complete {
    config = {
      sources = {
        { name = 'path' },
      },
    },
  }
end, { desc = 'Path completion' })

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done { map_char = { tex = '' } })

vim.keymap.set('n', 'yoq', M.toggle, { desc = 'Toggle autocomplete' })

-- vim.api.nvim_create_autocmd({ 'TextChangedI', 'TextChangedP' }, {
--   callback = function()
--     local line = vim.api.nvim_get_current_line()
--     local cursor = vim.api.nvim_win_get_cursor(0)[2]
--
--     local current = string.sub(line, cursor, cursor + 1)
--     if current == '.' or current == ',' or current == ' ' then
--       require('cmp').close()
--     end
--
--     local before_line = string.sub(line, 1, cursor + 1)
--     local after_line = string.sub(line, cursor + 1, -1)
--     if not string.match(before_line, '^%s+$') then
--       if after_line == '' or string.match(before_line, ' $') or string.match(before_line, '%.$') then
--         require('cmp').complete()
--       end
--     end
--   end,
--   pattern = '*',
-- })

return M
