local has_mason, mason = pcall(require, 'mason')

if not has_mason then
  return
end

mason.setup {}
