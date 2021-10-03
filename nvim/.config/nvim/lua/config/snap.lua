local snap = require('snap')
local file = snap.config.file:with({ reverse = true, consumer = 'fzf' })
local vimgrep = snap.config.vimgrep:with({
  reverse = true,
  consumer = 'fzf',
  limit = 50000,
})

snap.register.command(
  'find_files',
  file({
    try = {
      -- snap.get('producer.git.file').args({ '--cached', '--others', '--exclude-standard', ' | uniq' }),
      snap.get('producer.git.file').args({ '--cached', '--others', '--exclude-standard', '--deduplicate' }),
      'ripgrep.file',
    },
    prompt = 'Files',
  })
)

snap.register.command(
  'live_grep',
  vimgrep({
    -- https://github.com/camspiers/snap/pull/66#issuecomment-873678089
    producer = snap.get('producer.ripgrep.vimgrep').line({ '--smart-case', '--hidden', '--glob=!.git' }),
    prompt = 'Live Grep',
  })
)

vim.keymap.nnoremap({ '<leader>F', '<Cmd>Snap live_grep<CR>' })
vim.cmd([[hi link SnapPosition Special]])
vim.cmd([[hi link SnapBorder TelescopeBorder]])
