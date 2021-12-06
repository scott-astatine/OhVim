local lualine = require 'lualine'

local bg = function ()
  if vim.g.transparrent then
    return '#e0e11'
  else
    return '#1c1e1c'
  end
end

local colors = {
  bg       = bg(),
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#eb1c5d',
  purple   = '#be3dff'
}

-- Config
local config = {
  options = {
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    theme = 'onedark',
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_v = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}


-- Conditions of showing a comonent
local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand '%:t') ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand '%:p:h'
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
  not_nvtree = function ()
    if vim.fn.bufname() ~= "NvimTree" then
      return true
    else
      return false
    end
  end,
}
-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
  table.insert(config.inactive_sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
  -- table.insert(config.inactive_sections.lualine_x, component)
end

local mode_color = {
  n = colors.green,
  no = colors.red,
  i = colors.red,
  ic = colors.yellow,
  v = colors.blue,
  V = colors.blue,
  c = colors.magenta,
  cv = colors.red,
  s = colors.orange,
  S = colors.orange,
  R = colors.violet,
  Rv = colors.violet,
  Rvc = colors.violet,
  Rvx = colors.violet,
  r = colors.cyan,
  rm = colors.cyan,
  t = colors.red,
  ['r?'] = colors.cyan,
  ['!'] = colors.red,
  [''] = colors.orange,
}

-- Left Side components
ins_left {
  function()
    vim.api.nvim_command('hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. ' guibg=' .. colors.bg)
    return '▊'
  end,
  color = 'LualineMode',
  padding = { left = 0, right = 1 },
}

ins_left {
  function()
    vim.api.nvim_command('hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. ' guibg=' .. colors.bg)
    return ''
  end,
  color = 'LualineMode',
  padding = { right = 1 },
}

ins_left {
  'filesize',
  icons_enabled = true,
  color = {fg = colors.purple},
  cond = function () return conditions.buffer_not_empty() and conditions.not_nvtree() end
}

ins_left {
  'filename',
  show_filename_only = true,
  show_modified_status = true,
  symbols = { modified = " ● ", readonly = "  " },
  cond = function () return conditions.buffer_not_empty() and conditions.not_nvtree() end,
  icons_enabled = true,
  color = { fg = '#ff375a', gui = 'bold' },
}

ins_left {
  'diagnostics',
  sources = { 'nvim_lsp' },
  symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
    color_hint = { fg = colors.purple },
  },
  cond = conditions.buffer_not_empty,
}
ins_left {
  'o:encoding',
  fmt = string.upper,
  cond = function() return conditions.hide_in_width() and conditions.buffer_not_empty() and conditions.not_nvtree() end,
  color = { fg = colors.green, gui = 'bold' },
}

ins_left {
  function()
    return '%='
  end,
}

-- Right section
ins_right {
  'location',
  icons_enabled = true,
  cond = conditions.not_nvtree,
  color = { fg = colors.orange }
}

ins_right {
  'filetype',
  icons_enabled = true,
  color = { fg = colors.green, gui = 'bold' },
  cond = conditions.not_nvtree,
}

ins_right {
  'progress',
  cond = conditions.not_nvtree,
  color = { fg = colors.violet, gui = 'bold' }
}

ins_right {
  'branch',
  icon = '',
  color = { fg = colors.green, gui = 'bold' },
  cond = function() return conditions.not_nvtree() and conditions.check_git_workspace() end
}

ins_right {
  'diff',
  symbols = { added = ' ', modified = '🪄', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.cyan },
    removed = { fg = colors.red },
  },
  cond = function () return conditions.check_git_workspace() and conditions.hide_in_width() and conditions.not_nvtree() end
}

ins_right {
  function()
    vim.api.nvim_command('hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. ' guibg=' .. colors.bg)
    return '▊'
  end,
  color = 'LualineMode',
  cond = function() return conditions.buffer_not_empty() and conditions.not_nvtree() end,
  padding = { left = 1 },
}

lualine.setup(config)
