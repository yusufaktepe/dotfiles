return {

  -- { "LazyVim/LazyVim", version = false },

  -- indentation detection
  { "Darazaki/indent-o-matic" },
  -- { "tpope/vim-sleuth" },

  -- auto indent with <TAB> when cursor at the first column
  { "vidocqh/auto-indent.nvim" },

  -- personal wiki
  -- {
  --   "vimwiki/vimwiki",
  --   cmd = "VimwikiIndex",
  --   init = function()
  --     vim.g.vimwiki_list = {
  --       {
  --         path = "~/Repos/notes",
  --         syntax = "markdown",
  --         ext = ".md",
  --       },
  --     }
  --   end,
  -- },

  -- {
  --   "serenevoid/kiwi.nvim",
  --   cmd = "KiwiIndex",
  --   opts = {
  --     { name = "personal", path = vim.env.HOME .. "/Repos/notes" },
  --   },
  --   keys = {
  --     { "<leader>N", "<cmd>lua require(\"kiwi\").open_wiki_index()<cr>", desc = "Open Wiki index" },
  --     { "<F13>", ":lua require(\"kiwi\").todo.toggle()<cr>", silent = true, desc = "Toggle Markdown Task" }
  --   },
  -- },

  -- markdown preview
  -- {
  --   "toppair/peek.nvim",
  --   build = "deno task --quiet build:fast",
  --   keys = {
  --     {
  --       "<leader>op",
  --       function()
  --         local peek = require("peek")
  --         if peek.is_open() then
  --           peek.close()
  --         else
  --           peek.open()
  --         end
  --       end,
  --       desc = "Peek (Markdown Preview)",
  --     },
  --   },
  --   opts = {
  --     theme = "dark",
  --     -- app = "browser",
  --     app = "vivaldi-app",
  --   },
  -- },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- enabled = false
    opts = {
      code = {
        width = "block",
        language_pad = 1,
        left_pad = 1,
        right_pad = 1,
        highlight = 'CursorLine',
        highlight_inline = 'CursorLine'
      },
      heading = {
        width = "block",
        left_pad = 1,
        right_pad = 1,
        sign = false,
        icons = {},
        -- backgrounds = {
        --   'RenderMarkdownH2Bg',
        -- },
        -- foreground = {
        --   'RenderMarkdownH2',
        -- },
      },
      checkbox = {
        enabled = true,
      },
    },
  },

  -- colorizer
  {
    "uga-rosa/ccc.nvim",
    cmd = { "CccHighlighterToggle", "CccHighlighterEnable", "CccPick", "CccConvert" },
    ft = { "css", "javascript" },
    keys = {
      { "<leader>uH", "<cmd>CccHighlighterToggle<cr>", desc = "Toggle color highlight" },
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
    "chrisgrieser/nvim-genghis",
    cmd = "Genghis",
    opts = {},
  },

  {
    "lambdalisue/vim-suda",
    event = { { event = "BufEnter", pattern = { "/etc/*", "/usr/*" } } },
    init = function()
      if not vim.opt.diff:get() then
        vim.g.suda_smart_edit = 1
      end
    end,
    cmd = { "SudaRead", "SudaWrite"}
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

  {
    "hat0uma/csvview.nvim",
    opts = {
      view = {
        display_mode = "border",
      },
    },
    cmd = { "CsvViewToggle", "CsvViewEnable", "CsvViewDisable" },
  },

  { "nvzone/showkeys", cmd = "ShowkeysToggle" },
}
