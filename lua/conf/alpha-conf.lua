local alpha = require("alpha")
local fortune = require("alpha.fortune")
local if_nil = vim.F.if_nil

local function pick_color()
  local colors = {"String", "Identifier", "Keyword", "Number", "Boolean"}
  return colors[math.random(#colors)]
end

local default_header = {
    type = "text",
    val = {
     "  █████╗ ██╗  ██╗██╗██╗   ██╗██╗███╗   ███╗",
     " ██╔══██╗██║  ██║██║██║   ██║██║████╗ ████║",
     " ██║  ██║███████║██║╚██╗ ██╔╝██║██╔████╔██║",
     " ██║  ██║██╔══██║╚═╝ ╚████╔╝ ██║██║╚██╔╝██║",
     " ╚█████╔╝██║  ██║██╗  ╚██╔╝  ██║██║ ╚═╝ ██║",
     "  ╚════╝ ╚═╝  ╚═╝╚═╝   ╚═╝   ╚═╝╚═╝     ╚═╝",
    },
    opts = {
        position = "center",
        hl = pick_color(),
        -- wrap = "overflow";
    },
}

local footer = {
    type = "text",
    val = fortune(),
    opts = {
        position = "center",
        hl = pick_color(),
    },
}

local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

    local opts = {
        position = "center",
        shortcut = sc,
        cursor = 5,
        width = 48,
        align_shortcut = "right",
        hl = pick_color(),
    }
    if keybind then
        keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "normal", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local buttons = {
    type = "group",
    val = {
        button("e  ", "  New file", "<cmd>ene <CR>"),
        button("SPC f f", "  Find file"),
        button("SPC f r", "   Recently opened files"),
        -- button("SPC f m", "  Jump to bookmarks"),
        button("SPC s l", "  Open last session"),
        button("SPC s f", "  Open a saved session"),
        button("SPC f t", "  Find text"),
    },
    opts = {
        spacing = 1,
    },
}

local section = {
    header = default_header,
    buttons = buttons,
    footer = footer,
}

local opts = {
    layout = {
        { type = "padding", val = 3 },
        section.header,
        { type = "padding", val = 4 },
        section.buttons,
        { type = "padding", val = 1 },
        section.footer,
    },
    opts = {
        margin = 5,
    },
}


-- Send config to alpha
alpha.setup(opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
    autocmd FileType alpha set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
]])

