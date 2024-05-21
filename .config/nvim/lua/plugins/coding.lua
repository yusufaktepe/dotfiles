return {

  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })

      local cmp = require("cmp")

      -- Disable selecting first item
      opts.preselect = cmp.PreselectMode.None
      opts.completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      }

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
          ["<CR>"] = LazyVim.cmp.confirm({ select = false }),
      })
    end,
  },

  -- auto pairs
  { "echasnovski/mini.pairs", enabled = false },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done()
      )
    end,
    keys = {
      {
        "<leader>up",
        function()
          local Util = require("lazy.core.util")
          local autopairs = require("nvim-autopairs")
          if autopairs.state.disabled then
            autopairs.enable()
            Util.info("Enabled auto pairs", { title = "Option" })
          else
            autopairs.disable()
            Util.warn("Disabled auto pairs", { title = "Option" })
          end
        end,
        desc = "Toggle auto pairs",
      },
    },
  },

  -- Incremental LSP renaming
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    opts = {},
  },

  -- alignment
  { "junegunn/vim-easy-align", cmd = "EasyAlign" },

  -- create previewable commands
  {
    "smjonas/live-command.nvim",
    event = "CmdlineEnter",
    config = function()
      require("live-command").setup {
        commands = {
          Norm = { cmd = "norm" },
          Reg = {
            cmd = "norm",
            -- This will transform ":5Reg a" into ":norm 5@a"
            args = function(opts)
              return (opts.count == -1 and "" or opts.count) .. "@" .. opts.args
            end,
            range = "",
          },
        },
      }
    end,
  },
}
