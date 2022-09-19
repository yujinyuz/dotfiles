-- Using pcall here since doing a fresh setup, Abolish might not have been installed
-- pcall is basically similar to a try/catch in most programming languages
pcall(vim.cmd, [[
  Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
  Abolish {funct}i{no} {funct}i{on}
]])
