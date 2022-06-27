local devicons = require("nvim-web-devicons")

devicons.setup({
    default = true,
})
devicons.set_default_icon("📄", "#2e2e2e")

devicons.set_icon({
    nim = {
        icon = "👑",
        color = "#ef9c25",
        name = "Nim",
    },
    nimble = {
        icon = "👑",
        color = "#ef9c25",
        name = "Nimble",
    },
    py = {
        icon = "🐍",
        color = "#50f33c",
        name = "Python"
    }
})
