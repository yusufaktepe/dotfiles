local Util = require("user.util")

return {

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "Neotree",
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = Util.get_root() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      close_if_last_window = true,
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
      },
      window = {
        width = 35,
        mappings = {
          ["<space>"] = "none",
          ["Z"] = "expand_all_nodes",
        },
      },
    },
  },

  -- terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    keys = {
      { '<M-">', "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
      { '<M-">', "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal", mode = "t" },
    },
    config = function()
      require("toggleterm").setup()
    end,
  },

  -- search/replace in multiple files
  {
    "windwp/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {
      { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>/", Util.telescope("live_grep"), desc = "Find in Files (Grep)" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "[Find] [b]uffers" },
      { "<leader>ff", Util.telescope("files"), desc = "[F]ind [f]iles (root dir)" },
      { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "[F]ind [F]iles (cwd)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "[F]ind [r]ecent files" },
      {
        "<leader>fp",
        Util.telescope("find_files", {
          cwd = require("lazy.core.config").options.root,
        }),
        desc = "[F]ind [p]lugin file",
      },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "[G]it [c]ommits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "[G]it [s]tatus" },
      -- search
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "[S]earch [a]utocommands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "[S]earch [b]uffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "[S]earch [c]ommand history" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "[S]earch [C]ommands" },
      { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "[S]earch [d]iagnostics" },
      { "<leader>sg", Util.telescope("live_grep"), desc = "[S]earch by [g]rep (root dir)" },
      { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "[S]earch by [G]rep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[S]earch [h]elp pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "[S]earch [H]ighlight groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "[S]earch [k]ey maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "[S]earch [M]an pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "[S]earch [m]arks" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "[S]earch [o]ptions" },
      { "<leader>sw", Util.telescope("grep_string"), desc = "[S]earch current [w]ord (root dir)" },
      { "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "[S]earch current [W]ord (cwd)" },
      { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "[S]earch [C]olorscheme with preview" },
      {
        "<leader>ss",
        Util.telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "[S]earch [s]ymbol",
      },
    },
    opts = {
      defaults = {
        -- layout_strategy = "horizontal",
        -- layout_config = { prompt_position = "top" },
        -- sorting_strategy = "ascending",
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = {
            ["<RightMouse>"] = function(...)
              return require("telescope.actions").close(...)
            end,
            ["<LeftMouse>"] = function(...)
              return require("telescope.actions").select_default(...)
            end,
            ["<ScrollWheelDown>"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["<ScrollWheelUp>"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["<C-h>"] = "which_key",
            ["<c-t>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
            ["<a-i>"] = function()
              Util.telescope("find_files", { no_ignore = true })()
            end,
            ["<a-h>"] = function()
              Util.telescope("find_files", { hidden = true })()
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
            ["<C-f>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-b>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
            ["<F5>"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
        },
      },
    },
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "debugloop/telescope-undo.nvim",
        keys = {
          { "<F5>", "<cmd>Telescope undo<cr>", desc = "Search undo history" },
          { "<leader>su", "<cmd>Telescope undo<cr>", desc = "[S]earch [u]ndo history" },
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

  -- easily jump to any location and enhanced f/t motions for Leap
  {
    "ggandor/flit.nvim",
    keys = function()
      ---@type LazyKeys[]
      local ret = {}
      for _, key in ipairs({ "f", "F", "t", "T" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },
  {
    "ggandor/leap.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register({
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["<C-s>"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      })
    end,
  },

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "契" },
        topdelete = { text = "契" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Git: Next Hunk")
        map("n", "[h", gs.prev_hunk, "Git: Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Git: Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Git: Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Git: Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Git: Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Git: Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Git: Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Git: Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Git: Diff This (index)")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Git: Diff This (last)")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Git: GitSigns Select Hunk")
      end,
    },
  },

  -- better folds
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    opts = {},

    init = function()
      -- Using ufo provider need remap `zR` and `zM`.
      vim.keymap.set("n", "zR", function()
        require("ufo").openAllFolds()
      end)
      vim.keymap.set("n", "zM", function()
        require("ufo").closeAllFolds()
      end)
    end,
  },

  -- highlight other uses of the word under the cursor
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = { delay = 200 },
    config = function(_, opts)
      require("illuminate").configure(opts)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          pcall(vim.keymap.del, "n", "]]", { buffer = buffer })
          pcall(vim.keymap.del, "n", "[[", { buffer = buffer })
        end,
      })
    end,
    -- stylua: ignore
    keys = {
      { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
      { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
    },
  },

  -- modern matchit/matchparen
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      vim.g.matchup_matchparen_deferred = 1
      require("nvim-treesitter.configs").setup({
        matchup = {
          enable = true,
        },
      })
    end,
  },

  -- buffer remove
  {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble: Document Diagnostics" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble: Workspace Diagnostics" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Trouble: Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble: Quickfix List (Trouble)" },
    },
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = false,
      highlight = {
        multiline = false,
      },
    },
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "[S]earch [t]odo" },
    },
  },
}
