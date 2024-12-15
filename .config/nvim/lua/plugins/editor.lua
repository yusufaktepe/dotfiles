return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      window = {
        width = 35,
        mappings = {
          ["Z"] = "expand_all_nodes",
        },
      },
    },
  },

  {
    "folke/which-key.nvim",
    opts = {
      preset = "modern",
    },
  },

  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      window = {
        winblend = 0,
      }
    },
    keys = { -- load the plugin only when using it's keybinding:
      { "<F5>", "<cmd>lua require('undotree').toggle()<cr>", desc = "Search undo history" },
      { "<leader>su", "<cmd>lua require('undotree').toggle()<cr>", desc = "Search undo history" },
    },
  }
}
