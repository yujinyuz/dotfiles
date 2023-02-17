local has_neotree, neotree = pcall(require, 'neo-tree')

if not has_neotree then
  return
end

neotree.setup {
  default_component_configs = {
    indent = {
      with_markers = true,
      indent_marker = '│',
      last_indent_marker = '└',
      indent_size = 2,
    },
  },
  use_default_mappings = false,
  enable_git_status = true,
  enable_diagnostics = true,
  window = {
    mappings = {
      ['<space>'] = 'none',
      ['<2-LeftMouse>'] = 'open',
      ['<cr>'] = 'open',
      ['<C-x>'] = 'open_split',
      ['<C-v>'] = 'open_vsplit',
      -- ["S"] = "split_with_window_picker",
      -- ["s"] = "vsplit_with_window_picker",
      ['w'] = 'none', -- I'm using `w` when jumping through words so I want to disable it
      ['<C-t>'] = 'open_tabnew',
      ['C'] = 'close_node',
      ['a'] = {
        'add',
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = 'relative', -- "none", "relative", "absolute"
        },
      },
      ['A'] = 'add_directory', -- also accepts the config.show_path option.
      ['d'] = 'delete',
      ['r'] = 'rename',
      ['y'] = 'copy_to_clipboard',
      ['x'] = 'cut_to_clipboard',
      ['p'] = 'paste_from_clipboard',
      ['c'] = 'copy', -- takes text input for destination
      ['m'] = 'move', -- takes text input for destination
      ['q'] = 'close_window',
      ['R'] = 'refresh',
      ['?'] = 'show_help',
    },
  },
  filesystem = {
    follow_current_file = true, -- This will find and focus the file in the active buffer every
    -- time the current file is changed while the tree is open.
    hijack_netrw_behavior = 'disabled', -- netrw disabled, opening a directory opens neo-tree
    -- in whatever position is specified in window.position
    -- "open_current",  -- netrw disabled, opening a directory opens within the
    -- window like netrw would, regardless of window.position
    -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
    use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
    -- instead of relying on nvim autocmd events.
    window = {
      mappings = {
        ['<bs>'] = 'navigate_up',
        ['.'] = 'set_root',
        ['H'] = 'toggle_hidden',
        ['/'] = 'fuzzy_finder',
        ['f'] = 'filter_on_submit',
        -- ['<C-x>'] = 'clear_filter',
        ['<Esc>'] = 'clear_filter',
        ['o'] = 'system_open',
      },
    },
    commands = {
      system_open = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        -- macOs specific -- open file in default application in the background
        vim.api.nvim_command('silent !open -g ' .. path)
      end,
    },
  },
  buffers = {
    show_unloaded = true,
    window = {
      mappings = {
        ['bd'] = 'buffer_delete',
        ['<bs>'] = 'navigate_up',
        ['.'] = 'set_root',
      },
    },
  },
}
