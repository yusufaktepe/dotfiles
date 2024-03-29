return {
  { "catppuccin", enabled = false },
  { "folke/tokyonight.nvim", enabled = false },
  -- {
  --   "AlexvZyl/nordic.nvim",
  --   lazy = false,
  --   priority = 1000,
  -- },
  -- {
  --   "shaunsingh/nord.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.g.nord_borders = true
  --     vim.g.nord_italic = false
  --     vim.g.nord_bold = false
  --
  --     -- require("nord").set()
  --   end,
  -- },
  -- {
  --   "EdenEast/nightfox.nvim";
  --   lazy = false,
  --   priority = 1000,
  -- },
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
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onenord",
    },
  },
}
