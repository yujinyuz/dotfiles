-- Here resides some config files that require minimal config
local nmap = vim.keymap.nmap
local nnoremap = vim.keymap.nnoremap
local inoremap = vim.keymap.inoremap

-- vim-closetag
vim.g.closetag_filename = '*.html,*.js,*.erb,*.hbs'
vim.g.closetag_emptyTags_caseSensitive = 1

-- nvim-compe
-- local npairs = require('nvim-autopairs')
-- npairs.setup()
-- _G.MUtils= {}

-- vim.g.completion_confirm_key = ""
-- MUtils.completion_confirm = function()
--   if vim.fn.pumvisible() ~= 0  then
--     if vim.fn.complete_info()["selected"] ~= -1 then
--       vim.fn["compe#confirm"]()
--       return npairs.esc("<c-y>")
--     else
--       vim.defer_fn(function()
--         vim.fn["compe#confirm"]("<cr>")
--       end, 20)
--       return npairs.esc("<c-n>")
--     end
--   else
--     return npairs.check_break_line_char()
--   end
-- end
-- nvim-compe
inoremap { '<Tab>', [[pumvisible() ? "\<C-n>": "\<Tab>"]], expr = true }
inoremap { '<S-Tab>', [[pumvisible() ? "\<C-p>": "\<S-Tab>"]], expr = true }
inoremap { '<C-Space>', [[compe#complete() ]], silent = true, expr = true }
inoremap { '<C-y>', [[compe#confirm('<CR>')]], silent = true, expr = true }
inoremap { '<C-e>', [[compe#close()]], silent = true, expr = true }

-- vim-fugitive
nnoremap { '<leader>gs', '<Cmd>Git<CR>' }

-- vim-dirvish
nnoremap { '<leader>.', '<Cmd>Dirvish %:p:h<CR>' }

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

-- vim-go
vim.g.go_def_mapping_enabled = 0
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_structs = 1
vim.g.go_fmt_command = 'goimports'

-- nvim-dap
vim.g.dap_virtual_text = true

-- saga
-- require('lspsaga').init_lsp_saga {}
-- nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR> -- or open_float_terminal('lazygit')<CR>
-- tnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>
-- helpers.create_mappings {
--   n = {
--     {lhs = '<A-d>', rhs = helpers.cmd_map([[lua require('lspsaga.floaterm').open_float_terminal('fish')]]), opts = {noremap = true, silent = true}},
--   },
--   t = {
--     {lhs = '<A-d>', rhs = helpers.cmd_map([[lua require('lspsaga.floaterm').close_float_terminal()]]), opts = {noremap = true, silent = true}},
--   }
-- }
