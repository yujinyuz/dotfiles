" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif
try

lua << END
  local package_path_str = "/Users/eugene/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/eugene/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/eugene/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/eugene/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
  local install_cpath_pattern = "/Users/eugene/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
  if not string.find(package.path, package_path_str, 1, true) then
    package.path = package.path .. ';' .. package_path_str
  end

  if not string.find(package.cpath, install_cpath_pattern, 1, true) then
    package.cpath = package.cpath .. ';' .. install_cpath_pattern
  end

_G.packer_plugins = {
  ["completion-treesitter"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/completion-treesitter"
  },
  ferret = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/ferret"
  },
  gruvbox = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n\21\0\0\1\0\1\0\2'\0\0\0L\0\2\0\n%f %mµ\3\1\0\4\0\27\0-6\0\0\0'\2\1\0B\0\2\0023\1\2\0006\2\3\0009\2\4\2+\3\1\0=\3\5\2'\2\a\0=\2\6\0'\2\t\0=\2\b\0005\2\f\0005\3\v\0=\3\r\0025\3\14\0=\3\15\0024\3\3\0>\1\1\3=\3\16\0025\3\17\0=\3\18\0025\3\19\0=\3\20\0025\3\21\0=\3\22\2=\2\n\0005\2\24\0004\3\0\0=\3\r\0024\3\0\0=\3\15\0024\3\3\0>\1\1\3=\3\16\0025\3\25\0=\3\18\0024\3\0\0=\3\20\0024\3\0\0=\3\22\2=\2\23\0009\2\26\0B\2\1\1K\0\1\0\vstatus\1\2\0\0\rlocation\1\0\0\22inactive_sections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\14lualine_b\1\2\0\0\vbranch\14lualine_a\1\0\0\1\2\0\0\tmode\rsections\6|\14separator\fgruvbox\ntheme\rshowmode\6o\bvim\0\flualine\frequire\0" },
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\2\n®\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\vsource\1\0\4\tpath\2\ttags\2\rnvim_lsp\2\vbuffer\2\1\0\5\fenabled\2\ndebug\1\25allow_prefix_unmatch\1\14preselect\venable\15min_length\3\1\nsetup\ncompe\frequire\0" },
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-dap"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-dap-python"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-dap-python"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["telescope-fzf-writer.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/telescope-fzf-writer.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ultisnips = {
    config = { "\27LJ\2\n>\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\n<C-l>\27UltiSnipsExpandTrigger\6g\bvim\0" },
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  undotree = {
    commands = { "UndotreeToggle" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/opt/undotree"
  },
  ["vim-apathy"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-apathy"
  },
  ["vim-closetag"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/opt/vim-closetag"
  },
  ["vim-commentary"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-dirvish"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-dirvish"
  },
  ["vim-dispatch"] = {
    commands = { "Dispatch", "Make", "Focus", "Start" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/opt/vim-dispatch"
  },
  ["vim-dyad"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-dyad"
  },
  ["vim-eunuch"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-fugitive"] = {
    commands = { "G", "Git", "Glog", "Gbrowse", "Gblame", "Gcommit", "Gcd", "Gvdiffsplit", "Gwrite" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/opt/vim-fugitive"
  },
  ["vim-gutentags"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-gutentags"
  },
  ["vim-projectionist"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-projectionist"
  },
  ["vim-python-pep8-indent"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-python-pep8-indent"
  },
  ["vim-repeat"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-rsi"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-rsi"
  },
  ["vim-scriptease"] = {
    commands = { "Scriptnames", "Messages" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/opt/vim-scriptease"
  },
  ["vim-snippets"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-surround"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-textobj-entire"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-textobj-entire"
  },
  ["vim-textobj-indent"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-textobj-indent"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-textobj-user"
  },
  ["vim-tmux-focus-events"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-tmux-focus-events"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-wakatime"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/Users/eugene/.local/share/nvim/site/pack/packer/start/vim-wakatime"
  }
}

local function handle_bufread(names)
  for _, name in ipairs(names) do
    local path = packer_plugins[name].path
    for _, dir in ipairs({ 'ftdetect', 'ftplugin', 'after/ftdetect', 'after/ftplugin' }) do
      if #vim.fn.finddir(dir, path) > 0 then
        vim.cmd('doautocmd BufRead')
        return
      end
    end
  end
end

local packer_load = nil
local function handle_after(name, before)
  local plugin = packer_plugins[name]
  plugin.load_after[before] = nil
  if next(plugin.load_after) == nil then
    packer_load({name}, {})
  end
end

packer_load = function(names, cause)
  local some_unloaded = false
  for _, name in ipairs(names) do
    if not packer_plugins[name].loaded then
      some_unloaded = true
      break
    end
  end

  if not some_unloaded then return end

  local fmt = string.format
  local del_cmds = {}
  local del_maps = {}
  for _, name in ipairs(names) do
    if packer_plugins[name].commands then
      for _, cmd in ipairs(packer_plugins[name].commands) do
        del_cmds[cmd] = true
      end
    end

    if packer_plugins[name].keys then
      for _, key in ipairs(packer_plugins[name].keys) do
        del_maps[key] = true
      end
    end
  end

  for cmd, _ in pairs(del_cmds) do
    vim.cmd('silent! delcommand ' .. cmd)
  end

  for key, _ in pairs(del_maps) do
    vim.cmd(fmt('silent! %sunmap %s', key[1], key[2]))
  end

  for _, name in ipairs(names) do
    if not packer_plugins[name].loaded then
      vim.cmd('packadd ' .. name)
      if packer_plugins[name].config then
        for _i, config_line in ipairs(packer_plugins[name].config) do
          loadstring(config_line)()
        end
      end

      if packer_plugins[name].after then
        for _, after_name in ipairs(packer_plugins[name].after) do
          handle_after(after_name, name)
          vim.cmd('redraw')
        end
      end

      packer_plugins[name].loaded = true
    end
  end

  handle_bufread(names)

  if cause.cmd then
    local lines = cause.l1 == cause.l2 and '' or (cause.l1 .. ',' .. cause.l2)
    vim.cmd(fmt('%s%s%s %s', lines, cause.cmd, cause.bang, cause.args))
  elseif cause.keys then
    local keys = cause.keys
    local extra = ''
    while true do
      local c = vim.fn.getchar(0)
      if c == 0 then break end
      extra = extra .. vim.fn.nr2char(c)
    end

    if cause.prefix then
      local prefix = vim.v.count ~= 0 and vim.v.count or ''
      prefix = prefix .. '"' .. vim.v.register .. cause.prefix
      if vim.fn.mode('full') == 'no' then
        if vim.v.operator == 'c' then
          prefix = '' .. prefix
        end

        prefix = prefix .. vim.v.operator
      end

      vim.fn.feedkeys(prefix, 'n')
    end

    local escaped_keys = vim.api.nvim_replace_termcodes(cause.keys .. extra, true, true, true)
    vim.api.nvim_feedkeys(escaped_keys, 'm', true)
  elseif cause.event then
    vim.cmd(fmt('doautocmd <nomodeline> %s', cause.event))
  elseif cause.ft then
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeplugin', cause.ft))
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeindent', cause.ft))
  end
end

_packer_load_wrapper = function(names, cause)
  success, err_msg = pcall(packer_load, names, cause)
  if not success then
    vim.cmd('echohl ErrorMsg')
    vim.cmd('echomsg "Error in packer_compiled: ' .. vim.fn.escape(err_msg, '"') .. '"')
    vim.cmd('echomsg "Please check your config for correctness"')
    vim.cmd('echohl None')
  end
end

-- Runtimepath customization

-- Pre-load configuration
-- Setup for: vim-closetag
loadstring("\27LJ\2\n|\0\0\2\0\5\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0K\0\1\0%closetag_emptyTags_caseSensitive\28*.html,*.js,*.erb,*.hbs\22closetag_filename\6g\bvim\0")()
vim.cmd("packadd vim-closetag")
-- Post-load configuration
-- Config for: lualine.nvim
loadstring("\27LJ\2\n\21\0\0\1\0\1\0\2'\0\0\0L\0\2\0\n%f %mµ\3\1\0\4\0\27\0-6\0\0\0'\2\1\0B\0\2\0023\1\2\0006\2\3\0009\2\4\2+\3\1\0=\3\5\2'\2\a\0=\2\6\0'\2\t\0=\2\b\0005\2\f\0005\3\v\0=\3\r\0025\3\14\0=\3\15\0024\3\3\0>\1\1\3=\3\16\0025\3\17\0=\3\18\0025\3\19\0=\3\20\0025\3\21\0=\3\22\2=\2\n\0005\2\24\0004\3\0\0=\3\r\0024\3\0\0=\3\15\0024\3\3\0>\1\1\3=\3\16\0025\3\25\0=\3\18\0024\3\0\0=\3\20\0024\3\0\0=\3\22\2=\2\23\0009\2\26\0B\2\1\1K\0\1\0\vstatus\1\2\0\0\rlocation\1\0\0\22inactive_sections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\14lualine_b\1\2\0\0\vbranch\14lualine_a\1\0\0\1\2\0\0\tmode\rsections\6|\14separator\fgruvbox\ntheme\rshowmode\6o\bvim\0\flualine\frequire\0")()
-- Config for: ultisnips
loadstring("\27LJ\2\n>\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\n<C-l>\27UltiSnipsExpandTrigger\6g\bvim\0")()
-- Config for: nvim-compe
loadstring("\27LJ\2\n®\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\vsource\1\0\4\tpath\2\ttags\2\rnvim_lsp\2\vbuffer\2\1\0\5\fenabled\2\ndebug\1\25allow_prefix_unmatch\1\14preselect\venable\15min_length\3\1\nsetup\ncompe\frequire\0")()
-- Conditional loads
-- Load plugins in order defined by `after`
END

function! s:load(names, cause) abort
  call luaeval('_packer_load_wrapper(_A[1], _A[2])', [a:names, a:cause])
endfunction


" Command lazy-loads
command! -nargs=* -range -bang -complete=file Start call s:load(['vim-dispatch'], { "cmd": "Start", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Gvdiffsplit call s:load(['vim-fugitive'], { "cmd": "Gvdiffsplit", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Gwrite call s:load(['vim-fugitive'], { "cmd": "Gwrite", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Gcd call s:load(['vim-fugitive'], { "cmd": "Gcd", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Gcommit call s:load(['vim-fugitive'], { "cmd": "Gcommit", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Gblame call s:load(['vim-fugitive'], { "cmd": "Gblame", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Gbrowse call s:load(['vim-fugitive'], { "cmd": "Gbrowse", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Scriptnames call s:load(['vim-scriptease'], { "cmd": "Scriptnames", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Messages call s:load(['vim-scriptease'], { "cmd": "Messages", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Glog call s:load(['vim-fugitive'], { "cmd": "Glog", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file G call s:load(['vim-fugitive'], { "cmd": "G", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Git call s:load(['vim-fugitive'], { "cmd": "Git", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file UndotreeToggle call s:load(['undotree'], { "cmd": "UndotreeToggle", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Dispatch call s:load(['vim-dispatch'], { "cmd": "Dispatch", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Make call s:load(['vim-dispatch'], { "cmd": "Make", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Focus call s:load(['vim-dispatch'], { "cmd": "Focus", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })

" Keymap lazy-loads

augroup packer_load_aucmds
  au!
  " Filetype lazy-loads
  " Event lazy-loads
  " Function lazy-loads
augroup END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
