local M = {}

-- Write files with sudo
-- https://github.com/ibhagwan/nvim-lua/blob/main/lua/utils.lua
-- M.sudo_exec = function(cmd, print_output)
--   vim.fn.inputsave()
--   local password = vim.fn.inputsecret("Password: ")
--   vim.fn.inputrestore()
--   if not password or #password == 0 then
--     M.warn("Invalid password, sudo aborted")
--     return false
--   end
--   local out = vim.fn.system(string.format("sudo -p '' -S %s", cmd), password)
--   if vim.v.shell_error ~= 0 then
--     print("\r\n")
--     M.err(out)
--     return false
--   end
--   if print_output then print("\r\n", out) end
--   return true
-- end
--
-- M.sudo_write = function(tmpfile, filepath)
--   if not tmpfile then tmpfile = vim.fn.tempname() end
--   if not filepath then filepath = vim.fn.expand("%") end
--   if not filepath or #filepath == 0 then
--     M.err("E32: No file name")
--     return
--   end
--   -- `bs=1048576` is equivalent to `bs=1M` for GNU dd or `bs=1m` for BSD dd
--   -- Both `bs=1M` and `bs=1m` are non-POSIX
--   local cmd = string.format("dd if=%s of=%s bs=1048576",
--     vim.fn.shellescape(tmpfile),
--     vim.fn.shellescape(filepath))
--   -- no need to check error as this fails the entire function
--   vim.api.nvim_exec2(string.format("write! %s", tmpfile), { output = true })
--   if M.sudo_exec(cmd) then
--     -- refreshes the buffer and prints the "written" message
--     vim.cmd.checktime()
--     -- exit command mode
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(
--       "<Esc>", true, false, true), "n", true)
--   end
--   vim.fn.delete(tmpfile)
-- end

-- https://github.com/folke/dot/blob/master/nvim/lua/util/init.lua
function M.colorize()
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.statuscolumn = ""
  vim.wo.signcolumn = "no"
  vim.opt.listchars = { space = " " }

  local buf = vim.api.nvim_get_current_buf()

  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  while #lines > 0 and vim.trim(lines[#lines]) == "" do
    lines[#lines] = nil
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

  vim.b[buf].minianimate_disable = true

  vim.api.nvim_chan_send(vim.api.nvim_open_term(buf, {}), table.concat(lines, "\r\n"))
  vim.keymap.set("n", "q", "<cmd>qa!<cr>", { silent = true, buffer = buf })
  vim.api.nvim_create_autocmd("TextChanged", { buffer = buf, command = "normal! G$" })
  vim.api.nvim_create_autocmd("TermEnter", { buffer = buf, command = "stopinsert" })

  vim.defer_fn(function()
    vim.b[buf].minianimate_disable = false
  end, 2000)
end

return M
