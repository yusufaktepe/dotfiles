return {

  {
    "ibhagwan/fzf-lua",
    opts = function(_, opts)
      local config = require("fzf-lua.config")
      local actions = require("fzf-lua.actions")
      config.defaults.actions.files["alt-enter"] = actions.file_tabedit

      local hls = {
        bg    = "PmenuSbar",
        sel   = "PmenuSel",
        title = "IncSearch"
      }

      return vim.tbl_deep_extend("force", opts, {
        "borderless-full",
        defaults = {
          prompt = " ",
        },
        winopts = {
          backdrop = 100,
        },
        fzf_colors = {
          ["gutter"] = { "bg", hls.bg },
          ["bg"]     = { "bg", hls.bg },
          ["bg+"]    = { "bg", hls.sel },
          ["fg+"]    = { "fg", hls.sel },
        },
      })
    end,
  },

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
      -- preset = "helix",
      -- icons = { separator = "│", },
      preset = "classic",
      win = {
        border = { "─", "─", "─", " ", " ", " ", " ", " " },
        title_pos = "left",
      },
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
