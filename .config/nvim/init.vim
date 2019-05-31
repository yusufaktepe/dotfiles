let mapleader =","

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'matze/vim-move'
Plug 'andymass/vim-matchup'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'morhetz/gruvbox'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'jreybert/vimagit'
Plug 'vimwiki/vimwiki'
Plug 'vim-airline/vim-airline'
Plug 'lambdalisue/suda.vim'
Plug 'vifm/vifm.vim'
Plug 'ap/vim-css-color'
Plug 'KabbAmine/vCoolor.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/Recover.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'mbbill/undotree'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
call plug#end()

"let g:gruvbox_contrast_dark='hard'
let g:airline_powerline_fonts=1
let g:airline_theme='gruvbox'
colorscheme gruvbox
set bg=dark

set go=a
set mouse=a
set clipboard=unnamedplus
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

set undofile			" save undo history to a file
set undodir=~/.cache/vim/undo	" set undo directory

" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Press F12 to switch to ISO 8859-9 encoding
	nnoremap <F12> :e ++enc=iso88599<CR>

" Suda plugin
	cnoremap W!! <bar> :w suda://%<CR>
	cnoremap WQ!! <bar> :wq suda://%<CR>
	cnoremap R!! <bar> :r suda://%<CR>
	cnoremap E!! <bar> :e suda://%<CR>

" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>

" Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	let NERDTreeShowHidden=1

" Undo tree
	nnoremap <F5> :UndotreeToggle<CR>
	let g:undotree_ShortIndicators = 1
	let g:undotree_WindowLayout = 2
	let g:undotree_DiffpanelHeight = 6

" GitGutter
	let g:gitgutter_enabled = 0 " disabled by default

" Vim-move
	let g:move_key_modifier = 'C'

" VCoolor
	let g:vcoolor_disable_mappings = 1
	nmap <silent> <leader>V :VCoolor<CR>

" quit active
	nnoremap <silent> Q :lclose \| pclose \| confirm q<cr>

" quit all, bring up a prompt when buffers have been changed
	nnoremap ZQ :confirm qall<cr>

" Clear search highlight and command-line on Esc
	nnoremap <silent> <esc> :noh \| echo ""<cr>

" Make j and k treat wrapped lines as independent lines
	nnoremap <expr> j v:count ? 'j' : 'gj'
	nnoremap <expr> k v:count ? 'k' : 'gk'

" Indent visual selection without clearing selection
	vmap > >gv
	vmap < <gv

" Delete while in insert mode
	inoremap <C-d> <C-o>dd
	inoremap <C-c> <C-o>D

" Duplicate selection downwards/upwards
	vnoremap <C-M-j> "dy`>"dpgv
	vnoremap <C-M-k> "dy`<"dPjgv

" Yank path of current file to system clipboard
	nnoremap <silent> <leader>yp :let @+ = expand("%:p")<cr>:echom "Copied " . @+<cr>

" Quickly edit a macro
" See: https://github.com/mhinz/vim-galore#quickly-edit-your-macros
	nnoremap <leader>m :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" Force redraw
" See: https://github.com/mhinz/vim-galore#saner-ctrl-l
	nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" Reload vim configuration
	nnoremap <silent> <leader>R :so ~/.config/nvim/init.vim<return><esc>

" goto file under cursor in new tab
	noremap gF <C-w>gf

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>

" Open my bibliography file in split
	map <leader>b :vsp<space>$BIB<CR>
	map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex
	let g:vimwiki_list = [{'path': '~/repos/writings', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
	vnoremap <C-c> "+y
	map <C-p> "+P

" Enable Goyo by default for mutt writting
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost *bmdirs,*bmfiles !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
" Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
