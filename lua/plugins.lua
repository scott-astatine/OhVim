
return require('packer').startup(
  function(use)
    -- Packer
    use { 'wbthomason/packer.nvim', opt = true }

    -- Colorscheme
    use {'dracula/vim', as = 'dracula'}
    use 'navarasu/onedark.nvim'
    use 'norcalli/nvim-colorizer.lua'

    -- Completion
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'nvim-lua/completion-nvim'
    -- Kommentary & Autopairs
    use 'b3nj5m1n/kommentary'
    use 'windwp/nvim-autopairs'

    -- Code Runner
    use { 'CRAG666/code_runner.nvim', branch = "new_features" }

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

    -- Nvim Tree
    use 'kyazdani42/nvim-tree.lua'

    -- Nvim lsp & cmp
    use 'onsails/lspkind-nvim'
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

