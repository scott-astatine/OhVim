
return require('packer').startup(
  function(use)
    -- Packer
    use { 'wbthomason/packer.nvim', opt = true }

    use {'dracula/vim', as = 'dracula'}
    use 'navarasu/onedark.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'nvim-lua/completion-nvim'
    use 'euclidianAce/BetterLua.vim'
    use 'tjdevries/manillua.nvim'
    use 'b3nj5m1n/kommentary'
    use 'p00f/nvim-ts-rainbow'
    use 'nvim-treesitter/playground'

    -- Telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-media-files.nvim'
    use 'rcarriga/nvim-notify'

    use 'onsails/lspkind-nvim'
    use 'norcalli/nvim-colorizer.lua'

    use 'lewis6991/gitsigns.nvim'


    -- StatusLine
    use 'nvim-lualine/lualine.nvim'
    use 'akinsho/bufferline.nvim'

    -- Startup buffer
    use {
      'goolord/alpha-nvim',
      config = function ()
          require'alpha'.setup(require'alpha.themes.startify'.opts)
      end
    }


    -- Vim surround
    use {
      "blackCauldron7/surround.nvim",
      config = function()
        require"surround".setup {mappings_style = "sandwich"}
      end
    }

    -- Nvim Tree
    use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function() require'nvim-tree'.setup {} end
    }
    -- Nvim lsp & autocompletion
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

