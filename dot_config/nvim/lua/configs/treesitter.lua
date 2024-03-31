local has_ts, ts_configs = pcall(require, 'nvim-treesitter.configs')
if not has_ts then
  return
end

local langs = {
  'bash',
  'c',
  'cmake',
  'cpp',
  'css',
  'diff',
  'fennel',
  'fish',
  'git_config',
  'git_rebase',
  'gitcommit',
  'gitignore',
  'go',
  'graphql',
  'html',
  'htmldjango',
  'javascript',
  'latex',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'nix',
  'python',
  'regex',
  'ruby',
  'rust',
  'svelte',
  'toml',
  'tsx',
  'typescript',
  'vimdoc',
  'vue',
  'yaml',
  -- 'comment',
  -- 'json',
  -- 'jsonc',
}

ts_configs.setup {
  ensure_installed = langs,
  highlight = {
    enable = true,
    disable = { 'json' },
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, disable = { 'python', 'lua' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<M-w>',
      node_incremental = '<M-w>',
      scope_incremental = '<M-e>',
      node_decremental = '<M-C-w>',
    },
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { 'BufWrite', 'CursorHold' },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = true, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = { query = '@function.outer', desc = 'Select around function' },
        ['if'] = { query = '@function.inner', desc = 'Select inside function' },
        ['ac'] = { query = '@class.outer', desc = 'Select around class' },
        ['ic'] = { query = '@class.inner', desc = 'Select inside class' },

        ['a='] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
        ['i='] = { query = '@assignment.inner', desc = 'Select inside part of an assignment' },

        ['=l'] = { query = '@assignment.lhs', desc = 'Select left-hand side of assignment' },
        ['=r'] = { query = '@assignment.rhs', desc = 'Select right-hand side of assignment' },

        ['aa'] = { query = '@parameter.outer', desc = 'Select around parameter/argument' },
        ['ia'] = { query = '@parameter.inner', desc = 'Select inside parameter/argument' },

        ['ai'] = { query = '@conditional.outer', desc = 'Select outer part of a conditional' },
        ['ii'] = { query = '@conditional.inner', desc = 'Select inner part of a conditional' },
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
      goto_next_end = { [']M'] = '@function.outer', [']['] = '@class.outer' },
      goto_previous_start = { ['[m'] = '@function.outer', ['[['] = '@class.outer' },
      goto_previous_end = { ['[M'] = '@function.outer', ['[]'] = '@class.outer' },
    },
    swap = {
      enable = true,
      swap_next = { ['<leader>>'] = '@parameter.inner' },
      swap_previous = { ['<leader><'] = '@parameter.outer' },
    },
    lsp_interop = {
      enable = true,
      peek_definition_code = {
        ['gD'] = '@function.outer',
      },
    },
  },
  refactor = {
    navigation = {
      enable = true,
    },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = '<leader>rn',
      },
    },
  },
  autopairs = { enable = true },
  autotag = { enable = true, disable = { 'markdown' } },
  endwise = { enable = true },
}

local parsers = require('nvim-treesitter.parsers')
local configs = parsers.get_parser_configs()
local ts_filetypes = vim.tbl_map(function(ft)
  return configs[ft].filetype or ft
end, parsers.available_parsers())

vim.api.nvim_create_autocmd('FileType', {
  pattern = ts_filetypes,
  callback = function()
    vim.opt_local.foldmethod = 'expr'
    vim.opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
  end,
  desc = 'Set nvim_treesitter#foldexpr()',
})
