return {
  -- Formatting (extends NVChad defaults)
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- format on save
    opts = require "configs.conform",
  },

  -- Language Server Protocol (extends NVChad defaults)
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Navigate between tmux panes
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  -- Syntax highlighting (extends NVChad defaults)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      return require "configs.treesitter"
    end,
  },

  -- LSP package manager (extends NVChad defaults)
  {
    "williamboman/mason.nvim",
    opts = function()
      return require "configs.mason"
    end,
  },

  -- Auto-pairs for characters like (), [], {}, '', ""
  -- Default: Automatically pairs characters when typed
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },

  -- Add/change/delete surrounding pairs (quotes, brackets, etc.)
  -- Default mappings:
  --   sa{motion/textobject}{char} - Add surrounding
  --   sd{char} - Delete surrounding
  --   sr{target}{replacement} - Replace surrounding
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.surround").setup(opts)
    end,
  },

  -- Move lines and blocks with Alt+hjkl
  -- Default mappings:
  --  Normal/Insert mode:
  --   Alt+j/k   - Move current line up/down
  --   Alt+h/l   - Move current line left/right
  --  Visual mode:
  --   Alt+j/k   - Move selection up/down
  --   Alt+h/l   - Move selection left/right
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.move").setup(opts)
    end,
  },

  -- Smart commenting that understands JSX/TSX
  -- Default mappings:
  --   gcc - Toggle line comment
  --   gc{motion} - Toggle comment for motion
  --   gc (visual) - Toggle comment for selection
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },

  -- Enhanced text objects for better code manipulation
  -- Default mappings work with operators (d,c,y):
  --   a) or i) - Around/inside parentheses
  --   a] or i] - Around/inside brackets
  --   a} or i} - Around/inside braces
  --   aq or iq - Around/inside quotes
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
  },

  -- HTML/JSX specific
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Multiple cursor editing (like VSCode)
  {
    "mg979/vim-visual-multi",
    lazy = false,
  },

  -- Tailwind CSS tooling
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup {
        color_square_width = 2,
      }
    end,
  },

  -- Optional: Add CSS color preview
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
        css = true,
        css_fn = true,
      },
    },
  },

  -- Go development tools
  -- Default keybindings:
  --   Commands (in normal mode):
  --     ]e, [e   - Next/previous error
  --     ]g, [g   - Next/previous warning
  --
  --   Code actions:
  --     <leader>ga - Add tags to struct
  --     <leader>gr - Remove tags from struct
  --     <leader>gi - Add/Remove interface implementation
  --     <leader>gf - Fill struct with default values
  --
  --   Testing:
  --     <leader>gt - Run test under cursor
  --     <leader>gT - Run all tests in file
  --     <leader>gl - Run last test
  --     <leader>gc - Toggle test coverage
  --
  --   Code generation:
  --     <leader>ge - Generate error handling code
  --     <leader>gm - Generate method stubs
  --     <leader>gs - Generate constructor function
  --
  --   Go commands:
  --     <leader>gn - Go generate
  --     <leader>gj - Go to definition
  --     <leader>gk - Show documentation in floating window
  --     <leader>gd - Go to declaration
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- Go test coverage
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-go",
        },
      }
    end,
  },

  -- Debug Adapter Protocol
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go", -- Go debug adapter
      "rcarriga/nvim-dap-ui", -- UI for debugging
    },
    config = function()
      require("dap-go").setup()
      require("dapui").setup()
    end,
  },
}
