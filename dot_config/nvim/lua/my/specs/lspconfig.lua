local lsp_config = function()
  -- Setup neoconfig before lspconfig
  local has_neoconf, neoconf = pcall(require, 'neoconf')
  if has_neoconf then
    neoconf.setup {}
  end

  -- Set up completion using nvim_cmp with LSP source
  local common_capabilities = require('cmp_nvim_lsp').default_capabilities()
  common_capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  local common_on_init = function(client, _)
    -- Disabled due to https://github.com/neovim/neovim/issues/23164
    -- I've been experiencing this annoying issue where there is a slight delay of applying
    -- highlights when opening certain files:
    --  * lua suddenly changes highlights for global variables
    --  * python (pyright and basedpyright) changes highlights and sometimes italicizes import
    --    statements.
    --  I do not want this. Just let treesitter perform the highlighting for now.
    client.server_capabilities.semanticTokensProvider = false
  end

  local common_on_attach_handler = function(client, bufnr)
    -- +lsp
    vim.keymap.set('n', 'crn', vim.lsp.buf.rename, { buffer = bufnr, desc = '[c]ode [r]efactor [n]ame' })
    vim.keymap.set('n', 'crr', vim.lsp.buf.code_action, { buffer = bufnr, desc = '[c]ode [r]efactor [r]efactor' })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = '[g]oto [r]eferences' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = '[g]oto [d]efinition' })
    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { buffer = bufnr, desc = '[g]oto [I]mplementation' })
    vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'code [s]ignature help' })

    if client.server_capabilities.definitionProvider ~= false then
      vim.opt_local.tagfunc = 'v:lua.vim.lsp.tagfunc'
    end

    if client.server_capabilities.documentSymbolProvider then
      local has_navic, navic = pcall(require, 'nvim-navic')
      if has_navic then
        navic.attach(client, bufnr)
      end
    end
  end

  -- Server config
  local servers = {
    pyright = {
      enabled = false,
      settings = {
        pyright = {
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            -- Ignore all files for analysis to exclusively use Ruff for linting
            ignore = { '*' },
          },
        },
      },
    },
    basedpyright = {
      enabled = true,
      settings = {
        basedpyright = {
          disableOrganizeImports = true,
          -- https://github.com/DetachHead/basedpyright/issues/203
          typeCheckingMode = 'off',
        },
      },
    },
    jedi_language_server = {
      enabled = false,
      init_options = {
        completion = {
          disableSnippets = true,
        },
      },
    },
    ruff = {
      enabled = true,
      on_attach = function(client, bufnr)
        if client.name ~= 'ruff' then
          return
        end
        common_on_attach_handler(client, bufnr)
        client.server_capabilities.hoverProvider = false

        -- Create ruff commands
        vim.api.nvim_create_user_command('RuffAutoFix', function()
          vim.lsp.buf.execute_command {
            command = 'ruff.applyAutofix',
            arguments = {
              { uri = vim.uri_from_bufnr(bufnr) },
            },
          }
        end, { desc = 'Ruff: Fix all auto-fixable problems' })

        vim.api.nvim_create_user_command('RuffOrganizeImports', function()
          vim.lsp.buf.execute_command {
            command = 'ruff.applyOrganizeImports',
            arguments = {
              { uri = vim.uri_from_bufnr(bufnr) },
            },
          }
        end, { desc = 'Ruff: Format imports' })
      end,
    },
    gopls = {},
    html = {},
    cssls = {},
    emmet_language_server = {},
    tailwindcss = {},
    jsonls = {},
    tsserver = {},
    volar = {},
    lua_ls = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        completion = {
          callSnippet = 'Disable',
        },
        codelens = {
          enable = true,
        },
      },
    },
    taplo = {},
    prosemd_lsp = {},
    bashls = {},
  }

  local common_options = {
    enabled = true,
    on_init = common_on_init,
    on_attach = common_on_attach_handler,
    capabilities = common_capabilities,
    flags = {
      debounce_text_changes = 500, -- 150 seems to be the default by idk what this implies
    },
  }

  local mason_lspconfig = require('mason-lspconfig')
  local setup_server_handler = function(server_name)
    if servers[server_name] == nil then
      return
    end

    local server_opts = vim.tbl_deep_extend('force', common_options, servers[server_name] or {})

    if type(server_opts.capabilities) == 'function' then
      server_opts.capabilities = server_opts.capabilities()
    end

    if server_opts.enabled ~= false then
      require('lspconfig')[server_name].setup(server_opts)
    end
  end

  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
    handlers = { setup_server_handler },
  }
end

return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = lsp_config,
    dependencies = {
      { 'folke/neoconf.nvim', cmd = 'Neoconf', config = false },
      { 'folke/neodev.nvim', opts = {} },
      { 'onsails/lspkind-nvim' },
      {
        'SmiteshP/nvim-navic',
        keys = {
          {
            '<C-s>',
            function()
              print(require('nvim-navic').get_location())
            end,
            desc = 'Show current location',
          },
        },
      },
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    opts = {
      ensure_installed = {
        'black',
        'codespell',
        'cspell',
        'djlint',
        'eslint_d',
        'fixjson',
        'hadolint',
        'prettierd',
        'stylua',
        'taplo',
        'write-good',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')

      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end

      if mr.refresh() then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
