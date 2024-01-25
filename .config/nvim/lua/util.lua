local M = {}

local Util = require("lazyvim.util")

-- Toggle colorcolumn
function M.toggle_colorcolumn()
  local value = vim.api.nvim_get_option_value("colorcolumn", {})
  if value == "" then
    vim.api.nvim_set_option_value("colorcolumn", "80", {})
    vim.o.list = true
    vim.g.miniindentscope_disable = false
    if Util.has("mini.indentscope") then
      local opts = Util.opts("mini.indentscope")
      require("mini.indentscope").setup(opts)
    end
  else
    vim.api.nvim_set_option_value("colorcolumn", "", {})
    vim.o.list = false
    vim.g.miniindentscope_disable = true
  end
end

-- Toggle `list` and list plugins
function M.toggle_list()
  if vim.opt.list:get() then
    vim.o.list = false
    vim.g.miniindentscope_disable = true
    if Util.has("indent-blankline.nvim") then
      require("ibl").setup_buffer(0, { enabled = false, })
    end
  else
    vim.o.list = true
    vim.g.miniindentscope_disable = false
    if Util.has("mini.indentscope") then
      local opts = Util.opts("mini.indentscope")
      require("mini.indentscope").setup(opts)
    end
    if Util.has("indent-blankline.nvim") then
      require("ibl").setup_buffer(0, { enabled = true, })
    end
  end
end

-- Write files with sudo
-- https://github.com/ibhagwan/nvim-lua/blob/main/lua/utils.lua
function M.sudo_exec(cmd, print_output)
  vim.fn.inputsave()
  local password = vim.fn.inputsecret("Password: ")
  vim.fn.inputrestore()
  if not password or #password == 0 then
    print("Invalid password, sudo aborted")
    return false
  end
  local out = vim.fn.system(string.format("sudo -p '' -S %s", cmd), password)
  if vim.v.shell_error ~= 0 then
    print("\r\n")
    print(out)
    return false
  end
  if print_output then
    print("\r\n", out)
  end
  return true
end

function M.sudo_write(tmpfile, filepath)
  if not tmpfile then
    tmpfile = vim.fn.tempname()
  end
  if not filepath then
    filepath = vim.fn.expand("%")
  end
  if not filepath or #filepath == 0 then
    print("E32: No file name")
    return
  end
  -- `bs=1048576` is equivalent to `bs=1M` for GNU dd or `bs=1m` for BSD dd
  -- Both `bs=1M` and `bs=1m` are non-POSIX
  local cmd = string.format("dd if=%s of=%s bs=1048576", vim.fn.shellescape(tmpfile), vim.fn.shellescape(filepath))
  -- no need to check error as this fails the entire function
  vim.api.nvim_exec(string.format("write! %s", tmpfile), true)
  if M.sudo_exec(cmd) then
    vim.cmd("redraw")
    print(string.format('\n"%s" written', filepath))
    vim.cmd("e!")
  end
  vim.fn.delete(tmpfile)
end

return M

