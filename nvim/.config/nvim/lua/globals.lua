-- @note: Anything related to globals that are required before neovim is loaded should be in here since
--        this is a file that gets loaded first when neovim starts
vim.g.mapleader = ' '
vim.g.python3_host_prog = vim.env.PYTHON_3_HOST_PROG

vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

vim.g.did_load_filetypes = 1

-- @usage dump(vim.opt)
_G.dump = function(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
  return ...
end

_G.prequire = function(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  end
  return nil
end

-- https://github.com/bfredl/bfredl.github.io/blob/73eb7/nvim/lua/bfredl/init.lua#L15-L17
_G.each = function(z)
  return (function(x)
    return x(x)
  end)(function(x)
    return function(y)
      z(y)
      return x(x)
    end
  end)
end
