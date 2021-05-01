vim.cmd [[colorscheme gruvbox-material]]

vim.cmd [[
  let g:terminal_color_0  = '#2e3436'
  let g:terminal_color_1  = '#cc0000'
  let g:terminal_color_2  = '#4e9a06'
  let g:terminal_color_3  = '#c4a000'
  let g:terminal_color_4  = '#3465a4'
  let g:terminal_color_5  = '#75507b'
  let g:terminal_color_6  = '#0b939b'
  let g:terminal_color_7  = '#d3d7cf'
  let g:terminal_color_8  = '#555753'
  let g:terminal_color_9  = '#ef2929'
  let g:terminal_color_10 = '#8ae234'
  let g:terminal_color_11 = '#fce94f'
  let g:terminal_color_12 = '#729fcf'
  let g:terminal_color_13 = '#ad7fa8'
  let g:terminal_color_14 = '#00f5e9'
  let g:terminal_color_15 = '#eeeeec'
]]

-- vim.cmd [[colorscheme gruvbox]]
-- require('colorbuddy').colorscheme('onebuddy')

-- Errors in Red
vim.cmd [[hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red]]

-- Warnings in Yellow
vim.cmd [[hi LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow ]]

-- Info and Hints in White
vim.cmd [[hi LspDiagnosticsVirtualTextInformation guifg=White ctermfg=White]]
vim.cmd [[hi LspDiagnosticsVirtualTextHint guifg=White ctermfg=White]]

-- Underline the offending code
vim.cmd [[hi LspDiagnosticsUnderlineError guifg=NONE ctermfg=NONE cterm=underline gui=underline]]
vim.cmd [[hi LspDiagnosticsUnderlineWarning guifg=NONE ctermfg=NONE cterm=underline gui=underline]]
vim.cmd [[hi LspDiagnosticsUnderlineInformation guifg=NONE ctermfg=NONE cterm=underline gui=underline]]
vim.cmd [[hi LspDiagnosticsUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline]]
