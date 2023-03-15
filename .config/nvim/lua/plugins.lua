local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
	-- My plugins here
	use 'wbthomason/packer.nvim'
	use {
		'nvim-lualine/lualine.nvim',
		requires = {
			{ 'kyazdani42/nvim-web-devicons' },
		}
	}
	use {
		'romgrk/barbar.nvim',
		requires = {
			{ 'kyazdani42/nvim-web-devicons' },
		}
	}
	use 'ellisonleao/gruvbox.nvim'
	use 'rhysd/vim-clang-format'
	use 'airblade/vim-gitgutter'
	use {
		'nvim-telescope/telescope.nvim',
		requires = {'nvim-lua/plenary.nvim'}
	}
	use 'mattn/emmet-vim'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use { 'folke/tokyonight.nvim' }
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lua'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
		}
	}
	use 'rcarriga/nvim-notify'
	use 'j-hui/fidget.nvim'
	use 'vim-autoformat/vim-autoformat'
	use 'folke/trouble.nvim'

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
