local sepS = {
    default = {
        left = "",
        right = "",
    },

    round = {
        left = "",
        right = "",
    },

    block = {
        left = "█",
        right = "█",
    },

    arrow = {
        left = "",
        right = "",
    },
}

local colors = {
    violet = "#a9a1e1",
    magenta = "#c678dd",
    yellow = "#e5c07b",
    black = "#202020",
    neon = "#DFFF00",
    white = "#FFFFFF",
    white2 = "#cFcFcF",
    green = "#70fa30",
    purple = "#5F005F",
    blue = "#00DFFF",
    darkblue = "#00003F",
    navyblue = "#131330",
    brightgreen = "#4CF963",
    gray = "#29242a",
    grey = "#29242a",
    darkgray = "#2c2826",
    lightgray = "#504945",
    inactivegray = "#3c3f34",
    orange = "#FFAF00",
    red = "#f02c35",
    brightorange = "#C08A20",
    light_green = "#83a598",
    brightred = "#fa2631",
    cyan = "#00dcc0",
}


local empty = require("lualine.component"):extend()
function empty:draw(default_highlight)
    self.status = ""
    self.applied_separator = ""
    self:apply_highlights(default_highlight)
    self:apply_section_separators()
    return self.status
end

-- Put proper separators and gaps between components in sections
local function process_sections(sections)
    for name, section in pairs(sections) do
        local left = name:sub(9, 10) < "x"
        for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
            table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.white2 } })
        end
        for id, comp in ipairs(section) do
            if type(comp) ~= "table" then
                comp = { comp }
                section[id] = comp
            end
            comp.separator = left and { right = sepS.default.right } or { left = sepS.default.left }
        end
    end
    return sections
end

local function search_result()
    if vim.v.hlsearch == 0 then
        return ""
    end
    local last_search = vim.fn.getreg("/")
    if not last_search or last_search == "" then
        return ""
    end
    local searchcount = vim.fn.searchcount { maxcount = 9999 }
    return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
end

local function ignoreBufs()
    local buff = vim.bo[vim.fn.bufnr()]
    if buff.filetype:match("NvimTree") then
        return false
    elseif buff.filetype:match("Telescope") then
        return false
    elseif buff.filetype:match("Term") then
        return false
    elseif buff.filetype:match("No Name") then
        return false
    else return true
    end
end

require("lualine").setup {
    options = {
        theme = "onedark",
        component_separators = "",
        section_separators = { left = sepS.default.left, right = sepS.default.right },
    },
    sections = process_sections {
        --- Mode
        lualine_a = {
            {
                "mode",
                section_separators = { left = sepS.round.left }
            }
        },
        --- Lsp diagnostics and filename
        lualine_b = {

            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = { error = " ", warn = " ", info = " ", hint = "💡" },
                diagnostics_color = {
                    color_error = { fg = colors.red },
                    color_warn = { fg = colors.yellow },
                    color_info = { fg = colors.cyan },
                    color_hint = { fg = colors.purple },
                },
            },

            {
                "filename",
                show_filename_only = true,
                show_modified_status = true,
                symbols = { modified = " ● ", readonly = "  " },
                icon = "",
                icons_enabled = true,
                color = { fg = colors.cyan, gui = "bold" },
                cond = ignoreBufs
            },

            {
                "%w",
                cond = function()
                    return vim.wo.previewwindow
                end,
            },

            {
                "%r",
                cond = function()
                    return vim.bo.readonly
                end,
            },

            {
                "%q",
                cond = function()
                    return vim.bo.buftype == "quickfix"
                end,
            },
        },

        lualine_c = {
            {
                function()
                    local Lsp = vim.lsp.util.get_progress_messages()[1]

                    local msg = Lsp.message or ""
                    local percentage = Lsp.percentage or 0
                    local title = Lsp.title or ""
                    local spinners = { "", "" }
                    local ms = vim.loop.hrtime() / 1000000
                    local frame = math.floor(ms / 120) % #spinners
                    local content = string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)

                    return (content) or ""
                end,
            },
        },
        lualine_x = {
            {
                function()
                    for _, client in ipairs(vim.lsp.get_active_clients()) do
                        if client.attached_buffers[vim.api.nvim_get_current_buf()] then
                            return " LSP ~ " .. client.name
                        end
                    end
                end,
                cond = function()
                    return vim.o.columns > 70
                end
            },
            {
                "%l:%c",
                color = { fg = colors.magenta }
            },
            {
                "%p%%/%L",
                color = { fg = colors.brightorange },
                icon = ""
            },

        },
        lualine_y = {
            search_result,

            {
                "filetype",
                icons_enabled = true,
                padding = 1,
                cond = ignoreBufs,
                color = { fg = colors.magenta },
            },

            -- {
            --     "diff",
            --     symbols = { added = " ", modified = "🪄", removed = "⛔" },
            --     diff_color = {
            --         added = { fg = colors.green },
            --         modified = { fg = colors.magenta },
            --         removed = { fg = colors.red },
            --     },
            --     padding = 1,
            --     cond = ignoreBufs,
            -- },
            {
                "filesize",
                icons_enabled = true,
                cond = ignoreBufs,
                color = { fg = colors.orange },
            },
            {
                "branch",
                color = { fg = colors.neon, gui = "bold" },
            },

        },
        lualine_z = {
            {
                function()
                    return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
                end
            }
        },
    },
    inactive_sections = {
        lualine_c = { "%f %y %m" },
        lualine_x = {},
    },
}
