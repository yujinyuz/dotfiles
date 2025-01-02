return {
  {
    'SidOfc/mkdx',
    ft = 'markdown',
    init = function()
      local settings = {
        -- Use GitHub supported toggles
        checkbox = {
          toggles = { ' ', 'x' },
        },
        enter = {
          shift = 1,
        },
      }
      vim.g['mkdx#settings'] = settings
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
    ft = 'markdown',
  },
  { 'Vimjas/vim-python-pep8-indent', ft = 'python', enabled = false },
  { 'drmingdrmer/vim-indent-lua', ft = 'lua' },
  { 'michaeljsmith/vim-indent-object', ft = 'python' },
  { 'martinda/Jenkinsfile-vim-syntax', ft = { 'groovy', 'Jenkinsfile' } },
  { 'thecodesmith/vim-groovy', ft = 'groovy' },
  { 'fladson/vim-kitty', ft = 'kitty' },
  { 'NoahTheDuke/vim-just', ft = 'just' },
  { 'cuducos/yaml.nvim', ft = { 'yaml' } },
  { 'HiPhish/jinja.vim', ft = { 'jinja' } },
}
