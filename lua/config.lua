-- Colorscheme config
vim.g.onedark_transparrent_background = true
vim.g.onedark_style = 'warmer'
vim.g.onedark_italic_comment = true

require('neoscroll').setup()
require'alpha'.setup(require'alpha.themes.dashboard'.opts)
require('onedark').setup()
require('conf')

-- Vim settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.guifont = 'JetBrains Mono:h8'
vim.o.wrap = false
vim.o.cmdheight = 1
vim.o.smarttab = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.showtabline = 2
vim.g.clipboard = 'unamedplus'
vim.o.incsearch = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.expandtab = true
vim.g.transparrent = false
vim.o.showmode = false
vim.highlight.on_yank { on_visual = true }

-- Neovide config
vim.g.neovide_transparency = 0.8
vim.g.neovide_remember_window_size = 1
vim.g.neovide_cursor_vfx_mode = "torpedo"
vim.g.neovide_cursor_vfx_particle_lifetime = 3.2
vim.g.neovide_floating_opacity = 0.6
vim.g.neovide_no_idle = true
vim.g.neovide_opacity = 0.8
vim.g.neovide_cursor_vfx_particle_phase = 1.5
vim.g.neovide_cursor_vfx_particle_density = 7.0
vim.g.neovide_floating_blur = 1

if vim.g.transparrent then
  vim.api.nvim_command('highlight Normal guibg=NONE ctermbg=NONE')
  vim.api.nvim_command('highlight NonText guibg=NONE ctermbg=NONE')
  vim.api.nvim_command('highlight EndOfBuffer guibg=NONE ctermbg=NONE')
end



