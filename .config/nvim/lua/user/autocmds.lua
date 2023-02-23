-- Simplify autocmd creation
local augid = vim.api.nvim_create_augroup("user", { clear = true })
local autocmd = function(event, opts)
  return vim.api.nvim_create_autocmd(event, vim.tbl_extend("force", { group = augid }, opts))
end

-- autocmd("InsertEnter", {
--   callback = function()
--     vim.opt.relativenumber = false
--   end,
-- })
--
-- autocmd("InsertLeave", {
--   callback = function()
--     vim.opt.relativenumber = true
--   end,
-- })

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Resize splits if window got resized
autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Go to last loc when opening a buffer
-- autocmd("BufReadPost", {
--   callback = function()
--     local mark = vim.api.nvim_buf_get_mark(0, '"')
--     local lcount = vim.api.nvim_buf_line_count(0)
--     if mark[1] > 0 and mark[1] <= lcount then
--       pcall(vim.api.nvim_win_set_cursor, 0, mark)
--     end
--   end,
-- })

-- Suppress readonly warning
autocmd("BufEnter", { pattern = "/etc/*,/usr/*", command = "set noro" })

autocmd("BufEnter", {
  pattern = "/tmp/*",
  callback = function()
    vim.opt.swapfile = false
    vim.opt.backup = false
    vim.opt.writebackup = false
    vim.opt.undofile = false
    vim.opt.shada = ''
  end,
})
autocmd("BufEnter", { pattern = "*.zsh_history,/tmp/dir*", command = "set clipboard=" })
autocmd("BufEnter", { pattern = "/tmp/*gpaste*", command = "set cmdheight=0 | map Q ZZ" })

autocmd("BufWritePost", { pattern = "*Xresources,*Xdefaults", command = "!xrdb %" })
autocmd("BufWritePost", { pattern = "~/.config/fontconfig/*", command = "!fc-cache" })
autocmd("BufWritePost", { pattern = "*sxhkdrc", command = "!pkill -USR1 sxhkd" })

autocmd("VimLeave", { pattern = "*.tex", command = "!texclear %" })

-- Disable auto-comment
autocmd("FileType", {
  command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"
})

-- Close some filetypes with <q>
autocmd("FileType", {
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
    "fugitiveblame",
    "TelescopePrompt",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close!<cr>", { buffer = event.buf, silent = true })
  end,
})

autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Show cursor line only in active window
-- https://github.com/folke/dot/blob/master/nvim/lua/config/autocmds.lua
autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})

-- Create directories when needed, when saving a file
autocmd("BufWritePre", {
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match

    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    local backup = vim.fn.fnamemodify(file, ":p:~:h")
    backup = backup:gsub("[/\\]", "%%")
    vim.go.backupext = backup
  end,
})
