local Util = require("user.util")

-- Add a new mapping
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

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

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Perform dot commands over visual blocks
map("v", ".", "<cmd>normal .<cr>")

-- Do not copy deleted text with 'c' & 'x' in normal mode
map("n", "c", '"_c')
map("n", "C", '"_C')
map("n", "x", '"_x')
map("n", "X", '"_X')

map("n", "<leader>dd", 'gg"_dG', { desc = "Clear file" })

-- Disable C-c warning
-- map("n", "<C-c>", "<Nop>")

-- Change word with <C-c>
map("n", "<C-c>", "<cmd>normal! ciw<cr>i", { desc = "Change word (ciw)" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh | echo<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- Saner behavior of n and N
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Save file
-- map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- Quit
map("n", "Q", "<cmd>confirm q<cr>", { desc = "Quit with confirm" })
map("n", "<M-q>", "<cmd>qall<cr>", { desc = "Quit all" })
map("n", "ZQ", "<cmd>confirm qall<cr>", { desc = "Quit all, bring up a prompt when buffers have been changed" })

-- Lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Quickfix
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open Quickfix List" })

if not Util.has("trouble.nvim") then
  map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
  map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
end

-- stylua: ignore start

-- Toggle options
map("n", "<leader>uf", require("user.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
map("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>W", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", function() Util.toggle_number() end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
map("n", "<leader>uo", Util.toggle_colorcolumn, { desc = "Toggle colorcolumn" })
map("n", "<leader>uL", Util.toggle_list, { desc = "Toggle listchars" })
if vim.lsp.inlay_hint then
  map("n", "<leader>uH", function() vim.lsp.inlay_hint(0, nil) end, { desc = "Toggle Inlay Hints" })
end

-- Highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window"})
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window"})
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window"})
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window"})
map("t", '<C-/>', "<cmd>close<cr>", { desc = "Hide Terminal"})
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
map("t", "<C-w>", [[<C-\><C-n><C-w>]])
map("t", "jk", [[<C-\><C-n>]])

-- Windows
map("n", "<leader>ww", "<C-W>p", { desc = "Win: Jump other", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Win: Delete", remap = true })
map("n", "<leader>wr", "<cmd>vnew<cr>", { desc = "Win: New right", remap = true })
map("n", "<leader>wb", "<cmd>new<cr>", { desc = "Win: New below", remap = true })
map("n", "<leader>wR", "<C-W>v", { desc = "Win: Split right", remap = true })
map("n", "<leader>wB", "<C-W>s", { desc = "Win: Split below", remap = true })

-- Tabs
map("n", "<M-CR>", "<cmd>tabnew<cr>", { desc = "Tab: New" })
map("n", "<M-Backspace>", "<cmd>tabclose<cr>", { desc = "Tab: Close" })

map("n", "<S-h>", "<cmd>tabprevious<cr>", { desc = "Tab: Goto prev" })
map("n", "<S-l>", "<cmd>tabnext<cr>", { desc = "Tab: Goto next" })
map("n", "<M-S-a>", "g<Tab>", { silent = true, desc = "Tab: Goto last accessed" })
map("n", "<leader><tab>a", "g<Tab>", { silent = true, desc = "Tab: Goto last accessed" })

map("n", "<M->>", "<cmd>+tabm<cr>", { desc = "Tab: Move right" })
map("n", "<M-<>", "<cmd>-tabm<cr>", { desc = "Tab: Move left" })

map("n", "gF", "<C-w>gf", { desc = "Go to file under cursor (new tab)" })

map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
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
map("c", "W!!", "<esc>:lua require('user.util').sudo_write()<cr>", { desc = "Write with sudo!"})

-- Ctrl-Backspace to remove last word
map("i", "<C-h>", "<C-w>")
map("c", "<C-h>", "<C-w>", { silent = false })
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
command("ToggleList", Util.toggle_list)
