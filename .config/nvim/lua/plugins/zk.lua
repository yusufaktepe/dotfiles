return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>z", group = "Zk Notes", icon = { icon = "󰠮", color = "yellow" } },
      },
    },
  },

  {
    "zk-org/zk-nvim",
    config = function()
      require("zk").setup({
        picker = "fzf_lua",
      })
    end,
    cmd = {
      "ZkIndex", "ZkNew", "ZkNewFromTitleSelection", "ZkNewFromContentSelection",
      "ZkCd", "ZkNotes", "ZkBacklinks", "ZkLinks", "ZkInsertLink", "ZkMatch", "ZkTags"
    },
    keys = {
      {
        "<leader>zb",
        function()
          require("zk.commands").get("ZkBacklinks")()
        end,
        desc = "Backlink Picker",
      },
      {
        "<leader>zd",
        function()
          require("zk.commands").get("ZkCd")()
        end,
        desc = "Change Directory",
      },
      {
        "<leader>zr",
        function()
          require("zk.commands").get("ZkIndex")()
        end,
        desc = "Refresh Index",
      },
      {
        "<leader>zl",
        function()
          require("zk.commands").get("ZkLinks")()
        end,
        desc = "Link Picker",
      },
      {
        "<leader>zm",
        ":'<,'>ZkMatch<CR>",
        mode = "v",
        desc = "Match current visual selection",
      },
      {
        "<leader>zm",
        function()
          require("zk.commands").get("ZkNotes")({ sort = { "created" }, match = { vim.fn.input("Match: ") } })
        end,
        desc = "Match given query",
      },
      {
        "<leader>zj",
        function()
          require("zk.commands").get("ZkNew")({ dir = "journal" })
        end,
        desc = "New journal entry",
      },
      {
        "<leader>zn",
        function()
          require("zk.commands").get("ZkNew")({ dir = "ideas", title = vim.fn.input("Title: ") })
        end,
        desc = "New Note",
      },
      {
        "<leader>zz",
        function()
          require("zk.commands").get("ZkNotes")({ sort = { "modified" } })
        end,
        desc = "Search",
      },
      {
        "<leader>zt",
        function()
          require("zk.commands").get("ZkTags")()
        end,
        desc = "Tags",
      },
    }
  }
}
