-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
local util = require("util")

local map = vim.keymap.set

-- Define a user command
local function command(cmd, repl)
  vim.api.nvim_create_user_command(cmd, repl, {})
end

-- Register a command-line abbreviation
local cabbrev = function(a, c)
  vim.cmd(("cnoreabbrev %s %s"):format(a, c))
end

-- Ignore my lazy shift finger
cabbrev("W", "w")
cabbrev("WQ", "wq")
cabbrev("Wq", "wq")
cabbrev("Q", "q")
cabbrev("X", "x")

-- Perform dot commands over visual blocks
map("v", ".", "<cmd>normal .<cr>")

-- Do not copy deleted text with 'c' & 'x' in normal mode
map("n", "c", '"_c')
map("n", "C", '"_C')
map("n", "x", '"_x')
map("n", "X", '"_X')

map("n", "<leader>dd", 'gg"_dG', { desc = "Clear file" })

-- Change word with <C-c>
map("n", "<C-c>", "<cmd>normal! ciw<cr>i", { desc = "Change word (ciw)" })

-- Quit
map("n", "Q", "<cmd>confirm q<cr>", { desc = "Quit with confirm" })
map("n", "<M-q>", "<cmd>qall<cr>", { desc = "Quit all" })
map("n", "ZQ", "<cmd>confirm qall<cr>", { desc = "Quit all, bring up a prompt when buffers have been changed" })

-- Toggle options
map("n", "<leader>W", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>uo", util.toggle_colorcolumn, { desc = "Toggle colorcolumn" })
map("n", "<leader>ua", util.toggle_list, { desc = "Toggle listchars" })

-- Terminal Mappings
map("t", "<C-w>", [[<C-\><C-n><C-w>]])
map("t", "jk", [[<C-\><C-n>]])

-- windows
map("n", "<leader>wb", "<cmd>new<cr>", { desc = "New window below", remap = true })
map("n", "<leader>wr", "<cmd>vnew<cr>", { desc = "New window right", remap = true })
map("n", "<leader>wB", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>wR", "<C-W>v", { desc = "Split window right", remap = true })

-- tabs
map("n", "<M-CR>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<M-Backspace>", "<cmd>tabclose<cr>", { desc = "Close Tab" })

map("n", "<S-h>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<S-l>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<M-S-a>", "g<Tab>", { silent = true, desc = "Goto Last Accessed Tab" })
map("n", "<leader><tab>a", "g<Tab>", { silent = true, desc = "Goto Last Accessed Tab" })

map("n", "<M->>", "<cmd>+tabm<cr>", { desc = "Move Tab > right" })
map("n", "<M-<>", "<cmd>-tabm<cr>", { desc = "Move Tab < left" })

map("n", "gF", "<C-w>gf", { desc = "Go to file under cursor (new tab)" })

map("n", '<leader>"', "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Remove all trailing whitespace
map(
  "n", "<F4>",
  "<cmd>let _s=@/ | :%s/\\s\\+$//e | :let @/=_s | :nohl | :unlet _s<cr>",
  { silent = true, desc = "Remove trailing whitespace" }
)

-- Yank path of current file to system clipboard
map(
  "n", "<leader>yp",
  "<cmd>let @+ = expand('%:p')<CR>:echom 'Copied ' . @+<cr>",
  { silent = true, desc = "Yank path of file to clipboard" }
)

-- Reload file with ISO 8859-9 encoding
map("n", "<F12>", "<cmd>e ++enc=iso8859-9<cr>", { desc = "Reload file with ISO 8859-9 encoding" })

-- Emacs-style movements in command mode
map("c", "<C-a>", "<Home>", { silent = false })
map("c", "<C-b>", "<Left>", { silent = false })
map("c", "<C-d>", "<Delete>", { silent = false })
map("c", "<C-f>", "<Right>", { silent = false })
map("c", "<C-g>", "<C-c>", { silent = false })
map("c", "<M-b>", "<S-Left>", { silent = false })
map("c", "<M-f>", "<S-Right>", { silent = false })

-- Make <C-n> and <C-p> behave like up/down arrows
map(
  "c", "<C-p>",
  "pumvisible() ? '<lt>C-p>' : '<lt>Up>'",
  { expr = true, silent = false, desc = "C: History prev" }
)
map(
  "c", "<C-n>",
  "pumvisible() ? '<lt>C-n>' : '<lt>Down>'",
  { expr = true, silent = false, desc = "C: History next" }
)

-- Write file with sudo
map("c", "W!!", "<esc>:lua require('util').sudo_write()<cr>", { desc = "Write with sudo!"})

-- Ctrl-Backspace to remove last word
map("i", "<C-h>", "<C-w>")
map("i", "<C-BS>", "<C-w>")
map("c", "<C-h>", "<C-w>", { silent = false })
map("c", "<C-BS>", "<C-w>", { silent = false })
map("i", "<C-Del>", "<C-o>de")
map("i", "<S-Del>", "<C-o>dw")

-- trq fixes
map("", "İ", "I")
map("", "ş", ";")
map("", "Ş", ":")
map("", "ö", ",")
map("", "Ö", "<")
map("", "ç", ".")
map("", "Ç", ">")
map("", "ğ", "[")
map("", "Ğ", "{")
map("", "ü", "]")
map("", "Ü", "}")

-- Enter command mode with substitution command prefilled
map(
  "n", "<M-s>",
  ":%s///gc<Left><Left><Left><Left>",
  { silent = false, desc = "Enter command mode with substitution command prefilled (Normal)" }
)
map(
  "v", "<M-s>",
  '"hy:%s/<C-r>h//gc<Left><Left><Left>',
  { silent = false, desc = "Enter command mode with substitution command prefilled (Visual)" }
)

-- Show changes for the current buffer
command("DiffOrig", "vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis | wincmd l")

-- Toggle `list`
command("ToggleList", util.toggle_list)

