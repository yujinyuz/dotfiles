local wk = require('which-key')
local M = {}

function M.setup(client, bufnr)
  -- Mappings.
  local keymap = {
    c = {
      name = '+code',
      r = { '<cmd>lua vim.lsp.buf.rename()<CR>', 'Rename' },
      a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', 'Code Action' },
      d = { '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})<CR>', 'Line Diagnostics' },
      l = {
        name = '+lsp',
        i = { '<cmd>LspInfo<cr>', 'Lsp Info' },
        a = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', 'Add Folder' },
        r = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', 'Remove Folder' },
        l = {
          '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
          'List Folders',
        },
      },
    },
    x = {
      s = { '<cmd>Telescope lsp_document_diagnostics<cr>', 'Search Document Diagnostics' },
      w = { '<cmd>Telescope lsp_workspace_diagnostics<cr>', 'Workspace Diagnostics' },
    },
  }

  if client.name == 'typescript' then
    keymap.c.o = { '<cmd>:TSLspOrganize<CR>', 'Organize Imports' }
    keymap.c.R = { '<cmd>:TSLspRenameFile<CR>', 'Rename File' }
  end

  local keymap_visual = {
    c = {
      name = '+code',
      a = { ':<C-U>lua vim.lsp.buf.range_code_action()<CR>', 'Code Action' },
    },
  }

  local keymap_goto = {
    name = '+goto',
    r = { '<cmd>Telescope lsp_references<cr>', 'References' },
    R = { '<cmd>Trouble lsp_references<cr>', 'Trouble References' },
    d = { '<Cmd>lua vim.lsp.buf.definition()<CR>', 'Goto Definition' },
    dv = { '<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>', 'Goto Definition' },
    ds = { '<Cmd>split | lua vim.lsp.buf.definition()<CR>', 'Goto Definition' },
    s = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'Signature Help' },
    I = { '<cmd>lua vim.lsp.buf.implementation()<CR>', 'Goto Implementation' },
    -- I = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Goto Declaration" },
    -- t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
  }

  vim.keymap.nnoremap({ 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', buffer = true, silent = true })
  vim.keymap.nnoremap({
    '[w',
    '<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {focusable = false}})<CR>',
    buffer = true,
    silent = true,
  })
  vim.keymap.nnoremap({
    ']w',
    '<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {focusable = false}})<CR>',
    buffer = true,
    silent = true,
  })
  vim.keymap.inoremap({ '<C-s>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', silent = true, buffer = true })

  -- @warning: This will map {'(', ')', ','} in insert mode
  -- It might conflict with autopairs plugin
  local trigger_chars = client.resolved_capabilities.signature_help_trigger_characters
  -- So override it to just comma for now since we don't use it much.
  trigger_chars = { ',' }
  for _, c in ipairs(trigger_chars) do
    vim.keymap.inoremap({
      c,
      function()
        vim.defer_fn(vim.lsp.buf.signature_help, 0)
        return c
      end,
      buffer = true,
      silent = true,
      expr = true,
    })
  end

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    keymap.c.f = { '<cmd>lua vim.lsp.buf.formatting()<CR>', 'Format Document' }
  elseif client.resolved_capabilities.document_range_formatting then
    keymap_visual.c.f = { '<cmd>lua vim.lsp.buf.range_formatting()<CR>', 'Format Range' }
  end

  wk.register(keymap, { buffer = bufnr, prefix = '<leader>' })
  wk.register(keymap_visual, { buffer = bufnr, prefix = '<leader>', mode = 'v' })
  wk.register(keymap_goto, { buffer = bufnr, prefix = 'g' })
end

return M
