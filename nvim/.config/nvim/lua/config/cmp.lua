local cmp = require('cmp')
local luasnip = require('luasnip')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
  completion = {
    autocomplete = false,
  },
  documentation = {
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    winhighlight = 'NormalFloat:NormalFloat,FloatBorder:TelescopeBorder',
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
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false, -- If I press enter, I don't want to select anything. Just create a new line
    }),
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
  sources = cmp.config.sources({
    { name = 'rg', max_item_count = 10, keyword_length = 3 },
    { name = 'path', max_item_count = 10, keyword_length = 3 },
  }),
  formatting = {
    format = require('lspkind').cmp_format({
      with_text = true,
      max_width = 50,
      menu = {
        nvim_lsp = '[LSP]',
        nvim_lua = '[Lua]',
        tags = '[Tags]',
        buffer = '[Buffer]',
        path = '[Path]',
        luasnip = '[LuaSnip]',
        calc = '[Calc]',
        look = '[Look]',
        rg = '[ripgrep]',
      },
    }),
  },
  -- experimental = {
  --   ghost_text = {
  --     hl_group = 'LineNr',
  --   },
  -- },
})
-- })

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
