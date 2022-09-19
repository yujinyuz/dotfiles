local has_lspsaga, saga = pcall(require, 'lspsaga')
if not has_lspsaga then
  return
end

saga.init_lsp_saga {
  code_action_lightbulb = {
    sign = false,
  },
}
