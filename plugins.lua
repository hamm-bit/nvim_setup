local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- default
        "vim",
        "lua",

        -- extra
        "html",
        "css",
        "javascript",
        "typescript",
        "json",

        -- more
        "c",
        "cpp",
        "cmake",
        "make",
        "csv",
        "java",
        "haskell",
        "rust",
        "python",
        "regex",
        -- "vhdl"
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    -- event = "BufWritePre"
    config = function()
      require "custom.configs.conform"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local conf = require "plugins.configs.telescope"
      conf.defaults.mappings.i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<Esc>"] = require("telescope.actions").close,
      }

      return conf
    end,
  },


  -- install with yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },

    -- config starts
    config = function()
      local opts = {
			  mkdp_auto_start = 1,
        mkdp_auto_close = 1,
        mkdp_refresh_slow = 1,
        mkdp_open_to_the_world = 0,
        mkdp_command_for_global = 0,
        mkdp_open_ip = '',
        mkdp_browser = '/Applications/Firefox Developer Edition.app/',
        mkdp_page_title = '「${name}」',
        mkdp_port = '',
        --[[
        mkdp_preview_options = {
          \ 'mkit': {},
          \ 'katex': {},
          \ 'uml': {},
          \ 'maid': {},
          \ 'disable_sync_scroll': 0,
          \ 'sync_scroll_type': 'middle',
          \ 'hide_yaml_meta': 1,
          \ 'sequence_diagrams': {},
          \ 'flowchart_diagrams': {},
          \ 'content_editable': v:false,
          \ 'disable_filename': 0,
          \ 'toc': {}
          \ }
        ]]--
        mkdp_theme = "light",
		  }
      for k, v in pairs(opts) do
			  vim.g[k] = v
		  end
    end,
  },

  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
        require("peek").setup()
        -- refer to `configuration to change defaults`
        vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
        vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },


  -- {
  --   ""
  -- }

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
