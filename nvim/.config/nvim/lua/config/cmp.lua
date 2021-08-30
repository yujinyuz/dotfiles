local cmp = require('cmp')
local utils = require('utils')

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(utils.t('<C-n>'), 'n')
      elseif require('luasnip').expand_or_jumpable() then
        vim.fn.feedkeys(utils.t('<Cmd>lua require("luasnip").jump(1)<CR>'), 'n')
      elseif check_back_space() then
        vim.fn.feedkeys(utils.t('<Tab>'), 'n')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(utils.t('<C-p>'), 'n')
      elseif require('luasnip').jumpable(-1) then
        vim.fn.feedkeys(utils.t('<Cm>lua require("luasnip").jump(-1)<CR>'), 'n')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'tags' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'nvim_lua' },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = require('config.lsp.kind').icons[vim_item.kind] .. ' ' .. vim_item.kind
      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        tags = '[Tags]',
        luasnip = '[LuaSnip]',
        buffer = '[Buffer]',
        path = '[Path]',
        nvim_lua = '[Lua]',
      })[entry.source.name]

      return vim_item
    end,
  },
})
