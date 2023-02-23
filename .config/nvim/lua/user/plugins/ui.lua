return {

  -- better vim.ui
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader><tab><tab>", "<cmd>BufferLinePick<cr>", desc = "Tab: Pick" },
      { "<leader><tab>d", "<cmd>BufferLinePickClose<cr>", desc = "Tab: Pick to close" },
      { "<M-1>", function() require("bufferline").go_to_buffer(1) end, desc = "Goto tab 1" },
      { "<M-2>", function() require("bufferline").go_to_buffer(2) end, desc = "Goto tab 2" },
      { "<M-3>", function() require("bufferline").go_to_buffer(3) end, desc = "Goto tab 3" },
      { "<M-4>", function() require("bufferline").go_to_buffer(4) end, desc = "Goto tab 4" },
      { "<M-5>", function() require("bufferline").go_to_buffer(5) end, desc = "Goto tab 5" },
      { "<M-6>", function() require("bufferline").go_to_buffer(6) end, desc = "Goto tab 6" },
      { "<M-7>", function() require("bufferline").go_to_buffer(7) end, desc = "Goto tab 7" },
      { "<M-8>", function() require("bufferline").go_to_buffer(8) end, desc = "Goto tab 8" },
      { "<M-9>", function() require("bufferline").go_to_buffer(9) end, desc = "Goto tab 9" },
      { "<M-0>", function() require("bufferline").go_to_buffer(-1) end, desc = "Goto tab last" },
    },
    opts = {
      options = {
        mode = "tabs",
        numbers = function(opts)
          return string.format("%s", opts.raise(opts.ordinal))
        end,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local icons = require("user.icons").diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_duplicate_prefix = false,
        show_tab_indicators = false,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(plugin)
      local icons = require("user.icons")

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
          component_separators = "",
          section_separators = "",
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                return "[" .. str:sub(1, 1) .. "]"
              end,
              color = { gui = "bold" },
            },
          },
          lualine_b = { "branch" },
          lualine_c = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 0 },
            -- stylua: ignore
            -- {
            --   function() return require("nvim-navic").get_location() end,
            --   cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            -- },
          },
          lualine_x = {
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              separator = ""
            },
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
              separator = ""
            },
            -- {
            --   function()
            --     local space = vim.fn.search([[\s\+$]], "nwc")
            --     return space ~= 0 and "TW:" .. space or ""
            --   end,
            --   color = { fg = "#B48EAD" },
            -- },
          },
          lualine_y = { "location" },
          lualine_z = { "%P/%L" },
        },
        extensions = { "neo-tree", "toggleterm" },
      }
    end,
  },

  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cond = not vim.opt.diff:get(),
    opts = {
      -- char = "▏",
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      disable_with_nolist = true,
      -- use_treesitter = true,
      -- show_current_context = true,
      show_trailing_blankline_indent = false,
      -- show_first_indent_level = false,
      -- strict_tabs = true,
    },
  },

  -- active indent guide and indent text objects
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { "BufReadPre", "BufNewFile" },
    cond = not vim.opt.diff:get() and vim.opt.list:get(),
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    config = function(_, opts)
      require("mini.indentscope").setup(opts)
    end,
  },

  -- dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
      NN   NN EEEEEEE  OOOOO  VV     VV IIIII MM    MM   
      NNN  NN EE      OO   OO VV     VV  III  MMM  MMM   
      NN N NN EEEEE   OO   OO  VV   VV   III  MM MM MM   
      NN  NNN EE      OO   OO   VV VV    III  MM    MM   
      NN   NN EEEEEEE  OOOO0     VVV    IIIII MM    MM   
      ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("s", "󰑓 " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },

  -- lsp symbol navigation for lualine
  -- {
  --   "SmiteshP/nvim-navic",
  --   lazy = true,
  --   init = function()
  --     vim.g.navic_silence = true
  --     require("user.util").on_attach(function(client, buffer)
  --       if client.server_capabilities.documentSymbolProvider then
  --         require("nvim-navic").attach(client, buffer)
  --       end
  --     end)
  --   end,
  --   opts = function()
  --     return {
  --       separator = " › ",
  --       highlight = false,
  --       depth_limit = 4,
  --       icons = require("user.icons").kinds,
  --     }
  --   end,
  -- },

  -- distraction-free coding
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          list = false,
        },
      },
      plugins = {
        gitsigns = true,
        tmux = true,
      },
      on_open = function()
          vim.o.list = false
          vim.g.miniindentscope_disable = true
      end,
      on_close = function()
        if vim.opt.list:get() then
          vim.o.list = true
          local Util = require("user.util")
          if Util.has("mini.indentscope") then
            vim.g.miniindentscope_disable = false
            local miniopts = Util.opts("mini.indentscope")
            require("mini.indentscope").setup(miniopts)
          end
        end
      end,
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },
}
