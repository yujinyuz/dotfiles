-- Set statusline
vim.opt.statusline = ''
-- Show mode
vim.opt.statusline:append('[%{mode()}] ')
-- Mark general truncate point
vim.opt.statusline:append('%<')

vim.opt.statusline:append(' %{getbufvar(bufnr("%"), "gitsigns_head", "-")} ')

-- Show filepath where filepath is dimmed and filename is bold
vim.opt.statusline:append('%#StatuslineFilePrefix#')
vim.opt.statusline:append('%{expand("%")!=""?substitute(fnamemodify(expand("%:h"), ":p:~:."), "/$", "", "")."/":""}')
vim.opt.statusline:append('%#StatuslineFilename#%t')
-- Reset highlight
vim.opt.statusline:append('%* ')
-- Show modified flag and readonly flag
vim.opt.statusline:append('%m')
vim.opt.statusline:append('%r')
-- Start right aligned items
vim.opt.statusline:append('%=')
-- Show filetype
vim.opt.statusline:append('%y ')
-- Show filesize
vim.opt.statusline:append('%{getbufvar(bufnr("%"), "bufsize_human", "")} ')
-- Show current line and total lines
vim.opt.statusline:append('ℓ:%l/%L ')
vim.opt.statusline:append('𝚌:%2v/%-2{virtcol("$")-1} ')
-- Show percentage
vim.opt.statusline:append('%p%%')
