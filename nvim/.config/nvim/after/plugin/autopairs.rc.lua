local has_autopairs, autopairs = pcall(require, 'nvim-autopairs')

if not has_autopairs then
  return
end

autopairs.setup {
  disable_filetype = { 'TelescopePrompt', 'vim', 'markdown', 'neo-tree-popup' },
  map_c_w = true,
  check_ts = true,
}
