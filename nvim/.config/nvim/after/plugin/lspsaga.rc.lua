local has_lspsaga, saga = pcall(require, 'lspsaga')
if not has_lspsaga then
  return
end

saga.setup {
  code_action_lightbulb = {
    sign = false,
  },
}
