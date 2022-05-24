---@diagnostic disable: missing-parameter
local use = require("packer-tools.wrapper").new {
  inject_config = { enable = true, prefix = "plugin.config." },
}
return require("packer").startup(function(use_clean)
  local treesitter = "nvim-treesitter/nvim-treesitter"
  local devicons = "kyazdani42/nvim-web-devicons"
  local plenary = "nvim-lua/plenary.nvim"
  local telescope = "nvim-telescope/telescope.nvim"

  use_clean {
    "wbthomason/packer.nvim",
    "~/repo/packer-tools.nvim",
  }

  use_clean("~/repo/OneDark-Pro.nvim")

  use {
    "stevearc/dressing.nvim",
    "akinsho/toggleterm.nvim",
  }

  use_clean {
    { "rafcamlet/nvim-luapad", cmd = { "Luapad", "LuaRun", "Lua" } },
    "matze/vim-move",
    "tpope/vim-surround",
    "tpope/vim-repeat",
  }

  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = { plenary, devicons, "MunifTanjim/nui.nvim" },
  }

  use { treesitter, run = ":TSUpdate" }

  use { "windwp/nvim-autopairs", requires = treesitter }

  use {
    "neovim/nvim-lspconfig",
    config = 'require("lsp")',
    requires = {
      "williamboman/nvim-lsp-installer",
      "hrsh7th/cmp-nvim-lsp",
      "jose-elias-alvarez/null-ls.nvim",
      "folke/lua-dev.nvim",
      "j-hui/fidget.nvim",
      plenary,
    },
  }

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
      },
      {
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
      },
      "onsails/lspkind.nvim",
    },
  }

  use {
    telescope,
    requires = {
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    }
  }
end)
