local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	Packer_bootstrap =
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

-- Compile automatically after saving plugins.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function(use)
	use({ "lewis6991/impatient.nvim" })

	use({ "wbthomason/packer.nvim" })

	-- core
	use({
		"nvim-treesitter/nvim-treesitter",
		event = "BufEnter",
		run = ":TSUpdate",
		config = [[require('config.nvim-treesitter')]],
	})
	use({
		"windwp/nvim-ts-autotag",
		event = "BufEnter",
		requires = { "nvim-treesitter/nvim-treesitter" },
	})
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = [[require('config.telescope')]],
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("nvim-telescope/telescope-ui-select.nvim")

	-- navigation
	use({ "ggandor/lightspeed.nvim", event = "BufEnter" })

	-- edit
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "BufEnter",
		config = [[require('config.nvim-surround')]],
	})
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use({ "windwp/nvim-autopairs", event = "BufEnter", config = [[require('config.nvim-autopairs')]] })
	use({ "sbdchd/neoformat", cmd = "Neoformat" })
	use({ "editorconfig/editorconfig-vim", event = "BufEnter" })

	-- completion
	use({ "hrsh7th/nvim-cmp", after = "nvim-autopairs", config = [[require('config.nvim-cmp')]] })
	use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-vsnip", after = "nvim-cmp" })
	use({ "hrsh7th/vim-vsnip", after = "nvim-cmp" })

	-- lsp
	use({ "neovim/nvim-lspconfig", after = "cmp-nvim-lsp", config = [[require('config.lsp')]] })
	use({ "mfussenegger/nvim-jdtls", after = "nvim-lspconfig" })
	use({ "mfussenegger/nvim-dap", after = "nvim-lspconfig" })
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		after = "nvim-lspconfig",
		config = [[require('config.lspsaga')]],
	})

	-- ui
	use("ishan9299/nvim-solarized-lua")
	use({ "nvim-lualine/lualine.nvim", event = "VimEnter", config = [[require('config.lualine')]] })
	use({ "kyazdani42/nvim-web-devicons" })

  -- file explorer
  use({
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = [[require('config.neo-tree')]]
  })

	-- git
	use("tpope/vim-fugitive")

	-- tmux
	use("edkolev/tmuxline.vim")

	-- wiki
	use({ "vimwiki/vimwiki", branch = "dev", event = "VimEnter" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if Packer_bootstrap then
		require("packer").sync()
	end
end)
