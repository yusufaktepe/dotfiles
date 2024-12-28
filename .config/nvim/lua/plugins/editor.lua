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
      source_selector = {
        winbar = true,
        show_scrolled_off_parent_node = true,
        content_layout = "center",
      },
      buffers = {
        display_name = "󰈚 Bufs",
        show_unloaded = true,
      },
      event_handlers = {
        {
          event = "file_open_requested",
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end
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
    "folke/trouble.nvim",
    opts = {
      focus = true,
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
