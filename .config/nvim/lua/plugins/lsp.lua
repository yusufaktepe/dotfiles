return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        -- border = "single",
        width = 0.8,
        height = 0.8,
      },
    },
  },

  -- LSP diagnostics in virtual text at the top right of the screen
  -- {
  --   "dgagn/diagflow.nvim",
  --   event = "LspAttach",
  --   opts = {
  --     scope = "line",
  --     -- placement = "inline",
  --     -- inline_padding_left = 4,
  --     -- show_sign = true,
  --     -- show_borders = true,
  --   }
  -- },

  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {}
  },
}
