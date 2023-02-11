return {
  -- git wrapper
  {
    "tpope/vim-fugitive",
    lazy = true,
    cmd = { "G", "Git", "GBrowse", "Gdiffsplit", "Ghdiffsplit", "Gvdiffsplit" },
    keys = {
      { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "[G]it [d]iff split" },
      { "<leader>gb", "<cmd>G blame<cr>", desc = "[G]it [b]lame", mode = { "n", "v" } },
    },
  },

  -- better diffing
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = true,
    keys = {
      {
        "<leader>gD",
        function()
          local lib = require("diffview.lib")
          local view = lib.get_current_view()
          if view then
            vim.cmd("DiffviewClose") -- Current tabpage is a Diffview; close it
          else
            vim.cmd("DiffviewOpen") -- No open Diffview exists: open a new one
          end
        end,
        desc = "[G]it [D]iffView",
      },
    },
  },

  -- diff and merge two directories recursively
  -- https://github.com/sindrets/diffview.nvim/issues/286
  {
    "will133/vim-dirdiff",
    cmd = "DirDiff",
    config = function()
      vim.g.DirDiffWindowSize = 10
      vim.g.DirDiffExcludes = ".*.swp,.git"
    end,
  },

  -- git merge conflict resolution
  {
    "christoomey/vim-conflicted",
    cmd = "Conflicted",
  },

  -- create gists
  {
    "mattn/gist-vim",
    dependencies = { "mattn/webapi-vim" },
    cmd = "Gist",
    config = function()
      vim.g.gist_token_file = "~/Repos/.backup/secrets/gist_token"
      vim.g.gist_post_private = 1
    end,
  },
}
