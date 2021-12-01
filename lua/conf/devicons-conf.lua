local devicons = require'nvim-web-devicons'

devicons.setup {
 default = true;
}

devicons.set_icon({
   nim = {
    icon = "🌩 ",
    color = "#ef9c25",
    name = "Nim"
  },
  nimble = {
    icon = "⚡",
    color = "#ef9c25",
    name = "Nimble"
  }
})

