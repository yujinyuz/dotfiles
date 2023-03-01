local has_ts, ts_configs = pcall(require, 'nvim-treesitter.configs')
if not has_ts then
  return
end

local langs = {
  'bash',
  'c',
  'cmake',
  -- 'comment',
  'cpp',
  'css',
  'fennel',
  'fish',
  'go',
  'graphql',
  'html',
  'javascript',
  'latex',
  'lua',
  'nix',
  'python',
  'regex',
  'rust',
  'svelte',
  'toml',
  'tsx',
  'typescript',
  'vue',
  'yaml',
  -- 'jsonc',
  -- 'json',
  'markdown',
  'markdown_inline',
}

ts_configs.setup {
  ensure_installed = langs,
  highlight = {
    enable = true,
    disable = { 'json' },
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, disable = { 'python' } }, -- Let nvim-yati handle python since it's still buggy
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
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
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
  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
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
  context_commentstring = { enable = true, enable_autocmd = false },
  matchup = { enable = true },
  rainbow = { enable = true, extended_mode = true, max_file_lines = 1000 },
  pyfold = { enable = true, custom_foldtext = false },
  yati = { enable = true, suppress_conflict_warning = true, disable = { 'python' } },
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