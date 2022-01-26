-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
-- local packer = require('packer')
packer.init{
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}

-- Install your plugins here
return packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use 'lewis6991/impatient.nvim'
  use 'neovim/nvim-lspconfig'
  use "nathom/filetype.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"
  use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function ()
      require('plugin.telescope').setup()
    end
  }
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  }

  -- nvim-cmp and its plugins
  use {
    'hrsh7th/nvim-cmp',
    config = function ()
      require('plugin.cmp')
    end,
    requires = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    }
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-nvim-lua"
  use 'onsails/lspkind-nvim'

  -- snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('plugin.autopairs').setup()
    end,
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function ()
      require('plugin.treesitter')
    end
  }
  use {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufReadPost",
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function ()
      require('plugin.gitsigns')
    end,
    event = "BufRead"
  }
  -- Comments
  use {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("plugin.comment").setup()
    end,
  }

  use {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("plugin.lsp_signature").setup()
    end,
    event = "BufRead",
  }
  -- use 'kosayoda/nvim-lightbulb'
  -- use {
  --   'rmagatti/goto-preview',
  --   config = function()
  --     require('goto-preview').setup {}
  --   end
  -- }
  use {
    'ray-x/navigator.lua',
    requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'},
    config = function()
      -- require('plugin.navigator')
    end
  }
  use {
    'mhartington/formatter.nvim',
    config = function ()
      require('plugin.formatter')
    end
  }
  -- use 'joshdick/onedark.vim' -- Theme inspired by Atom
  -- use 'EdenEast/nightfox.nvim'
  use 'LunarVim/onedarker.nvim'
  use 'folke/tokyonight.nvim'
  use 'rebelot/kanagawa.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function ()
      require('plugin.lualine')
    end
  }
  -- Add indentation guides even on blank lines
  use {
    'lukas-reineke/indent-blankline.nvim',
    setup = function ()
      vim.g.indent_blankline_char = "▏"
    end,
    config = function ()
      require('plugin.blackline').setup()
    end,
    event = "BufRead"
  }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      --require("plugin.todo_comments").setup()
    end,
    event = "BufRead",
  }
  use {
    'ethanholz/nvim-lastplace',
    config = function ()
      require('plugin.lastplace')
    end,
    event = "BufWinEnter",
  } -- Reopen file at your last edit position
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function ()
      require('plugin.nvimtree').setup()
    end
  }
  use {
    "akinsho/toggleterm.nvim",
    config = function ()
      require('plugin.terminal').setup()
    end,
    event = "BufWinEnter"
  }
  use {
    "akinsho/bufferline.nvim",
    config = function()
      require("plugin.bufferline").setup()
    end,
    requires = "nvim-web-devicons",
  }
  use "moll/vim-bbye"
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      -- require'alpha'.setup(require'alpha.themes.startify'.opts)
      require("plugin.alpha")
    end
  }
  use {
    "yamatsum/nvim-cursorline",
    opt = true,
    event = "BufWinEnter",
  }
  -- use 'RRethy/vim-illuminate' 
  use 'editorconfig/editorconfig-vim'
  use {
    'vim-scripts/DoxygenToolkit.vim',
    cmd = "Dox",
    setup = function ()
      vim.g.DoxygenToolkit_commentType = "C++"
    end
  }
  use {
    "p00f/nvim-ts-rainbow",
    event = "BufWinEnter",
  }

  -- use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use {
    "sindrets/diffview.nvim",
    opt = true,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    module = "diffview",
    keys = "<leader>gd",
    setup = function()
      -- require("which-key").register { ["<leader>gd"] = "diffview: diff HEAD" }
    end,
    config = function()
      require("config.keymaps").set_keymaps('n', "<leader>gd", "<cmd>DiffviewOpen<cr>")
      require("diffview").setup {
        enhanced_diff_hl = true,
        key_bindings = {
          file_panel = { q = "<Cmd>DiffviewClose<CR>" },
          view = { q = "<Cmd>DiffviewClose<CR>" },
        },
      }
    end,
  }

  use {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit",
      "Gvdiff",
    },
    ft = {"fugitive"}
  }

  use {
      'tanvirtin/vgit.nvim',
      event = 'BufWinEnter',
      requires = {
          'nvim-lua/plenary.nvim',
        },
      config = function()
          require('vgit').setup()
      end,
  }

  use {
    'timakro/vim-yadi'
  }
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("plugin.colorizer").setup()
    end,
    event = "BufRead",
  }
end)
