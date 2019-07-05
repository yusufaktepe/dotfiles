
"=====================================================================
" Plugins
"=====================================================================

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

" Interface
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mbbill/undotree'

" Editing & Motion
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'matze/vim-move'
Plug 'andymass/vim-matchup'

" Git
Plug 'tpope/vim-fugitive'	" git wrapper
Plug 'airblade/vim-gitgutter'	" shows git diff in the gutter (sign column)
Plug 'jreybert/vimagit'

" Syntax
Plug 'hail2u/vim-css3-syntax'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'chr4/nginx.vim'
Plug 'vifm/vifm.vim'

" Auto Completion, linting, etc
Plug 'w0rp/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim'
Plug 'deoplete-plugins/deoplete-zsh'

" Snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" Multi-language completions
Plug 'autozimu/LanguageClient-neovim', {
	\ 'branch': 'next',
	\ 'do': 'bash install.sh',
	\ }

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Misc
Plug 'ap/vim-css-color'		" color name highlighter
Plug 'vimwiki/vimwiki'		" personal wiki
Plug 'KabbAmine/vCoolor.vim'	" color picker
Plug 'godlygeek/tabular'	" text filtering and alignment
Plug 'plasticboy/vim-markdown'	" syntax highlighting, matching rules and mappings
Plug 'tpope/vim-eunuch'		" helpers for unix
Plug 'tpope/vim-unimpaired'	" bracket mappings
Plug 'lambdalisue/suda.vim'	" sudo helper
Plug 'chrisbra/Recover.vim'	" show diff, when recovering a buffer
Plug 'jamessan/vim-gnupg'	" edit gpg encrypted files
Plug 'mattn/webapi-vim'		" interface to Web API (for gist-vim)
Plug 'mattn/gist-vim'		" create gists
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'

" Themes
Plug 'morhetz/gruvbox'

call plug#end()

"=====================================================================
" Settings
"=====================================================================

filetype plugin indent on
syntax on

set nocompatible
set encoding=utf-8
set number relativenumber
" set signcolumn=yes		" always show sign column
set wildmode=longest,list,full	" enable autocompletion
set completeopt+=noinsert,noselect
set go=a
set mouse=a
set clipboard+=unnamedplus
set hlsearch			" keep matches highlighted after searching
set ignorecase			" ignore case when searching
set smartcase			" don't ignore case if user types an uppercase letter
set scrolloff=3			" keep a minimum of 3 lines between cursor and top/bottom of screen
set inccommand=nosplit		" when typing a :%s/foo/bar/g command, show live preview
set title			" set and update terminal title
set cursorline			" highlight the current cursor line
set noshowmode			" disable native mode display (use airline instead)
set showmatch			" highlight matching parens/brackets/etc
set matchtime=2			" show matching parens/brackets for 200ms
set termguicolors		" enable true color mode for terminals that support it
set splitbelow splitright	" Splits open at the bottom and right
set nofoldenable		" disable folding by default
set breakindent			" visually indent wrapped line
set undofile			" save undo history to a file
set undodir=~/.cache/vim/undo	" set undo directory

" Theme
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
set bg=dark

"=====================================================================
" Mappings
"=====================================================================

let mapleader ="\<space>"

" Do not copy deleted text with 'c' & 'x' in normal mode
nnoremap c "_c
nnoremap x "_x

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Create splits
nnoremap <silent> <leader>s :new<return><esc>
nnoremap <silent> <leader>S :split<return><esc>
nnoremap <silent> <leader>v :vnew<return><esc>
nnoremap <silent> <leader>V :vsplit<return><esc>

" resize splits left/right
noremap <M-[> <C-w>3<
noremap <M-]> <C-w>3>

" resize splits up/down
noremap <M-{> <C-w>3-
noremap <M-}> <C-w>3+

" Open/close tabs
noremap <silent> <M-cr> :tabnew<CR>
noremap <silent> <M-backspace> :tabclose<CR>

" Navigate left/right through tabs
noremap <silent> <M-,> :tabn<CR>
noremap <silent> <M-;> :tabp<CR>

" Rearrange tabs
noremap <silent> <M->> :+tabm<CR>
noremap <silent> <M-<> :-tabm<CR>

" Autocompletion
imap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Reload file with ISO 8859-9 encoding
nnoremap <F12> :e ++enc=iso88599<CR>

" Quit active
nnoremap <silent> Q :lclose \| pclose \| confirm q<CR>

" Quit all, bring up a prompt when buffers have been changed
nnoremap ZQ :confirm qall<CR>

" Save file
noremap <C-s> :w<CR>

" Clear search highlight and command-line on Esc
nnoremap <silent> <esc> :noh \| echo ""<CR>

" Make j and k treat wrapped lines as independent lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Toggle line wrapping
nnoremap <silent> <leader>W :setlocal wrap!<CR>:setlocal wrap?<CR>

" Toggle paste mode
noremap <silent> <F2> :set paste! nopaste?<CR>

" Enter command mode with substitution command prefilled
nnoremap S :%s//gc<Left><Left><Left>

" Append modeline after last line in buffer
nnoremap <silent> <leader>ml :call AppendModeline()<CR>

" Indent visual selection without clearing selection
vmap > >gv
vmap < <gv

" Delete while in insert mode
inoremap <C-d> <C-o>dd
inoremap <C-c> <C-o>D

" Duplicate line downwards/upwards [ ! CONFLICT: vim-move ]
" nnoremap <C-M-j> "dY"dp
" nnoremap <C-M-k> "dY"dPj

" Duplicate selection downwards/upwards [ ! CONFLICT: vim-move ]
" vnoremap <C-M-j> "dy`>"dpgv
" vnoremap <C-M-k> "dy`<"dPjgv

" Copy selected text to system clipboard (gvim/nvim/vim-x11):
vnoremap <C-c> "+y
map <C-p> "+P

" Yank path of current file to system clipboard
nnoremap <silent> <leader>yp :let @+ = expand("%:p")<CR>:echom "Copied " . @+<CR>

" Quickly edit a macro
" See: https://github.com/mhinz/vim-galore#quickly-edit-your-macros
nnoremap <leader>m :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><c-f><left>

" Force redraw
" See: https://github.com/mhinz/vim-galore#saner-ctrl-l
nnoremap <leader>l :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><c-l>

" Reload vim configuration
nnoremap <silent> <leader>R :so ~/.config/nvim/init.vim<return><esc>

" Goto file under cursor in new tab
noremap gF <C-w>gf

" Make c-n and c-p behave like up/down arrows, i.e. take into account the
" beginning of the text entered in the command line when jumping
" See: https://github.com/mhinz/vim-galore#saner-command-line-history
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" emacs-style movements
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <C-g>  <C-c>

" Check file in shellcheck:
map <leader>cs :!clear && shellcheck %<CR>

" Open bibliography file in split
map <leader>bi :vsp<space>$BIB<CR>
map <leader>re :vsp<space>$REFER<CR>

" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>C :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
map <leader>op :!opout <c-r>%<CR><CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>or :setlocal spell! spelllang=en_us<CR>

"=====================================================================
" Plugin Settings
"=====================================================================

"=== Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline_powerline_fonts=1
let g:airline_theme='gruvbox'

"=== Deoplete
let g:deoplete#enable_at_startup = 1

"=== Ale
let g:ale_linters = {
	\ 'c':          ['clangd'],
	\ 'cpp':        ['clangd'],
	\ 'javascript': ['eslint'],
	\ }

let g:ale_fixers = {
	\ 'bash':       ['shfmt'],
	\ 'sh':         ['shfmt'],
	\ 'c':          ['clang-format'],
	\ 'cpp':        ['clang-format'],
	\ 'javascript': ['eslint'],
	\ }

let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = 'ℹ'
let g:ale_sign_style_error = '✖'
let g:ale_sign_style_warning = '⚠'

let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_fix_on_save = 0

" shfmt options:
"  -kp: keep column alignment paddings
"  -bn: binary ops like && and | may start a line
"  -sr: redirect operators will be followed by a space
let g:ale_sh_shfmt_options = "-kp -bn -sr"

map <leader>af :ALEFix<CR>
map <leader>al :ALELint<CR>

"=== LanguageClient
let g:LanguageClient_serverCommands = {
	\ 'sh':             ['bash-language-server', 'start'],
	\ 'c':              ['clangd'],
	\ 'cpp':            ['clangd'],
	\ 'javascript.jsx': ['javascript-typescript-stdio'],
	\ 'javascript':     ['javascript-typescript-stdio'],
	\ 'typescript':     ['javascript-typescript-stdio'],
	\ }

" Let ALE handle linting
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_diagnosticsList = "Disabled"

nnoremap <silent> <leader>k :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gD :call LanguageClient#textDocument_definition({"gotoCmd": "tabedit"})<CR>
nnoremap <silent> <leader>gr :call LanguageClient#textDocument_rename()<CR>

"=== NeoSnippet
let g:neosnippet#enable_completed_snippet=1

imap <C-e> <Plug>(neosnippet_expand_or_jump)
smap <C-e> <Plug>(neosnippet_expand_or_jump)
xmap <C-e> <Plug>(neosnippet_expand_target)

imap <expr><CR>
\ (pumvisible() && neosnippet#expandable()) ? "\<Plug>(neosnippet_expand_or_jump)" : "\<CR>"

"=== Editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

"=== Fugitive
nnoremap <leader>gb :Gblame<CR>
vnoremap <leader>gb :Gblame<CR>

"=== Gist-Vim
let g:gist_token_file = '~/.config/gist-vim'

"=== Goyo plugin makes text more readable when writing prose:
map <leader>f :Goyo \| set linebreak<CR>

"=== NerdTree
map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1

"=== Suda
cnoremap W!! <bar> :w suda://%<CR>
cnoremap WQ!! <bar> :wq suda://%<CR>
cnoremap R!! <bar> :r suda://%<CR>
cnoremap E!! <bar> :e suda://%<CR>

"=== Undo tree
nnoremap <F5> :UndotreeToggle<CR>
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 6

"=== Vim-move
let g:move_key_modifier = 'C-M'

"=== VimWiki
map <leader>w :VimwikiIndex
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{'path': '~/repos/writings', 'syntax': 'markdown', 'ext': '.md'}]

"=== VCoolor
nmap <silent> <leader>co :VCoolor<CR>
let g:vcoolor_disable_mappings = 1

"=====================================================================
" Functions
"=====================================================================

" Open help in full-window view (empty buffer OR new tab)
function! HelpTab(...)
	let cmd = 'tab help %s'
	if bufname('%') == "" && getline(1) == ""
		let cmd = 'help %s | only'
	endif
	exec printf(cmd, join(a:000, ' '))
endfunction

command! -nargs=* -complete=help H call HelpTab(<q-args>)

" Open or create a tab at the given tab index
function! Tabnm(n)
	try
		exec "tabn " . a:n
	catch
		$tabnew
	endtry
endfunction

" Navigation through tabs by index
noremap <silent> <M-1> :call Tabnm(1)<CR>
noremap <silent> <M-2> :call Tabnm(2)<CR>
noremap <silent> <M-3> :call Tabnm(3)<CR>
noremap <silent> <M-4> :call Tabnm(4)<CR>
noremap <silent> <M-5> :call Tabnm(5)<CR>
noremap <silent> <M-6> :call Tabnm(6)<CR>
noremap <silent> <M-7> :call Tabnm(7)<CR>
noremap <silent> <M-8> :call Tabnm(8)<CR>
noremap <silent> <M-9> :call Tabnm(9)<CR>
noremap <silent> <M-0> :call Tabnm(10)<CR>

" Append modeline after last line in buffer
function! AppendModeline()
	let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
		\ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
	call append(line("$"), l:modeline)
endfunction

"=====================================================================
" autogroups & autocommands
"=====================================================================

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex

" Enable Goyo by default for mutt writting
autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo

" Disable automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
autocmd BufWritePost *bmdirs,*bmfiles !shortcuts

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Update binds when sxhkdrc is updated.
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

