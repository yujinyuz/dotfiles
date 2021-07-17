local snap = require('snap')
local file = snap.config.file:with{reverse = false, consumer = 'fzf'}
local vimgrep = snap.config.vimgrep:with{
  reverse = false,
  consumer = 'fzf',
  limit = 50000,
}

snap.maps {
  {
    '<leader><leader>', file {
      try = {
        snap.get('producer.git.file').args({'--cached', '--others', '--exclude-standard'}),
        'ripgrep.file',
      },
      prompt = 'Files',
    },
    command = {'files'},
  },
  {'<leader>F', vimgrep {
    -- https://github.com/camspiers/snap/pull/66#issuecomment-873678089
    producer = snap.get('producer.ripgrep.vimgrep').line {'--hidden'},
    prompt = 'Live Grep'
  }},
}
