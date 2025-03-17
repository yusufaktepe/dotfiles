return {

  {
    "saghen/blink.cmp",
    opts = {
    --   keymap = { preset = 'super-tab' },
      completion = {
        list = {
          selection = {
            preselect = false,
          },
        },
      },
      --   trigger = {
      --     show_on_trigger_character = false
      --   },
      -- },
    },
  },

  {
    "echasnovski/mini.pairs",
    enabled = false,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      disable_filetype = { "snacks_picker_input" },
    },
  },

  -- alignment
  {
    "echasnovski/mini.align",
    opts = {},
    keys = {
      { "ga", mode = { "n", "v" }, desc = "Align" },
      { "gA", mode = { "n", "v" }, desc = "Align with preview" },
    },
  },

  -- create previewable commands
  {
    "smjonas/live-command.nvim",
    event = "CmdlineEnter",
    config = function()
      require("live-command").setup {
        commands = {
          Norm = { cmd = "norm" },
        },
    }
    end,
  },
}
