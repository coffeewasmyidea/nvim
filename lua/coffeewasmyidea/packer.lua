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

    -- lsp
    use("williamboman/nvim-lsp-installer")
    use("neovim/nvim-lspconfig")
    use("nvim-lua/plenary.nvim")

    -- snips
	use("sirver/UltiSnips")

    -- git
    use("airblade/vim-gitgutter")
    use("sindrets/diffview.nvim")
    use("tpope/vim-fugitive")

    -- rust
    use("rust-lang/rust.vim")

    -- comments
    use("tpope/vim-commentary")

    -- serach
    use("junegunn/fzf.vim")

    -- treesitter
    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })
    use("nvim-treesitter/playground")
    use("romgrk/nvim-treesitter-context")

    -- colorschemes
    use('Mofiqul/vscode.nvim')
    use("ellisonleao/gruvbox.nvim")

    -- bufferline
    use {"akinsho/bufferline.nvim", tag = "v3.*", requires = "kyazdani42/nvim-web-devicons"}

    -- autopairs
    use {
    "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    -- others
    use("preservim/tagbar")
    use("onsails/lspkind-nvim")
	
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
