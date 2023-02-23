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

      -- Leap highlighting
      vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- Grey out the search area
      vim.api.nvim_set_hl(0, "LeapLabelPrimary", { bold = true, fg = "#EBCB8B" })
      vim.api.nvim_set_hl(0, "LeapLabelSecondary", { bold = true, fg = "#B48EAD" })
      vim.api.nvim_set_hl(0, "LeapMatch", { bold = true, bg = "#EBCB8B", fg = "#8b96ac" })
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
