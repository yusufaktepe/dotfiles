return {
  {
    "shaunsingh/nord.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.g.nord_borders = true
      vim.g.nord_italic = false
      vim.g.nord_bold = false

      require("nord").set()
    end,
  },
  -- {
  --   "projekt0n/github-nvim-theme",
  --   lazy = false, -- make sure we load this during startup
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   version = "*",
  --   opts = {
  --     theme_style = "dimmed",
  --     overrides = function()
  --       return {
  --         BufferLineBackground = {},
  --       }
  --     end,
  --   },
  --   config = function(_, opts)
  --     require('github-theme').setup(opts)
  --   end
  -- },
}
