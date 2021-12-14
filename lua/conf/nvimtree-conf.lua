-- NvimTree Config
local nvimtree = require('nvim-tree')
vim.g.nvim_tree_refresh_wait = 5000
vim.g.nvim_tree_window_picker_exclude = {
  ['filetype'] = {
   'notify',
   '.git',
   'node_modules',
   'packer',
   'qf'
  },
  ['buftype'] = {
   'terminal'
  }
}

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
local mapL = {
  { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
  { key = "l",                            cb = tree_cb("edit") },
  { key = "<Leader>r",                    cb = tree_cb("refresh") },
  { key = "m",    			  cb = tree_cb("cd") },
  { key = "v",                        	  cb = tree_cb("vsplit") },
  { key = "h",                        	  cb = tree_cb("split") },
  { key = "t",                            cb = tree_cb("tabnew") },
  { key = "<",                            cb = tree_cb("prev_sibling") },
  { key = ">",                            cb = tree_cb("next_sibling") },
  { key = "P",                            cb = tree_cb("parent_node") },
  { key = "<BS>",                         cb = tree_cb("close_node") },
  { key = "<S-CR>",                       cb = tree_cb("close_node") },
  { key = "<Tab>",                        cb = tree_cb("preview") },
  { key = "K",                            cb = tree_cb("first_sibling") },
  { key = "J",                            cb = tree_cb("last_sibling") },
  { key = "I",                            cb = tree_cb("toggle_ignored") },
  { key = "H",                            cb = tree_cb("toggle_dotfiles") },
  { key = "R",                            cb = tree_cb("refresh") },
  { key = "a",                            cb = tree_cb("create") },
  { key = "d",                            cb = tree_cb("remove") },
  { key = "r",                            cb = tree_cb("rename") },
  { key = "<C-r>",                        cb = tree_cb("full_rename") },
  { key = "x",                            cb = tree_cb("cut") },
  { key = "c",                            cb = tree_cb("copy") },
  { key = "p",                            cb = tree_cb("paste") },
  { key = "y",                            cb = tree_cb("copy_name") },
  { key = "Y",                            cb = tree_cb("copy_path") },
  { key = "gy",                           cb = tree_cb("copy_absolute_path") },
  { key = "[c",                           cb = tree_cb("prev_git_item") },
  { key = "]c",                           cb = tree_cb("next_git_item") },
  { key = "-",                            cb = tree_cb("dir_up") },
  { key = "q",                            cb = tree_cb("close") },
  { key = "g?",                           cb = tree_cb("toggle_help") },
}

local nvimtreeconf = {
  setup = {
    disable_netrw       = true,
    hijack_netrw        = true,
    open_on_setup       = false,
    ignore_ft_on_setup  = {},
    auto_close          = true,
    open_on_tab         = true,
    hijack_cursor       = false,
    update_cwd          = true,
    update_to_buf_dir   = {
      enable = true,
      auto_open = true,
    },
    diagnostics = {
      enable = true,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      }
    },
    update_focused_file = {
      enable      = true,
      update_cwd  = true,
      ignore_list = {}
    },
    system_open = {
      cmd  = true,
      args = {}
    },
    filters = {
      dotfiles = true,
      custom = {}
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 1000,
    },
    view = {
      width = 35,
      height = 30,
      hide_root_folder = false,
      side = 'left',
      auto_resize = false,
      mappings = {
        custom_only = true,
        list = mapL
      }
    },
  },
  show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
    tree_width = 30,
  },
  ignore = { ".git", "node_modules", ".cache" },
  quit_on_open = 0,
  hide_dotfiles = 1,
  git_hl = 1,
  root_folder_modifier = ":t",
  allow_resize = 1,
  auto_ignore_ft = { "startify", "dashboard" },
  icons = {
    default = "",
    symlink = "",
    git = {
      unstaged = "",
      staged = "S",
      unmerged = "",
      renamed = "➜",
      deleted = "",
      untracked = "U",
      ignored = "◌",
    },
    folder = {
      default = "",
      open = "",
      empty = "",
      empty_open = "",
      symlink = "",
    },
  },
}
vim.g.nvimTreeConfig = nvimtreeconf

nvimtree.setup(vim.g.nvimTreeConfig.setup)
