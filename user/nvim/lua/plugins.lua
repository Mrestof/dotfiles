--------------------------------------------------------------------------------
-- vi: foldlevel=2: foldmethod=indent
--------------------------------------------------------------------------------

return require('packer').startup {
  function(use)
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
      vim.cmd.colorscheme "catppuccin"
      end,
    }
    use { "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup()
      end
    }
    use {'akinsho/bufferline.nvim',
      tag = "v3.*",
      after = 'catppuccin',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true },
      config = function ()
        require('bufferline').setup {
          options = {
            show_buffer_close_icons = false,
          },
          highlights = require(
            "catppuccin.groups.integrations.bufferline"
          ).get()
        }
      end
    }
    use { 'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true },
      config = function()
        require('lualine').setup {
          options = {
            padding = 1,
            icons_enabled = false,
            theme = 'catppuccin',
            component_separators = '│',
            section_separators = '',
            globalstatus = false,  -- but can be enabled
            refresh = {
              statusline = 100,
              tabline = 1000,
              winbar = 1000,
            }
          },
          sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {'filename'},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'filesize', 'progress'},
            lualine_z = {'location'}
          },
          inactive_sections = {
            lualine_c = {'filename'},
            lualine_x = {'location'},
          },
          tabline = {},  -- TODO: think of replacing the bufferline with this
          winbar = {},   -- <---  or this
          inactive_winbar = {},
          extensions = {'fugitive', 'quickfix'}
        }
      end
    }
    use { 'NvChad/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup {
          user_default_options = {RRGGBBAA = true}
        }
      end
    }

    -- text editing tools
    use { "kylechui/nvim-surround",
      tag = "*", -- Use for stability; omit to use `main` branch for the latest features
      config = function ()
        require('nvim-surround').setup()
      end
    }

    -- code tools
    -- TODO: learn about nvim-treesitter-textobjects and add it
    use { 'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require('nvim-treesitter.configs').setup {
          ensure_installed = {
            "c", "lua", "vim", -- ?"help",  -- default languages (must be enabled)
            "python"  -- personal choice
          },
          auto_install = true,
          ignore_install = {'ada'}, -- don't load for .adb (large adabe files)
          highlight = {enable=true},
          incremental_selection = {enable=true},
        }
      end,
    }
    use { 'nvim-treesitter/nvim-treesitter-context',
      config = function ()
        require('treesitter-context').setup {
          mode='topline'
        }
      end
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
    -- git
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
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          -- Navigation
          map('n', ']h', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true})
          map('n', '[h', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true})
          -- Actions
          map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
          map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
          map('n', '<leader>hS', gs.stage_buffer)
          map('n', '<leader>hu', gs.undo_stage_hunk)
          map('n', '<leader>hR', gs.reset_buffer)
          -- TODO: find how to cycle through the hunks
          map('n', '<leader>hp', gs.preview_hunk)
          map('n', '<leader>hb', function() gs.blame_line{full=true} end)
          map('n', '<leader>tb', gs.toggle_current_line_blame)
          map('n', '<leader>gd', gs.diffthis)
          map('n', '<leader>gD', function() gs.diffthis('~') end)
          map('n', '<leader>td', gs.toggle_deleted)
          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
        }
      end,
    }
    use { 'tpope/vim-fugitive',
      requires = 'tpope/vim-rhubarb'  -- github integrations
    }
    -- almost code
    use 'lervag/vimtex'

    -- file management tools
    use { 'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      requires = {'nvim-lua/plenary.nvim'}
    }

    -- usability tools
    use 'moll/vim-bbye'

  end,
  config = { git = {  -- part of the fix for old git version
    mark_breaking_changes = true,
    cmd = 'git',
    subcommands = {
      update = 'pull --ff-only --progress --rebase=false',
      install = 'clone --depth %i --no-single-branch --progress',
      fetch = 'fetch --depth 999999 --progress',
      checkout = 'checkout %s --',
      update_branch = 'merge --ff-only @{u}',
      current_branch = 'rev-parse --abbrev-ref HEAD',
      diff = 'log --color=never --pretty=format:FMT HEAD@{1}...HEAD',
      diff_fmt = '%%h %%s (%%cr)',
      git_diff_fmt = 'show --no-color --pretty=medium %s',
      get_rev = 'rev-parse --short HEAD',
      get_header = 'log --color=never --pretty=format:FMT HEAD -n 1',
      get_bodies = 'log --color=never --pretty=format:"===COMMIT_START===%h%n%s===BODY_START===%b" HEAD@{1}...HEAD',
      submodules = 'submodule update --init --recursive',
      revert = 'reset --hard HEAD@{1}',
    },
  }}
}
