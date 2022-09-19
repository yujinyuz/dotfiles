local has_fterm, fterm = pcall(require, 'FTerm')
if not has_fterm then
  return
end

fterm.setup {}

local htop = fterm:new {
  ft = 'fterm_btop',
  cmd = 'htop',
}

-- Use this to toggle btop in a floating terminal
local function fterm_htop()
  htop:toggle()
end

vim.keymap.set({ 'n', 't' }, '<A-h>', fterm_htop, {})
