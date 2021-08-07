local snap = require('snap')
local file = snap.config.file:with({ reverse = true, consumer = 'fzf' })
local vimgrep = snap.config.vimgrep:with({
  reverse = true,
  consumer = 'fzf',
  limit = 50000,
})

snap.maps({
  {
    '<leader><leader>',
    file({
      try = {
        -- snap.get('producer.git.file').args({ '--cached', '--others', '--exclude-standard', ' | uniq' }),
        snap.get('producer.git.file').args({ '--cached', '--others', '--exclude-standard', '--deduplicate' }),
        'ripgrep.file',
      },
      prompt = 'Files',
    }),
    command = { 'files' },
  },
  {
    '<leader>F',
    vimgrep({
      -- https://github.com/camspiers/snap/pull/66#issuecomment-873678089
      producer = snap.get('producer.ripgrep.vimgrep').line({ '--smart-case', '--hidden' }),
      prompt = 'Live Grep',
    }),
  },
})
