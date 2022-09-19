if not vim.g.loaded_abolish then
  return
end

vim.cmd([[
  Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
  Abolish {funct}i{no} {funct}i{on}
]])
