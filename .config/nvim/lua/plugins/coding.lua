return {

  {
    "saghen/blink.cmp",
    opts = {
      keymap = { preset = 'super-tab' },
      -- completion = {
      --   trigger = {
      --     show_on_trigger_character = false
      --   },
      -- },
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
