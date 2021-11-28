require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "haskell", 'r', 'ada', 'd', 'c#', 'devicetree', 'fusion', 'hcl', 'graphql', 'php',  'surface', 'yang'}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
  playground = {
    enable = true,
    updatetime = 25,
  },
  rainbow = {
    enable = true
  }
}

