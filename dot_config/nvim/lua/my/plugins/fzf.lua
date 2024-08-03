local keys = {
  {
    'F',
    mode = 'c',
  },
  {
    'f',
    mode = 'c',
  },
  {
    '<leader>n',
    function()
      require('fzf-lua').files {
        cwd_prompt = false,
        fzf_opts = { ['--ansi'] = false },
        file_icons = false,
        git_icons = false,
        winopts = {
          preview = { hidden = 'hidden' },
        },
      }
    end,
    desc = 'Find files',
  },
  {
    '<leader>]',
    function()
      require('fzf-lua').tags {
        winopts = { preview = { hidden = 'hidden' } },
        file_icons = false,
        git_icons = false,
      }
    end,
    desc = 'Tags',
  },
  {
    '<leader>F',
    function()
      require('fzf-lua').live_grep_glob {
        winopts = { preview = { hidden = 'hidden' } },
        exec_empty_query = true,
      }
    end,
    desc = '[F]ind text',
  },
  {
    '<leader>R',
    '<Cmd>FzfLua resume<CR>',
    desc = '[R]esume',
  },
  {
    '<leader>fb',
    '<Cmd>FzfLua buffers<CR>',
  },
  {
    '<localleader>b',
    '<Cmd>FzfLua buffers<CR>',
  },
  {
    '<leader>fw',
    '<Cmd>FzfLua grep_cword<CR>',
  },
  {
    '<leader>gr',
    '<Cmd>FzfLua lsp_references<CR>',
  },
  {
    '<leader>?',
    '<Cmd>FzfLua lines<CR>',
  },
  {
    '<leader>N',
    '<Cmd>FzfLua resume<CR>',
  },
  {
    '<leader>fh',
    '<Cmd>FzfLua help_tags<CR>',
  },
  {
    '<leader>fo',
    '<Cmd>FzfLua oldfiles<CR>',
  },
  {
    '<leader>\\',
    '<Cmd>FzfLua lsp_live_workspace_symbols<CR>',
  },
  {
    ',b',
    '<Cmd>FzfLua buffers<CR>',
  },
}

local config = function()
  local fzf = require('fzf-lua')
  local actions = require('fzf-lua.actions')
  local defaults = require('fzf-lua.defaults').defaults

  fzf.setup {
    'default-title',
    actions = {
      files = {
        ['default'] = actions.file_edit,
        ['ctrl-s'] = actions.file_split,
        ['ctrl-v'] = actions.file_vsplit,
        ['ctrl-t'] = actions.file_tabedit,
        ['alt-q'] = actions.file_sel_to_qf,
      },
      buffers = {
        ['default'] = actions.buf_edit,
        ['ctrl-s'] = actions.buf_split,
        ['ctrl-v'] = actions.buf_vsplit,
        ['ctrl-t'] = actions.buf_tabedit,
      },
    },
    winopts = {
      backdrop = false,
      preview = {
        delay = 0,
        layout = 'flex',
        flip_columns = 130,
      },
      height = 0.75,
      width = 0.80,
    },
    fzf_opts = {
      ['--no-hscroll'] = '',
      ['--layout'] = 'default',
    },
    keymap = {
      builtin = {
        ['<C-d>'] = 'preview-page-down',
        ['<C-u>'] = 'preview-page-up',
        ['<C-h>'] = 'toggle-preview',
        ['<C-y>'] = 'toggle-preview-wrap',
        ['<C-b>'] = 'toggle-preview-cw',
      },
    },
    files = {
      fd_opts = '--strip-cwd-prefix ' .. defaults.files.fd_opts,
      git_icons = false,
    },
    git = {
      files = {
        cmd = defaults.git.files.cmd .. ' --cached --others --deduplicate',
        git_icons = false,
        file_icons = false,
      },
    },
    grep = {
      git_icons = false,
      file_icons = false,
      multiline = 1,
    },
    on_create = function()
      vim.keymap.set('t', '<Esc>', '<C-c>', { buffer = 0 })
    end,
  }
end

return {
  'ibhagwan/fzf-lua',
  config = config,
  keys = keys,
}
