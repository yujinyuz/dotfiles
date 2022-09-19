local has_kanagawa, kanagawa = pcall(require, 'kanagawa')

if not has_kanagawa then
  return
end

kanagawa.setup {
  globalStatus = true,
  overrides = {
    FloatBorder = { bg = 'NONE' },
    NormalFloat = { bg = 'NONE' },
  },
}

vim.cmd([[ colorscheme kanagawa ]])
