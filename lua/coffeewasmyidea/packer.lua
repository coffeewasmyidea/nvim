local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim", install_path
    })
    vim.cmd [[packadd packer.nvim]]
end

return require("packer").startup(function()
    use("wbthomason/packer.nvim")

    -- LSP
    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      requires = {
        --- Uncomment these if you want to manage LSP servers from neovim
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- LSP Support
        {'neovim/nvim-lspconfig'},
        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'L3MON4D3/LuaSnip'},

        -- Snippets
        {"L3MON4D3/LuaSnip"},
        {"rafamadriz/friendly-snippets"},
      }
    }

    -- Colorscheme
    use("morhetz/gruvbox")

    -- Snips
    use("sirver/UltiSnips")

    -- Git
    use("lewis6991/gitsigns.nvim")
    use("tpope/vim-fugitive")

    -- treesitter
    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    -- use("nvim-treesitter/playground")
    -- use("romgrk/nvim-treesitter-context")

    -- Go
    use("ray-x/go.nvim")

    -- Guihua
    use {"ray-x/guihua.lua", run = "cd lua/fzy && make"}

    -- Rust
    use("simrat39/rust-tools.nvim")

    -- Comments
    use("tpope/vim-commentary")

    -- Serach
    use { "nvim-telescope/telescope.nvim", requires = { {"nvim-lua/plenary.nvim"} } }

    -- Autopairs
    use {"windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end}

    -- Dap
    use("mfussenegger/nvim-dap")
    use("theHamsta/nvim-dap-virtual-text")
    use("mfussenegger/nvim-dap-python")
    use {"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}

    -- Others
    use("nvim-lua/plenary.nvim")
    use("psf/black")
    use("preservim/tagbar")
    use("onsails/lspkind-nvim")
    use("theprimeagen/harpoon")
    use("mbbill/undotree")
    use("folke/zen-mode.nvim")
    use("williamboman/mason.nvim")

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
