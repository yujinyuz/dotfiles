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
  {
    'mistweaverco/kulala.nvim',
    ft = 'http',
    opts = function()
      return {
        default_view = 'headers_body',
        winbar = true,
        contenttypes = {
          ['text/plain'] = {
            formatter = function(body)
              return body
            end,
          },
          ['application/json'] = {
            ft = 'json',
            formatter = { 'jq', '.' },
            pathresolver = require('kulala.parser.jsonpath').parse,
          },
          ['application/vnd.api+json'] = {
            ft = 'json',
            formatter = { 'jq', '.' },
            pathresolver = require('kulala.parser.jsonpath').parse,
          },
        },
      }
    end,
    keys = {
      {
        '<CR>',
        function()
          require('kulala').run()
        end,
        ft = 'http',
      },
      {
        '<leader>r',
        function()
          require('kulala').run()
        end,
        ft = 'http',
      },
      {
        '<leader>v',
        function()
          require('kulala').toggle_view()
        end,
        ft = 'http',
      },
    },
  },
}
