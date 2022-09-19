local has_icons, icons = pcall(require, 'nvim-web-devicons')
if not has_icons then
  return
end

icons.setup {
  override = {
    lir_folder_icon = {
      icon = '',
      color = '#7ebae4',
      name = 'lirfoldernode',
    },
  },
  default = true,
}
