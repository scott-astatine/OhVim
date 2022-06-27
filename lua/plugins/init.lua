vim.cmd [[packadd packer.nvim]]

require("packer").init({
    log = { level = "warn" },
    git = { clone_timeout = 1000 },
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})


return require("packer").startup(function(use)
    --- Start OhVim required plugins
    --
    -- Packer
    use({ "wbthomason/packer.nvim", opt = true })
    use("karb94/neoscroll.nvim")


    -- WhichKey
    use("folke/which-key.nvim")



    -- Colorscheme
    use({ "dracula/vim", as = "dracula" })
    use("folke/tokyonight.nvim")
    use("https://gitlab.com/__tpb/monokai-pro.nvim")
    use({ "navarasu/onedark.nvim",
        config = function()
        end
    })

    use({ "NvChad/base46",
        config = function()
            local ok, base46 = pcall(require, "base46")
            if ok then
                base46.load_theme()
            end
        end,
    })

    use("norcalli/nvim-colorizer.lua")

    -- Kommentary & Autopairs
    use("numToStr/Comment.nvim")
    use("windwp/nvim-autopairs")

    use("MunifTanjim/nui.nvim")

    use({ "edluffy/hologram.nvim" })



    -- Project manager
    use("ahmedkhalf/project.nvim")
    use({ "scott-astatine/Executer.nvim", as = "Executer" })
    -- Start screen
    use("goolord/alpha-nvim")
    use("BlakeJC94/alpha-nvim-fortune")

    -- treesitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("p00f/nvim-ts-rainbow")
    use("nvim-treesitter/playground")
    use("andweeb/presence.nvim")
    use("lukas-reineke/indent-blankline.nvim")



    -- Todo comment
    use({ "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" })
    use({ "VonHeikemen/searchbox.nvim", requires = { { "MunifTanjim/nui.nvim" } } })



    -- Telescope
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-media-files.nvim")
    use("rcarriga/nvim-notify")


    use({
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require("telescope").load_extension("frecency")
        end,
        requires = { "tami5/sqlite.lua" },
    })

    -- Git
    use("lewis6991/gitsigns.nvim")


    use("TimUntersberger/neogit")

    -- StatusLine
    use({ "nvim-lualine/lualine.nvim",
        config = function()
            require("ui.statusline")
        end
    })
    use("akinsho/bufferline.nvim")

    -- Session Manager
    use({ "Shatur/neovim-session-manager",
        config = function()
        end
    })

    -- Icons
    use("kyazdani42/nvim-web-devicons")
    -- Nvim Tree
    use("kyazdani42/nvim-tree.lua")

    -- Nvim lsp
    use("onsails/lspkind-nvim")
    use("williamboman/nvim-lsp-installer")
    use("nanotee/nvim-lua-guide")
    use("euclidianAce/BetterLua.vim")
    use("tjdevries/manillua.nvim")
    use("neovim/nvim-lspconfig")
    use("ckipp01/stylua-nvim")

    -- Completion
    use("L3MON4D3/LuaSnip")
    use("nvim-lua/completion-nvim")
    use({
        "hrsh7th/cmp-nvim-lsp",
        requires = {
            "hrsh7th/cmp-buffer",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
        },
    })
    --- End OhVim required plugins

    use("alaviss/nim.nvim")
    use({ "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim" })
end)
