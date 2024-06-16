return {
  {
    'tpope/vim-eunuch',
    cmd = { 'Delete', 'Move', 'Rename' },
  },
  {
    'ludovicchabant/vim-gutentags',
    event = 'VeryLazy',
    init = function()
      vim.g.gutentags_project_root = { '.croot' }
      vim.g.gutentags_define_advanced_commands = true
      vim.g.gutentags_add_default_project_roots = false
    end,
  },
  {
    'yujinyuz/mini.files',
    dev = true,
    version = false,
    init = function()
      vim.g.mini_files_auto_confirm_on_simple_edits = true
    end,
    opts = {
      options = {
        use_as_default_explorer = false,
      },
      mappings = {
        go_in_plus = '<CR>',
      },
    },
    keys = {
      {
        ',t',
        function()
          local mf = require('mini.files')
          if not mf.close() then
            mf.open(vim.api.nvim_buf_get_name(0))
            mf.reveal_cwd()
          end
        end,
      },
    },
  },
  {
    'stevearc/oil.nvim',
    event = 'VeryLazy',
    opts = {
      columns = { 'icon' },
      view_options = {
        show_hidden = false,
      },
      win_options = {
        wrap = false,
        signcolumn = 'no',
        cursorcolumn = false,
        foldcolumn = '0',
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = 'nvic',
      },
      keymaps = {
        ['<C-c>'] = false,
        ['q'] = 'actions.close',
        ['<C-l>'] = false,
        ['<C-r>'] = 'actions.refresh',
        ['y.'] = 'actions.copy_entry_path',
      },
      skip_confirm_for_simple_edits = true,
    },
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    cmd = { 'AerialToggle' },
    keys = {
      { '\\t', '<cmd>AerialToggle<cr>', desc = '' },
    },
  },
  {
    'otavioschwanck/arrow.nvim',
    keys = {
      { ',a', desc = '[a]rrow' },
    },
    opts = {
      show_icons = true,
      leader_key = ',a',
      separate_by_branch = true,
    },
  },
}
