-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Enable LazyVim auto format
vim.g.autoformat = false
opt.clipboard = "unnamed,unnamedplus"
opt.list = true
opt.relativenumber = false
opt.scrolloff = 7 -- Lines of context
opt.spelllang = { "en", "tr" }
opt.fillchars = opt.fillchars - "diff"
opt.fileencodings = "ucs-bom,utf-8,default,iso8859-9,latin1"
opt.wildignorecase = true
opt.title = true
opt.showmatch = true -- highlight matching parens/brackets/etc
opt.matchtime = 2 -- show matching parens/brackets for 200ms
opt.modelines = 1
opt.showbreak = "↪ " -- string to put at the start of lines that have been wrapped
opt.dict:append("/usr/share/dict/words")

-- if vim.env.DISPLAY ~= nil then
--   opt.list = true
-- end
opt.listchars = {
  -- tab = '│ ', -- characters to be used to show a tab
  tab = '  ',
  trail = '·', -- character to show for trailing spaces
  nbsp = '␣', -- character to show for a non-breakable space character
  extends = '›', -- character to show in the last column, when 'wrap' is off
  precedes = '‹', -- character to show in the first visible column
}

opt.tabstop = 4 -- insert spaces for a tab
opt.softtabstop = 4 -- number of spaces inserted for tabulation replacement
opt.shiftwidth = 4 -- the number of spaces inserted for each indentation


-- Add filetype mappings
vim.filetype.add {
  extension = {
    tex = "tex", zir = "zir", cr = "crystal", rasi = "css",
    me = "groff", ms = "groff", mom = "groff", man = "groff",
  },
  pattern = {
    ["[jt]sconfig.*.json"] = "jsonc",
    ["/tmp/zsh.*"] = "bash",
  },
}

-- Root
if vim.env.SUDO_USER ~= nil then
  opt.swapfile = false
  opt.backup = false
  opt.writebackup = false
  opt.undofile = false
  opt.shada = ""
end

