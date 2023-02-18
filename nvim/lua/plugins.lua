-- Automatically install packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use({ "wbthomason/packer.nvim" })
	use({ "nvim-lua/popup.nvim" }) -- Common utilities
	use({ "nvim-lua/plenary.nvim" }) -- Common utilities

	-- Colorschemes
	use({ "EdenEast/nightfox.nvim" }) -- Color scheme

  -- UIs
	use({ "nvim-lualine/lualine.nvim" ,
    config = function() require('lualine').setup() end
  }) -- Statusline
	use({ "akinsho/bufferline.nvim" })
	use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
	use({ "kyazdani42/nvim-web-devicons" }) -- File icons

  -- File explorer
  use ({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  })

  -- Editor support
  use ({
    'andymass/vim-matchup',
    setup = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  })
	use({ "AndrewRadev/linediff.vim" }) -- Show diff of 2 parts with :Linediff

  -- git
  use({ 'TimUntersberger/neogit',
    config = function() require('neogit').setup() end
  })
  use({ 'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup() end
  })
  use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' })
  use({ 'pwntester/octo.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'kyazdani42/nvim-web-devicons',
  },
  config = function ()
    require"octo".setup()
  end
  }) -- for github Editor

  -- Markdown editting
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use({ "dhruvasagar/vim-table-mode" })

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
	use({ "hrsh7th/cmp-vsnip" }) -- snippet completion
	use({ "hrsh7th/vim-vsnip" }) -- snippet completion
	use({ "hrsh7th/vim-vsnip-integ" }) -- snippet completion
	use({ "hrsh7th/cmp-cmdline" }) -- cmdline completions
	use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "onsails/lspkind-nvim" })

	-- snippets
	use({ "L3MON4D3/LuaSnip" }) --snippet engine

	-- LSP
	use({ "neovim/nvim-lspconfig" }) -- enable LSP
	use({ "williamboman/mason.nvim" }) -- simple to use language server installer
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "glepnir/lspsaga.nvim" }) -- LSP UIs
	use({ "j-hui/fidget.nvim" , config = function() require('fidget').setup() end}) -- Show the status of LSP
	use({ "simrat39/rust-tools.nvim" }) -- Rust tools

	-- Testing
  use({ "klen/nvim-test",
    config = function()
      require('nvim-test').setup({
        runners = {
          go = "nvim-test.runners.go-test"
        }
      })
    end
  })

	-- Debugging
  use({ "mfussenegger/nvim-dap"})
  use({ "rcarriga/nvim-dap-ui",
    requires = {"mfussenegger/nvim-dap"},
    config = function()
      local dapui = require('dapui')
      dapui.setup()
      local dap = require('dap')
      dap.listeners.before['event_initialized']['custom'] = function(session, body)
        dapui.open()
      end
      dap.listeners.before['event_terminated']['custom'] = function(session, body)
        dapui.close()
      end
    end
  })
  use({ "leoluz/nvim-dap-go",
    requires = {"mfussenegger/nvim-dap"},
    config = function() require('dap-go').setup() end
  })
  use({ "theHamsta/nvim-dap-virtual-text",
    config = function() require('nvim-dap-virtual-text').setup() end
  })

	-- Formatter
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
	use({ "MunifTanjim/prettier.nvim" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim" })

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "nvim-telescope/telescope-file-browser.nvim" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
