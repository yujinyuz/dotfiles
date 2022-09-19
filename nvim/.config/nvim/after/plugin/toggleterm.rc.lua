local has_toggleterm, toggleterm = pcall(require, 'toggleterm')
if not has_toggleterm then
  return
end

toggleterm.setup {
  shell = vim.env.SHELL,
  shade_terminals = false,
  highlights = {
    Normal = {
      guibg = 'NONE',
    },
    NormalFloat = {
      link = 'Normal',
    },
  },
}
