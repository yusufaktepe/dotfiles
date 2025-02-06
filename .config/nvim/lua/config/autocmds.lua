-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

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

-- Suppress readonly warning
autocmd("BufEnter", { pattern = "/etc/*,/usr/*", command = "set noro" })

autocmd("BufEnter", {
  pattern = "/tmp/*",
  callback = function()
    vim.opt.swapfile = false
    vim.opt.backup = false
    vim.opt.writebackup = false
    vim.opt.undofile = false
    vim.opt.shada = ""
  end,
})
autocmd("BufEnter", {
  pattern = { "*.zsh_history", "/tmp/dir*" },
  callback = function()
    vim.cmd("normal zz")
    vim.defer_fn(function()
      vim.opt.clipboard = ""
    end, 1000)
  end,
})
autocmd("BufEnter", { pattern = "/tmp/*gpaste*", command = "map Q ZZ | set ft=text" })
autocmd("BufEnter", { pattern = "*.kbd", command = "set ft=lisp | set commentstring=;;\\ %s" })

autocmd("BufWritePost", { pattern = "*Xresources,*Xdefaults", command = "!xrdb %" })
autocmd("BufWritePost", { pattern = "~/.config/fontconfig/*", command = "!fc-cache" })
autocmd("BufWritePost", { pattern = "*sxhkdrc", command = "!pkill -USR1 sxhkd" })

autocmd("VimLeave", { pattern = "*.tex", command = "!texclear %" })

-- Disable auto-comment
autocmd("FileType", {
  command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
})

-- Set FileType for new files w/o ext.
-- autocmd("BufEnter", {
--   callback = function()
--     vim.schedule(function()
--       if vim.bo.filetype == "" then
--         vim.bo.filetype = "sh"
--       end
--     end)
--   end,
-- })

-- autocmd("FileType", {
--   pattern = "markdown",
--   callback = function()
--     vim.diagnostic.enable(false)
--   end,
-- })

-- use 'c' mapping instead
autocmd("FileType", {
  pattern = "trouble",
  callback = function()
    vim.keymap.set(
      "n",
      "c",
      "wt):silent !xdg-open https://www.shellcheck.net/wiki/SC<C-r><C-w><cr>0",
      { desc = "Trouble: Open shellcheck wiki", buffer = 0, silent = true }
    )
  end,
})

-- Show cursor line only in active window
-- https://github.com/folke/dot/blob/master/nvim/lua/config/autocmds.lua
-- autocmd({ "InsertLeave", "WinEnter" }, {
--   callback = function()
--     if vim.w.auto_cursorline then
--       vim.wo.cursorline = true
--       vim.w.auto_cursorline = nil
--     end
--   end,
-- })
-- autocmd({ "InsertEnter", "WinLeave" }, {
--   callback = function()
--     if vim.wo.cursorline then
--       vim.w.auto_cursorline = true
--       vim.wo.cursorline = false
--     end
--   end,
-- })
