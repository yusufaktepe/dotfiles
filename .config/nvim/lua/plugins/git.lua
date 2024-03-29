return {
  -- git wrapper
  {
    "tpope/vim-fugitive",
    lazy = true,
    cmd = { "G", "Git", "GBrowse", "Gdiffsplit", "Ghdiffsplit", "Gvdiffsplit" },
    keys = {
      { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Git diff split" },
      { "<leader>gb", "<cmd>G blame<cr>", desc = "Git blame", mode = { "n", "v" } },
    },
  },

  -- better diffing
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    opts = {},
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
        desc = "Git DiffView",
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
    "Rawnly/gist.nvim",
    dependencies = {
      -- `GistsList` opens the selected gif in a terminal buffer,
      -- nvim-unception uses neovim remote rpc functionality to open the gist in an actual buffer
      -- and prevents neovim buffer inception
      "samjwill/nvim-unception",
      init = function()
        vim.g.unception_block_while_host_edits = true
      end
    },
    cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
  },
}
