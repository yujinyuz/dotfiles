vim.g.CommandTPreferredImplementation = 'lua'
vim.g.CommandTFileScanner = 'ripgrep'
vim.g.CommandTWildIgnore = '*/.git/*,*/__pycache__/*'

local has_commandt, commandt = pcall(require, 'wincent.commandt')

if not has_commandt then
  return
end

commandt.setup()
