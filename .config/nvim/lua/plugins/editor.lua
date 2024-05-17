local Util = require("lazyvim.util")

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      window = {
        width = 35,
        mappings = {
          ["Z"] = "expand_all_nodes",
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fC", Util.telescope("files", { cwd = "~/.config", prompt_title = 'Find config' }), desc = "Find Config Files" },
      { "<leader>fB", Util.telescope("files", { cwd = "~/.local/bin", prompt_title = 'Find script' }), desc = "Find Bin Files" },
      { "<leader>fN", Util.telescope("files", { cwd = "~/Repos/notes", prompt_title = 'Find notes' }), desc = "Find Notes" },
      { "<leader>fp", Util.telescope("find_files", { cwd = require("lazy.core.config").options.root, }), desc = "Find plugin file", },
      { "<leader>%",  Util.telescope("current_buffer_fuzzy_find", { winblend = 10, previewer = false, }), desc = "[%] Fuzzily search in current buffer'", },
      { "<leader>s/", Util.telescope("live_grep", { grep_open_files = true, prompt_title = 'Live Grep in Open Files', }), desc = "[S]earch [/] in Open Files", },
    },
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        layout_strategy = "flex",
        layout_config = {
          prompt_position = "top",
          horizontal = {
            preview_width = 0.57,
          },
          vertical = {
            preview_height = 0.5,
            mirror = true,
          },
          flex = {
            flip_columns = 120,
          },
        },
        -- preview = {
        --   hide_on_startup = true,
        -- },
        mappings = {
          i = {
            ["<RightMouse>"] = function(...)
              return require("telescope.actions").close(...)
            end,
            ["<LeftMouse>"] = function(...)
              return require("telescope.actions").select_default(...)
            end,
            ["<C-j>"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["<C-k>"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["<ScrollWheelDown>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<ScrollWheelUp>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
            ["<C-space>"] = function(...)
              return require("telescope.actions.layout").toggle_preview(...)
            end,
            ["<Esc>"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
        },
      },
      pickers = {
        buffers = {
          ignore_current_buffer = true,
          sort_lastused = true,
          sort_mru = true,
          theme = "dropdown",
          previewer = false,
          mappings = {
            i = { ["<C-d>"] = function(...) return require("telescope.actions").delete_buffer(...) end },
            n = { ["<C-d>"] = function(...) return require("telescope.actions").delete_buffer(...) end },
          },
        },
        builtin = {
          theme = "dropdown",
          previewer = false,
          include_extensions = true,
          use_default_opts = true,
        },
        git_files = {
          show_untracked = true,
        },
        git_branches = {
          theme = 'dropdown',
          layout_config = {
            width = 0.5,
          },
        },
        grep_string = {
          path_display = { truncate = 3 },
        },
        live_grep = {
          path_display = { truncate = 3 },
        },
      },
    },
    dependencies = {
      {
        "debugloop/telescope-undo.nvim",
        keys = {
          { "<F5>", "<cmd>Telescope undo<cr>", desc = "Search undo history" },
          { "<leader>su", "<cmd>Telescope undo<cr>", desc = "Search undo history" },
        },
        config = function()
          require("telescope").setup({
            extensions = {
              undo = {
                -- use_delta = false,
                use_custom_command = {
                  "sh",
                  "-c",
                  "printf '%s' '$DIFF' | \
                  delta --paging always --syntax-theme Nord --file-style omit --hunk-header-decoration-style omit",
                },
                layout_strategy = "vertical",
                layout_config = {
                  preview_cutoff = 0,
                  preview_height = 0.6,
                },
                -- mappings = {
                --   i = {
                --     ["<cr>"] = require("telescope-undo.actions").yank_additions,
                --     ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                --     ["<C-cr>"] = require("telescope-undo.actions").restore,
                --   },
                -- },
              },
            },
          })
          require("telescope").load_extension("undo")
        end,
      },
    },
  },
}
