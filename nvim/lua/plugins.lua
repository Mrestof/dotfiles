--------------------------------------------------------------------------------
-- vi: foldlevel=42
--------------------------------------------------------------------------------

return require('packer').startup(function(use)
  -- manage itself
  use 'wbthomason/packer.nvim'

  -- appearance
  use { "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require('catppuccin').setup {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        no_italic = true, -- Force no italic
        show_end_of_buffer = true, -- show the '~'chars after the end of buffers
        color_overrides = {
          mocha = {
            base = "#000000",
          --   mantle = "#000000",  -- needs to stay default for at least some contrast
            crust = "#000000",
          },
        },
      }
    end,
  }
  vim.cmd.colorscheme "catppuccin"
  use { "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end
  }

  -- code tools
  -- TODO: learn about nvim-treesitter-textobjects and add it
  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          "c", "lua", "vim", "help",  -- default languages (must be enabled)
          "python"  -- personal choice
        },
        auto_install = true,
        highlight = {enable=true},
        incremental_selection = {enable=true},
      }
    end,
  }
  use { 'neovim/nvim-lspconfig',
    requires = {
      -- automatically install LSPs to stdpath for neovim
      {'williamboman/mason.nvim', config = function() require('mason').setup() end},
      'williamboman/mason-lspconfig.nvim',
    }
  }
  use { 'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
    },
  }
  use { 'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = { text = '+' },
          change       = { text = '~' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~_' },
          untracked    = { text = '++' },
        }
      }
    end,
  }
end)
