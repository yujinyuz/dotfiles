-- Config specific for nightly
if not vim.version().prerelease then
  return
end

vim.opt.cmdheight = 0

-- Coz having `laststatus=3` makes other windows filename not get displayed
vim.opt.winbar = vim.opt.winbar
  + "%{winnr() > 9 ? ' ':''}"
  + "%{winnr() == 1 ? ' ':''}"
  + "%{winnr() == 2 ? ' ':''}"
  + "%{winnr() == 3 ? ' ':''}"
  + "%{winnr() == 4 ? ' ':''}"
  + "%{winnr() == 5 ? ' ':''}"
  + "%{winnr() == 6 ? ' ':''}"
  + "%{winnr() == 7 ? ' ':''}"
  + "%{winnr() == 8 ? ' ':''}"
  + "%{winnr() == 9 ? ' ':''}"
  + " %{expand('%') == '' ? '[No Name]' : pathshorten(expand('%:~:.'))} "
  -- + '%='
  -- + "%{&modified?' ':''}"
  + "%{&modified?'[+] ':''}"
  + "%{&readonly?' ':''}"
  -- + "%{&paste?'  ':''}"
  + "%{&spell?' ¶ ':''}"
