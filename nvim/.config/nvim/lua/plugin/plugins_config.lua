-- Here resides some config files that require minimal config
local nmap = vim.keymap.nmap
local nnoremap = vim.keymap.nnoremap
local inoremap = vim.keymap.inoremap

-- vim-closetag
vim.g.closetag_filename = '*.html,*.js,*.erb,*.hbs'
vim.g.closetag_emptyTags_caseSensitive = 1

-- vim-fugitive
nnoremap { '<leader>gs', '<Cmd>Git<CR>' }

-- vim-dirvish
nnoremap { '<leader>.', '<Cmd>Dirvish %<CR>' }

-- Disable netrw
vim.g.loaded_netrwPlugin = 1

-- undotree
vim.g.undotree_HighlightChangedWithSign = 0
vim.g.undotree_WindowLayout = 4
vim.g.undotree_SetFocusWhenToggle = 1
nnoremap { '<leader>u', '<Cmd>UndotreeToggle<CR>' }

-- ferret
vim.g.FerretMap = 0
nmap { '<leader>fa', '<Plug>(FerretAck)' }

-- loupe
nmap { '<C-l>', '<Plug>(LoupeClearHighlight)', silent = true }

-- vim-go
vim.g.go_def_mapping_enabled = 0
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_structs = 1
vim.g.go_fmt_command = 'goimports'

-- nvim-dap
vim.g.dap_virtual_text = true

-- ultisnips
vim.g.UltiSnipsExpandTrigger = '<C-l>'

-- unimpaired overrides
nnoremap { 'yol', '<Cmd>IndentBlanklineToggle!<CR>' }
nnoremap { 'yob', '<Cmd>GitBlameToggle<CR>' }
nnoremap { 'yog', '<Cmd>Neogit<CR>' }


require('nvim-ts-autotag').setup()
