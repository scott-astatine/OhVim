-- Colorscheme config
vim.g.onedark_transparrent_background = true
vim.g.onedark_style = 'deep'
vim.g.onedark_italic_comment = true


require('neoscroll').setup()
require('onedark').setup()
require('conf')
require("todo-comments").setup()

-- Session manager
local Path = require('plenary.path')
require('session_manager').setup({
  sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'),
  path_replacer = '__',
  colon_replacer = '++',
  autoload_mode = "Disabled",
  autosave_last_session = false,
  autosave_ignore_not_normal = true,
})



-- Vim settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.guifont = 'Fira Code:h9'
vim.o.wrap = false
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
vim.g.always_show_bufferline = false
vim.g.clipboard = {
  name = 'CopyQ',
  copy = {
    ['+'] = { 'copyq', 'add', '-' },
    ['*'] = { 'copyq', 'add', '-' }
  },
  paste = {
    ['+'] = { 'copyq', 'paste', '-' },
    ['*'] = { 'copyq', 'paste', '-' }
  }
}
vim.o.incsearch = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.expandtab = true
vim.g.transparrent = false
vim.o.showmode = false
vim.highlight.on_yank { on_visual = true }

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " "
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

if vim.g.transparrent then
  vim.api.nvim_command('highlight Normal guibg=NONE ctermbg=NONE')
  vim.api.nvim_command('highlight NonText guibg=NONE ctermbg=NONE')
  vim.api.nvim_command('highlight EndOfBuffer guibg=NONE ctermbg=NONE')
end

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

-- Bdelete function to close buffer without exiting nvim or closing buffer window
vim.cmd(
[[
    if exists("g:loaded_bbye") || &cp | finish | endif
    let g:loaded_bbye = 1

    function! s:bdelete(action, bang, buffer_name)
            let buffer = s:str2bufnr(a:buffer_name)
            let w:bbye_back = 1

            if buffer < 0
                    return s:error("E516: No buffers were deleted. No match for " . a:buffer_name)
            endif

            if getbufvar(buffer, "&modified") && empty(a:bang)
                    let error = "E89: No write since last change for buffer "
                    return s:error(error . buffer . " (add ! to override)")
            endif

            if getbufvar(buffer, "&modified") && !empty(a:bang)
                    call setbufvar(buffer, "&bufhidden", "hide")
            endif

            for window in reverse(range(1, winnr("$")))
                    if winbufnr(window) != buffer | continue | endif
                    execute window . "wincmd w"

                    try | exe bufnr("#") > 0 && buflisted(bufnr("#")) ? "buffer #" : "bprevious"
                    catch /^Vim([^)]*):E85:/ " E85: There is no listed buffer
                    endtry

                    if bufnr("%") != buffer | continue | endif

                    call s:new(a:bang)
            endfor

            let back = filter(range(1, winnr("$")), "getwinvar(v:val, 'bbye_back')")[0]
            if back | exe back . "wincmd w" | unlet w:bbye_back | endif

            if buflisted(buffer) && buffer != bufnr("%")
                    exe a:action . a:bang . " " . buffer
            endif
    endfunction

    function! s:str2bufnr(buffer)
            if empty(a:buffer)
                    return bufnr("%")
            elseif a:buffer =~# '^\d\+$'
                    return bufnr(str2nr(a:buffer))
            else
                    return bufnr(a:buffer)
            endif
    endfunction

    function! s:new(bang)
            exe "enew" . a:bang

            setl noswapfile
            setl bufhidden=wipe
            setl buftype=
            setl nobuflisted
    endfunction

    function! s:error(msg)
            echohl ErrorMsg
            echomsg a:msg
            echohl NONE
            let v:errmsg = a:msg
    endfunction

    command! -bang -complete=buffer -nargs=? Bdelete
            \ :call s:bdelete("bdelete", <q-bang>, <q-args>)

    command! -bang -complete=buffer -nargs=? Bwipeout
            \ :call s:bdelete("bwipeout", <q-bang>, <q-args>)

]]
)


