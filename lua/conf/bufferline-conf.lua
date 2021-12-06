require('bufferline').setup {
  options = {
    numbers = "ordinal",
    buffer_close_icon = '',
    close_icon = '',
    close_command = "Bdelete %d",       -- can be a string | function, see "Mouse actions"
    right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
    middle_mouse_command = "Bdelete! %d",          -- can be a string | function, see "Mouse actions"
    indicator_icon = '┃',
    modified_icon = '●',
    left_trunc_marker = '',
    right_trunc_marker = '',
    name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
      if buf.name:match('%.md') then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    max_name_length = 18,
    max_prefix_length = 20, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, _, _, _)
      -- local icon = level:match("error") and " " or " "
      return " " .. count
    end,
    custom_filter = function(buf_number)
      if vim.bo[buf_number].filetype ~= "ex" then
        return true
      end
      if vim.fn.bufname(buf_number) ~= "Prompt" then
        return true
      end
      if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        return true
      end
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "🛠 Ⲣ𝖗𝖔𝖏𝖊𝖈𝖙 ⚙️",
        text_align = "center",
      }
    },
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = "slant",
    enforce_regular_tabs = true,
    always_show_bufferline = false,
    sort_by = 'id'
  }
}


