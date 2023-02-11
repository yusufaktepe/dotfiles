return {
  {
    "shaunsingh/nord.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.g.nord_borders = true
      vim.g.nord_italic = false
      vim.g.nord_bold = false

      -- Load the colorscheme
      require("nord").set()
      -- vim.cmd[[colorscheme nord]]
    end,
  },
}
