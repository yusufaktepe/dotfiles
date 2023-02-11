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
    -- "hulufei/peek.nvim", branch = "use-browser",
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
    opts = { theme = "dark" },
  },

  -- colorizer
  {
    "NvChad/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    ft = { "css", "javascript" },
    keys = {
      { "<leader>uh", "<cmd>ColorizerToggle<cr>", desc = "Toggle color [h]ighlight" },
    },
    opts = {
      filetypes = { "*", "!lazy" },
      buftype = { "*", "!prompt", "!nofile" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        virtualtext = "■",
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

  -- system
  {
    "tpope/vim-eunuch",
    cmd = { "Chmod", "Delete", "Edit", "Grep", "Mkdir", "Move", "Rename", "Unlink", "Wall", "Write" },
  },

  -- edit gpg encrypted files
  { "jamessan/vim-gnupg" },
}
