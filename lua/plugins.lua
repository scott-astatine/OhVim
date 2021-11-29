
return require('packer').startup(
  function(use)
    -- Packer
    use { 'wbthomason/packer.nvim', opt = true }
    use 'karb94/neoscroll.nvim'

    -- WhichKey
    use 'folke/which-key.nvim'

    -- Colorscheme
    use {'dracula/vim', as = 'dracula'}
    use 'navarasu/onedark.nvim'
    use 'norcalli/nvim-colorizer.lua'

    use 'moll/vim-bbye'

    -- Completion
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'nvim-lua/completion-nvim'
    -- Kommentary & Autopairs
    use 'numToStr/Comment.nvim'
    use 'windwp/nvim-autopairs'

    use 'MunifTanjim/nui.nvim'

    -- TreeSitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'p00f/nvim-ts-rainbow'
    use 'nvim-treesitter/playground'
    use 'andweeb/presence.nvim'

    -- Telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-media-files.nvim'
    use 'rcarriga/nvim-notify'
    use {
      "nvim-telescope/telescope-frecency.nvim",
      config = function()
        require"telescope".load_extension("frecency")
      end,
      requires = {"tami5/sqlite.lua"}
    }

    -- Git
    use 'lewis6991/gitsigns.nvim'
    use 'TimUntersberger/neogit'

    -- StatusLine
    use 'nvim-lualine/lualine.nvim'
    use 'akinsho/bufferline.nvim'

    -- Startup buffer
    use 'goolord/alpha-nvim'

    -- Icons
    use 'kyazdani42/nvim-web-devicons'
    -- use 'yamatsum/nvim-nonicons'
    -- Nvim Tree
    use 'kyazdani42/nvim-tree.lua'

    -- Nvim lsp & cmp
    use 'onsails/lspkind-nvim'
    use 'williamboman/nvim-lsp-installer'
    use 'nanotee/nvim-lua-guide'
    use 'euclidianAce/BetterLua.vim'
    use 'tjdevries/manillua.nvim'
    use {
      'neovim/nvim-lspconfig',
      requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp'
      }
    }


end)

