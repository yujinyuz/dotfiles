local has_gitlinker, gitlinker = pcall(require, 'gitlinker')
if not has_gitlinker then
  return
end

gitlinker.setup {}
