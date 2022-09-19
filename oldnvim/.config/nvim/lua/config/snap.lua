local snap = require('snap')
local file = snap.config.file:with { reverse = true, consumer = 'fzf' }
local vimgrep = snap.config.vimgrep:with {
  reverse = true,
  consumer = 'fzf',
  limit = 50000,
  mapping = {
    next = { '<C-s>' },
  },
}

snap.register.command(
  'find_files',
  file {
    try = {
      -- snap.get('producer.git.file').args({ '--cached', '--others', '--exclude-standard', '--deduplicate' }),

      -- Passing in the `--sort path` would make it single threaded but at the benefit of having predictable files list
      -- Besides, it doesn't really matter since we are just listing files and there should be little no performance impact
      snap.get('producer.ripgrep.file').args { '--hidden', '--iglob', '!.git/*', '--sort', 'path' },
    },
    prompt = 'Files',
    select = snap.get('select.vimgrep').select,
    multiselect = snap.get('select.vimgrep').multiselect,
    -- preview = false,
  }
)

snap.register.command(
  'nvim',
  file {
    try = {
      snap.get('producer.git.file').args(
        { '--cached', '--others', '--exclude-standard', '--deduplicate' },
        '~/.config/nvim'
      ),

      -- Passing in the `--sort path` would make it single threaded but at the benefit of having predictable files list
      -- Besides, it doesn't really matter since we are just listing files and there should be little no performance impact
      -- snap.get('producer.ripgrep.file').args({ '--hidden', '--iglob', '!.git/*', '--sort', 'path'}, '~/Sources/github.com/yujinyuz/dotfiles/nvim/.config/nvim'),
    },
    prompt = 'Files',
    select = snap.get('select.vimgrep').select,
    multiselect = snap.get('select.vimgrep').multiselect,
    -- preview = false,
  }
)

snap.register.command(
  'buffers',
  file {
    producer = snap.get('producer.vim.buffer'),
    prompt = 'Buffers',
  }
)

snap.register.command(
  'live_grep',
  vimgrep {
    -- https://github.com/camspiers/snap/pull/66#issuecomment-873678089
    producer = snap.get('producer.ripgrep.vimgrep').line { '--smart-case', '--hidden', '--glob=!.git' },
    prompt = 'Live Grep',
  }
)

-- TODO: Pass the result of vimgrep to fzf. Check docs
snap.register.command(
  'grep_word',
  vimgrep {
    -- https://github.com/camspiers/snap/pull/66#issuecomment-873678089
    producer = snap.get('producer.ripgrep.vimgrep').line { '--smart-case', '--hidden', '--glob=!.git' },
    prompt = 'Grep Word',
    filter_with = 'cword',
    steps = { {
      consumer = snap.get('consumer.fzf'),
      config = { prompt = 'FZF>' },
    } },
  }
)

snap.register.command(
  'grep_prompt',
  vimgrep {
    -- https://github.com/camspiers/snap/pull/66#issuecomment-873678089
    producer = snap.get('producer.ripgrep.vimgrep').line { '--smart-case', '--hidden', '--glob=!.git' },
    prompt = 'Grep Prompt',
    filter = function()
      return vim.fn.input('Grep String> ')
    end,
  }
)

-- rg --no-filename --no-heading --no-line-number --word-regexp --color never --only-matching  'from[a-zA-Z_-]+' .
snap.register.command(
  'psuedo_tags',
  vimgrep {
    -- https://github.com/camspiers/snap/pull/66#issuecomment-873678089
    producer = snap.get('producer.ripgrep.vimgrep').line {
      '--smart-case',
      '--hidden',
      '--glob=!.git',
      '--word-regexp',
    },
    prompt = 'Psuedo Tags',
  }
)

vim.cmd([[hi link SnapPosition Special]])
vim.cmd([[hi link SnapBorder TelescopeBorder]])

if vim.env.NVIM_FILE_FINDER ~= 'snap' then
  return
end

vim.keymap.set('n', '<leader>F', '<Cmd>Snap live_grep<CR>')
vim.keymap.set('n', '<leader><Space>', '<Cmd>Snap find_files<CR>')
vim.keymap.set('n', '<leader>n', '<Cmd>Snap find_files<CR>')
vim.keymap.set('n', '<leader>en', '<Cmd>Snap nvim<CR>')
vim.keymap.set('n', '<leader>gw', '<Cmd>Snap grep_word<CR>')
vim.keymap.set('n', '<leader>fw', '<Cmd>Snap grep_prompt<CR>')
vim.keymap.set('n', '<leader>bb', '<Cmd>Snap buffers<CR>')
vim.keymap.set('n', '<leader>of', '<Cmd>Snap old_files<CR>')
