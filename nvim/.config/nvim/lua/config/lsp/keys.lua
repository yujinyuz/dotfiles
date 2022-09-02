local wk = require('which-key')
local M = {}

function M.setup(client, bufnr)
  -- Mappings.
  local keymap = {
    c = {
      name = '+code',
      r = {
        function()
          vim.lsp.buf.rename()
        end,
        'Rename',
      },
      a = {
        function()
          vim.lsp.buf.code_action()
        end,
        'Code Action',
      },
      d = {
        function()
          vim.diagnostic.open_float { opts = { focus = false } }
        end,
        'Line Diagnostics',
      },
      t = {
        '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>',
        'Dynamic Workspace Symbols',
      },
      l = {
        name = '+lsp',
        c = {
          function()
            require('utils').lsp_config()
          end,
          'Lsp Config',
        },
        i = { '<Cmd>LspInfo<CR>', 'Lsp Info' },
        a = {
          function()
            vim.lsp.buf.add_workspace_folder()
          end,
          'Add Folder',
        },
        r = {
          function()
            vim.lsp.buf.remove_workspace_folder()
          end,
          'Remove Folder',
        },
        l = {
          '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
          'List Folders',
        },
        f = {
          function()
            require('config.lsp.formatting').toggle()
          end,
          'Toggle Autoformat',
        },
        s = {
          name = '+server',
          r = {
            function()
              vim.cmd([[LspStop]])
              vim.defer_fn(function()
                vim.cmd([[LspStart]])
              end, 0)
            end,
            'Restart Server',
          },
        },
      },
    },
    x = {
      s = { '<Cmd>Telescope lsp_document_diagnostics<CR>', 'Search Document Diagnostics' },
      w = { '<Cmd>Telescope lsp_workspace_diagnostics<CR>', 'Workspace Diagnostics' },
    },
  }

  if client.name == 'typescript' or client.name == 'tsserver' then
    keymap.c.o = { '<Cmd>:TSLspOrganize<CR>', 'Organize Imports' }
    keymap.c.R = { '<Cmd>:TSLspRenameFile<CR>', 'Rename File' }
  end

  local keymap_visual = {
    c = {
      name = '+code',
      a = { ':<C-U>lua vim.lsp.buf.range_code_action()<CR>', 'Code Action' },
    },
  }

  local keymap_goto = {
    name = '+goto',
    r = { 'Goto References' },
    d = { '<Cmd>lua vim.lsp.buf.definition()<CR>', 'Goto Definition' },
    dv = { '<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>', 'Goto Definition' },
    ds = { '<Cmd>split | lua vim.lsp.buf.definition()<CR>', 'Goto Definition' },
    s = { '<Cmd>lua vim.lsp.buf.signature_help()<CR>', 'Signature Help' },
    I = { '<Cmd>lua vim.lsp.buf.implementation()<CR>', 'Goto Implementation' },
  }

  vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { buffer = 0, silent = true })
  vim.keymap.set('n', '[w', function()
    vim.diagnostic.goto_prev { opts = { focus = false } }
  end, {
    buffer = 0,
    silent = true,
  })
  vim.keymap.set('n', ']w', function()
    vim.diagnostic.goto_next { opts = { focus = false } }
  end, {
    buffer = 0,
    silent = true,
  })
  vim.keymap.set('i', '<C-s>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', { silent = true, buffer = 0 })

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    keymap.c.f = { '<Cmd>lua vim.lsp.buf.formatting()<CR>', 'Format Document' }
    vim.bo.formatexpr = 'v:lua.vim.lsp.formatexpr()'
  end

  if client.server_capabilities.documentRangeFormattingProvider then
    keymap_visual.c.f = { '<Cmd>lua vim.lsp.buf.range_formatting()<CR>', 'Format Range' }
  end

  wk.register(keymap, { buffer = bufnr, prefix = '<leader>' })
  wk.register(keymap_visual, { buffer = bufnr, prefix = '<leader>', mode = 'v' })
  wk.register(keymap_goto, { buffer = bufnr, prefix = 'g' })
end

return M
