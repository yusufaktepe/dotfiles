return {
  { "catppuccin", enabled = false },
  { "folke/tokyonight.nvim", enabled = false },

  {
    "rmehri01/onenord.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- borders = false,
      -- fade_nc = true,
      styles = {
        comments = "italic",
      },
      -- inverse = {
      --   match_paren = true,
      -- },
    },
  },

  -- {
  --   'projekt0n/github-nvim-theme',
  --   name = 'github-theme',
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   opts = {
  --     options = {
  --       -- transparent = true,
  --       dim_inactive = true,
  --       styles = {
  --         comments = 'italic',
  --       },
  --     },
  --   },
  -- },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onenord",
    },
  },
}
