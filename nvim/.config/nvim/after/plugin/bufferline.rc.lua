local has_bufferline, bufferline = pcall(require, 'bufferline')
if not has_bufferline then
  return
end

bufferline.setup {
  options = {
    mode = 'tabs',
    separator_style = 'thick',
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true,
    sort_by = 'tabs',
  },
}
