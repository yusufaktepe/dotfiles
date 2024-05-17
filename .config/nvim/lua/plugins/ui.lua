local Util = require("lazyvim.util")

return {
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader><tab>T", "<cmd>BufferLinePick<cr>", desc = "Tab: Pick" },
      { "<leader><tab>D", "<cmd>BufferLinePickClose<cr>", desc = "Tab: Pick to close" },
      { "<M-1>", function() require("bufferline").go_to(1) end, desc = "Goto tab 1" },
      { "<M-2>", function() require("bufferline").go_to(2) end, desc = "Goto tab 2" },
      { "<M-3>", function() require("bufferline").go_to(3) end, desc = "Goto tab 3" },
      { "<M-4>", function() require("bufferline").go_to(4) end, desc = "Goto tab 4" },
      { "<M-5>", function() require("bufferline").go_to(5) end, desc = "Goto tab 5" },
      { "<M-6>", function() require("bufferline").go_to(6) end, desc = "Goto tab 6" },
      { "<M-7>", function() require("bufferline").go_to(7) end, desc = "Goto tab 7" },
      { "<M-8>", function() require("bufferline").go_to(8) end, desc = "Goto tab 8" },
      { "<M-9>", function() require("bufferline").go_to(9) end, desc = "Goto tab 9" },
      { "<M-0>", function() require("bufferline").go_to(-1) end, desc = "Goto tab last" },
    },
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_duplicate_prefix = false,
        show_tab_indicators = false,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = require("lazyvim.config").icons

      vim.o.laststatus = vim.g.lualine_laststatus
      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
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
            Util.lualine.root_dir(),
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { Util.lualine.pretty_path() },
          },
          lualine_x = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = Util.ui.fg("Statement"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = Util.ui.fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = Util.ui.fg("Debug"),
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = Util.ui.fg("Special"),
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
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
          },
          lualine_y = {
            -- { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = { "%P/%L" },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    cond = not vim.opt.diff:get() and vim.opt.list:get(),
  },
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "LazyFile",
    cond = not vim.opt.diff:get() and vim.opt.list:get(),
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
    opts = function()
      local logo = [[
 ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
 ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
 ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
 ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
 ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = LazyVim.telescope("files"),                                 desc = " Find File",       icon = " ", key = "f" },
            { action = "ene | startinsert",                                        desc = " New File",        icon = " ", key = "n" },
            { action = "Telescope oldfiles",                                       desc = " Recent Files",    icon = " ", key = "r" },
            { action = "Telescope live_grep",                                      desc = " Find Text",       icon = " ", key = "g" },
            { action = [[lua LazyVim.telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
            { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
            { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
            { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
            { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            local version = vim.split(vim.fn.execute('version'), '\n')[3]:sub(7,16)
            return { "⚡ Neovim " .. "[" .. version .. "] loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },

  -- distraction-free coding
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable" },
  },
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
        options = {
          laststatus = 0,
        },
        gitsigns = true,
        tmux = true,
      },
      on_open = function()
        vim.o.list = false
        vim.g.miniindentscope_disable = true
          if Util.has("indent-blankline.nvim") then
            require("ibl").setup_buffer(0, { enabled = false, })
          end
      end,
      on_close = function()
        if vim.opt.list:get() then
          vim.o.list = true
          if Util.has("mini.indentscope") then
            vim.g.miniindentscope_disable = false
            local miniopts = Util.opts("mini.indentscope")
            require("mini.indentscope").setup(miniopts)
          end
          if Util.has("indent-blankline.nvim") then
            require("ibl").setup_buffer(0, { enabled = true, })
          end
        end
      end,
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
}
