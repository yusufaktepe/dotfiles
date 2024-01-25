-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

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
autocmd("BufEnter", { pattern = "*.zsh_history,/tmp/dir*", command = "set clipboard=" })
autocmd("BufEnter", { pattern = "/tmp/*gpaste*", command = "set cmdheight=0 | map Q ZZ" })

autocmd("BufWritePost", { pattern = "*Xresources,*Xdefaults", command = "!xrdb %" })
autocmd("BufWritePost", { pattern = "~/.config/fontconfig/*", command = "!fc-cache" })
autocmd("BufWritePost", { pattern = "*sxhkdrc", command = "!pkill -USR1 sxhkd" })

autocmd("VimLeave", { pattern = "*.tex", command = "!texclear %" })

-- Disable auto-comment
autocmd("FileType", {
  command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
})

autocmd("FileType", {
  pattern = "Trouble",
  callback = function()
    vim.keymap.set(
      "n",
      "s",
      "wt):silent !xdg-open https://github.com/koalaman/shellcheck/wiki/SC<C-r><C-w><cr>0",
      { desc = "Trouble: Open shellcheck wiki", buffer = 0, silent = true }
    )
  end,
})

-- Show cursor line only in active window
-- https://github.com/folke/dot/blob/master/nvim/lua/config/autocmds.lua
-- autocmd({ "InsertLeave", "WinEnter" }, {
--   callback = function()
--     local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
--     if ok and cl then
--       vim.wo.cursorline = true
--       vim.api.nvim_win_del_var(0, "auto-cursorline")
--     end
--   end,
-- })
-- autocmd({ "InsertEnter", "WinLeave" }, {
--   callback = function()
--     local cl = vim.wo.cursorline
--     if cl then
--       vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
--       vim.wo.cursorline = false
--     end
--   end,
-- })
