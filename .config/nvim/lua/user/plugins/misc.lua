return {

  -- personal wiki
  {
    "vimwiki/vimwiki",
    cmd = "VimwikiIndex",
    init = function()
      vim.g.vimwiki_list = {
        {
          path = "~/Repos/notes",
          syntax = "markdown",
          ext = ".md",
        },
      }
    end,
  },

  -- markdown preview
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    keys = {
      {
        "<leader>op",
        function()
          local peek = require("peek")
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = "Peek (Markdown Preview)",
      },
    },
    opts = {
      theme = "dark",
      app = "browser",
    },
  },

  -- colorizer
  {
    "uga-rosa/ccc.nvim",
    cmd = { "CccHighlighterToggle", "CccHighlighterEnable", "CccPick", "CccConvert" },
    ft = { "css", "javascript" },
    keys = {
      { "<leader>uh", "<cmd>CccHighlighterToggle<cr>", desc = "Toggle color [h]ighlight" },
    },
    opts = {
      highlighter = {
        auto_enable = true,
      },
    },
  },

  -- split/join blocks of code
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  -- text aligning
  {
    "godlygeek/tabular",
    cmd = { "AddTabularPattern", "AddTabularPipeline", "Tabularize", "GTabularize" },
  },

  -- system
  {
    "tpope/vim-eunuch",
    cmd = { "Chmod", "Delete", "Edit", "Grep", "Mkdir", "Move", "Rename", "Unlink", "Wall", "Write" },
  },

  -- edit gpg encrypted files
  { "jamessan/vim-gnupg" },

  -- vifm
  {
    "vifm/vifm.vim",
    ft = "vifm",
    cmd = { "EditVifm", "Vifm", "PeditVifm", "SplitVifm", "VsplitVifm", "DiffVifm", "TabVifm", "VifmCs" },
    config = function()
      vim.g.vifm_exec = "VIFM=~/.config/vifm/sessions/select vifm"
    end
  },
}
