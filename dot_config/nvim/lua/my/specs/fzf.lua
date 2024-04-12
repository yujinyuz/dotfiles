local keys = {
  {
    '<leader>n',
    function()
      require('fzf-lua').files {
        cwd_prompt = false,
        prompt = 'Files> ',
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
        winopts = { preview = { hidden = 'nohidden' } },
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
    '<leader>fb',
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
    '<leader>\\',
    '<Cmd>FzfLua lsp_live_workspace_symbols<CR>',
  },
  {
    '<C-x><C-f>',
    function()
      require('fzf-lua').complete_path()
    end,
    mode = 'i',
  },
}

local config = function()
  local fzf = require('fzf-lua')
  local actions = require('fzf-lua.actions')
  local defaults = require('fzf-lua.defaults').defaults

  fzf.setup {
    actions = {
      files = {
        ['default'] = actions.file_edit,
        ['ctrl-x'] = actions.file_split,
        ['ctrl-v'] = actions.file_vsplit,
        ['ctrl-t'] = actions.file_tabedit,
        ['alt-q'] = actions.file_sel_to_qf,
      },
      buffers = {
        ['default'] = actions.buf_edit,
        ['ctrl-x'] = actions.buf_split,
        ['ctrl-v'] = actions.buf_vsplit,
        ['ctrl-t'] = actions.buf_tabedit,
      },
    },
    winopts = {
      preview = {
        delay = 0,
      },
      height = 0.75,
      width = 0.80,
    },
    fzf_opts = {
      ['--no-hscroll'] = '',
      ['--layout'] = 'reverse',
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
    },
    file_icon_padding = '',
    on_create = function()
      vim.keymap.set('t', '<Esc>', '<C-c>', { buffer = 0 })
    end,
  }

  -- Register fzf-lua as the picker for vim.ui.select()
  fzf.register_ui_select()
end

-- TODO:

return {
  'ibhagwan/fzf-lua',
  config = config,
  keys = keys,
}
