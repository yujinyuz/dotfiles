return {
  {
    'tpope/vim-scriptease',
    cmd = { 'Scriptnames', 'Messages', 'Verbose' },
    keys = { 'zS' },
  },
  {
    'wakatime/vim-wakatime',
    event = 'BufReadPost',
  },
  {
    'letieu/hacker.nvim',
    dev = true,
    keys = {
      { '<leader>ha', ':autocmd!<CR><Cmd>HackFollow<CR>', silent = true },
    },
  },
  {
    'eandrju/cellular-automaton.nvim',
    keys = {
      { '<leader>fml', '<cmd>CellularAutomaton make_it_rain<CR>', desc = 'Make it rain' },
    },
  },
}
