-- set `mapleader` before plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.fileencodings = "ucs-bom,utf-8,default,iso8859-9,latin1"
opt.clipboard = "unnamed,unnamedplus"
opt.complete = ".,w,b,u,k,kspell,t,i,d"
opt.completeopt = "menu,menuone,noselect"
opt.wildmode = "longest:full,full"
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.wildignorecase = true
opt.pumheight = 10        -- pop up menu height
opt.pumblend = 10         -- popup blend
opt.confirm = true        -- Confirm to save changes before exiting modified buffer
opt.hlsearch = true       -- keep matches highlighted after searching
opt.ignorecase = true     -- ignore case when searching
opt.smartcase = true      -- don't ignore case if user types an uppercase letter
opt.smartindent = true    -- Insert indents automatically
opt.cindent = true
opt.scrolloff = 7         -- keep a minimum of n lines between cursor and top/bottom of the screen
opt.sidescrolloff = 8     -- keep a minimum of n lines between cursor and left/right of the screen
opt.title = true          -- set and update terminal title
opt.cursorline = true     -- highlight the current cursor line
opt.showmode = false      -- disable native mode display
-- opt.showcmd = false       -- disable displaying key presses at the bottom right
-- opt.cmdheight = 0         -- disable command-line area
opt.showmatch = true      -- highlight matching parens/brackets/etc
opt.matchtime = 2         -- show matching parens/brackets for 200ms
opt.splitbelow = true     -- force all hor splits to go below current window
opt.splitright = true     -- force all vert splits to go to the right of current window
-- opt.foldmethod = "marker" -- use markers to specify folds
-- opt.foldlevel = 1
opt.modelines = 1
opt.breakindent = true    -- visually indent wrapped line
opt.showbreak = "↪ "      -- string to put at the start of lines that have been wrapped
opt.timeoutlen = 300      -- milliseconds to wait for a mapped sequence to complete
opt.updatetime = 250      -- decrease update time
opt.signcolumn = "yes"
opt.termguicolors = true
opt.undofile = true
opt.spelllang = { "en", "tr" }
opt.dict:append("/usr/share/dict/words")
-- opt.path:append("**")
opt.shortmess = opt.shortmess
  + "I" -- don't show the default intro message
  + "c" -- don't show redundant messages from ins-completion-menu
opt.formatoptions = opt.formatoptions
  - "o" -- O and o, don't continue comments
  + "r" -- but do continue when pressing enter
  + "n" -- indent past the formatlistpat, not underneath it

opt.foldenable = true
opt.foldlevel = 99 -- Using ufo provider need a large value
opt.foldlevelstart = 99
opt.foldcolumn = "0"
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  -- diff = "╱",
  eob = " ",
}

-- if vim.env.DISPLAY ~= nil then
--   opt.list = true
-- end
opt.listchars = {
  -- tab = '│ ',     -- characters to be used to show a tab
  tab = '  ',
  trail = '·',    -- character to show for trailing spaces
  nbsp = '␣',     -- character to show for a non-breakable space character
  extends = '›',  -- character to show in the last column, when 'wrap' is off
  precedes = '‹', -- character to show in the first visible column
}

opt.expandtab = true  -- convert tabs to spaces
opt.tabstop = 4       -- insert spaces for a tab
opt.softtabstop = 4   -- number of spaces inserted for tabulation replacement
opt.shiftwidth = 4    -- the number of spaces inserted for each indentation
opt.shiftround = true -- round indentation to multiple of 'shiftwidth'

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

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
