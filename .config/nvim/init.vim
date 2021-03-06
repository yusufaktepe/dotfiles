" vim: set ts=2 sw=2 tw=78 et :
"=====================================================================
" PLUGINS {{{
"=====================================================================

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
  echo 'Downloading junegunn/vim-plug to manage plugins...'
  silent !mkdir -p ~/.config/nvim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
  au VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

" Interface
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim'
Plug 'mbbill/undotree'
" Plug 'psliwka/vim-smoothie'

" Editing & Motion
Plug 'machakann/vim-swap'
Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'matze/vim-move'
Plug 'andymass/vim-matchup'

" Git
Plug 'tpope/vim-fugitive'     " git wrapper
Plug 'airblade/vim-gitgutter' " shows git diff in the gutter (sign column)
Plug 'jreybert/vimagit'
Plug 'christoomey/vim-conflicted'

" Syntax
Plug 'hail2u/vim-css3-syntax'
Plug 'kchmck/vim-coffee-script'
Plug 'mboughaba/i3config.vim'
Plug 'chr4/nginx.vim'

" Auto Completion, linting, etc
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim'
" Plug 'deoplete-plugins/deoplete-zsh'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

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
Plug 'vimwiki/vimwiki'         " personal wiki
Plug 'KabbAmine/vCoolor.vim'   " color picker
Plug 'godlygeek/tabular'       " text filtering and alignment
Plug 'plasticboy/vim-markdown' " syntax highlighting, matching rules and mappings
Plug 'tpope/vim-eunuch'        " helpers for unix
Plug 'tpope/vim-unimpaired'    " bracket mappings
Plug 'lambdalisue/suda.vim'    " sudo helper
" Plug 'chrisbra/Recover.vim'    " show diff, when recovering a buffer
Plug 'jamessan/vim-gnupg'      " edit gpg encrypted files
Plug 'mattn/webapi-vim'        " interface to Web API (for gist-vim)
Plug 'mattn/gist-vim'          " create gists
Plug 'will133/vim-dirdiff'     " diff directories
Plug 'junegunn/fzf.vim'
Plug 'vifm/vifm.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'cespare/vim-toml'

" Themes
Plug 'morhetz/gruvbox'

call plug#end()

" }}}
"=====================================================================
" SETTINGS {{{
"=====================================================================

filetype plugin indent on
syntax on

set nocompatible
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,default,iso8859-9,latin1
set number relativenumber
" set signcolumn=yes            " always show sign column
set completeopt+=noinsert,noselect
set guioptions=a
set mouse=a
set clipboard=unnamed,unnamedplus
set hlsearch                  " keep matches highlighted after searching
set ignorecase                " ignore case when searching
set smartcase                 " don't ignore case if user types an uppercase letter
set scrolloff=5               " keep a minimum of 5 lines between cursor and top/bottom of screen
set inccommand=nosplit        " when typing a :%s/foo/bar/g command, show live preview
set title                     " set and update terminal title
set cursorline                " highlight the current cursor line
set noshowmode                " disable native mode display (use airline instead)
set showmatch                 " highlight matching parens/brackets/etc
set matchtime=2               " show matching parens/brackets for 200ms
set splitbelow splitright     " splits open at the bottom and right
set foldmethod=marker         " use markers to specify folds
set foldlevel=1
set breakindent               " visually indent wrapped line
set shortmess+=ITc
set undofile                  " save undo history to a file
set undodir=~/.cache/vim/undo " set undo directory

" set list
set listchars=tab:│·,trail:·,nbsp:·
set listchars+=precedes:‹,extends:›

" Theme -- Do not set in TTY
if !empty($DISPLAY)
  set termguicolors
  let g:gruvbox_italic=1
  let g:gruvbox_contrast_dark='hard'
  colorscheme gruvbox
  set background=dark
endif

" }}}
"=====================================================================
" MAPPINGS {{{
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
nnoremap <silent> <leader>s  :new<CR>
nnoremap <silent> <leader>Ss :split<CR>
nnoremap <silent> <leader>v  :vnew<CR>
nnoremap <silent> <leader>Vv :vsplit<CR>

" resize splits left/right
noremap <M-[> <C-w>3<
noremap <M-]> <C-w>3>

" resize splits up/down
noremap <M-{> <C-w>3-
noremap <M-}> <C-w>3+

" Open/close tabs
noremap <silent> <M-Cr> :tabnew<CR>
noremap <silent> <M-Backspace> :tabclose<CR>

" Navigate left/right through tabs
noremap <silent> <M-,> :tabn<CR>
noremap <silent> <M-;> :tabp<CR>

" Rearrange tabs
noremap <silent> <M->> :+tabm<CR>
noremap <silent> <M-<> :-tabm<CR>

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

" Autocompletion
" imap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Remove all trailing whitespace
nnoremap <silent> <F4> :let _s=@/ \| :%s/\s\+$//e \| :let @/=_s \| :nohl \| :unlet _s <CR>

" Reload file with ISO 8859-9 encoding
nnoremap <F12> :e ++enc=iso8859-9<CR>

" Quit active
nnoremap <silent> Q :lclose \| pclose \| confirm q<CR>

" Quit all, bring up a prompt when buffers have been changed
nnoremap ZQ :confirm qall<CR>

" Clear search highlight and command-line on Esc
nnoremap <silent> <esc> :noh \| echo ""<CR>

" Make j and k treat wrapped lines as independent lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Toggle line wrapping
nnoremap <silent> <leader>W :setlocal wrap!<CR>:setlocal wrap?<CR>

" Toggle colorcolumn-listchars
nnoremap <silent> <leader>CC :call ToggleColorColumn()<CR>

" Toggle paste mode
noremap <silent> <F2> :set paste! nopaste?<CR>

" Enter command mode with substitution command prefilled
nnoremap <M-s> :%s///gc<Left><Left><Left><Left>

" Toggle conceal(level|cursor)
nnoremap <silent> <leader>cl :exe "set cole=" . (&cole == "0" ? "2" : "0") \| set cole<CR>
nnoremap <silent> <leader>cc :exe "set cocu=" . (&cocu == "" ? "n" : "") \| set cocu<CR>

" Toggle between tabs and spaces
nnoremap <silent> <F9> mz:call ToggleTab()<CR>'z

" Append modeline after last line in buffer
nnoremap <silent> <leader>ml :call AppendModeline()<CR>

" Indent visual selection without clearing selection
vmap > >gv
vmap < <gv

" Duplicate line downwards/upwards [ ! CONFLICT: vim-move ]
" nnoremap <C-M-j> "dY"dp
" nnoremap <C-M-k> "dY"dPj

" Duplicate selection downwards/upwards [ ! CONFLICT: vim-move ]
" vnoremap <C-M-j> "dy`>"dpgv
" vnoremap <C-M-k> "dy`<"dPjgv

" Yank path of current file to system clipboard
nnoremap <silent> <leader>yp :let @+ = expand("%:p")<CR>:echom "Copied " . @+<CR>

" Quickly edit a macro
" See: https://github.com/mhinz/vim-galore#quickly-edit-your-macros
nnoremap <leader>m :<C-u><C-r><C-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-f><left>

" Force redraw
" See: https://github.com/mhinz/vim-galore#saner-ctrl-l
nnoremap <leader>l :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>

" Reload vim configuration
nnoremap <silent> <leader>R :so ~/.config/nvim/init.vim \| echom 'Reload config.'<CR>

" Goto file under cursor in new tab
noremap gF <C-w>gf

" Ignore my lazy shift finger
cnoreabbrev WQ wq
cnoreabbrev Wq wq
cnoreabbrev Q q
cnoreabbrev X x

" emacs-style movements in command mode
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Delete>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
cnoremap <C-g> <C-c>

" Make <C-n> and <C-p> behave like up/down arrows
cnoremap <expr> <C-p> pumvisible() ? "\<C-p>" : "\<up>"
cnoremap <expr> <C-n> pumvisible() ? "\<C-n>" : "\<down>"

" Ctrl-Backspace to remove last word
inoremap <C-h> <C-w>
cnoremap <C-h> <C-w>

" Check file in shellcheck:
map <leader>cs :!clear && shellcheck -x %<CR>

" Open bibliography file in split
map <leader>bi :vsp<space>$BIB<CR>
map <leader>re :vsp<space>$REFER<CR>

" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>C :w! \| !compiler <C-r>%<CR>

" Open corresponding .pdf/.html or preview
map <leader>op :!opout <C-r>%<CR><CR>

" Spell-check
map <leader>or :setlocal spell! spelllang=en_us<CR>

" Disable C-c warning
map <C-c> <Nop>

" trq fixes
map ı i
map İ I
map ş ;
map Ş :
map ö ,
map Ö <
map ç .
map Ç >
map ğ [
map Ğ {
map ü ]
map Ü }

" }}}
"=====================================================================
" PLUGIN SETTINGS {{{
"=====================================================================

"=== Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#fnamemod = ':t:.'
let g:airline#extensions#whitespace#trailing_format = 'Tr·[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'MI:L[%s]'
let g:airline#extensions#whitespace#mixed_indent_file_format = 'MI:F[%s]'
let g:airline_powerline_fonts=1
let g:airline_theme='gruvbox'

"=== Deoplete
let g:deoplete#enable_at_startup = 1

"=== Ale
let g:ale_linters = {
  \ 'c':          ['clangd'],
  \ 'cpp':        ['clangd'],
  \ 'javascript': ['eslint'],
  \ 'python':     ['pylint'],
  \ 'vim':        ['vint'],
  \ }

let g:ale_fixers = {
  \ 'bash':       ['shfmt'],
  \ 'sh':         ['shfmt'],
  \ 'c':          ['clang-format'],
  \ 'cpp':        ['clang-format'],
  \ 'javascript': ['eslint'],
  \ 'python':     ['yapf', 'isort'],
  \ }

let g:ale_sign_error = '✖'
let g:ale_sign_warning = ''
let g:ale_sign_info = 'ℹ'
let g:ale_sign_style_error = '✖'
let g:ale_sign_style_warning = ''

let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_fix_on_save = 0

" shfmt options:
"  -kp: keep column alignment paddings
"  -bn: binary ops like && and | may start a line
"  -sr: redirect operators will be followed by a space
let g:ale_sh_shfmt_options = '-kp -bn -sr'

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
  \ 'python':         ['pyls'],
  \ 'vim':            ['vim-language-server', '--stdio'],
  \ }

" Let ALE handle linting
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_diagnosticsList = 'Disabled'

nnoremap <silent> <leader>k :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gD :call LanguageClient#textDocument_definition({"gotoCmd": "tabedit"})<CR>
nnoremap <silent> <leader>gr :call LanguageClient#textDocument_rename()<CR>

"=== UltiSnips
let g:UltiSnipsExpandTrigger       = '<C-k>'
let g:UltiSnipsJumpForwardTrigger  = '<C-k>'
let g:UltiSnipsJumpBackwardTrigger = '<C-p>'

let g:UltiSnipsEditSplit = 'vertical'

map <silent> <leader>Sn :UltiSnipsEdit<CR>

"=== Editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

"=== Fugitive
nnoremap <leader>gb :G blame<CR>
vnoremap <leader>gb :G blame<CR>
nnoremap <leader>ds :Gvdiffsplit<CR>

"=== FZF
nnoremap <M-h> :History<CR>

"=== GitGutter
if &diff
  let g:gitgutter_enabled = 0
endif

"=== MarkdownPreview
let g:mkdp_refresh_slow = 1
nmap <leader>mp <Plug>MarkdownPreviewToggle

"=== Gist-Vim
let g:gist_token_file = '~/data/backup/secrets/gist_token'
let g:gist_post_private = 1

"=== Goyo plugin makes text more readable when writing prose:
map <leader>f :Goyo \| set linebreak<CR>

"=== DirDiff
let g:DirDiffWindowSize = 10
let g:DirDiffExcludes = '.*.swp,.git'
" ignore spaces
" let g:DirDiffAddArgs = "-w"

"=== Suda
cnoremap W!! <bar> :w suda://%<CR>
cnoremap WQ!! <bar> :wq suda://%<CR>
cnoremap R!! <bar> :r suda://%<CR>
cnoremap E!! <bar> :e suda://%<CR>

"=== TComment
call tcomment#type#Define('go', tcomment#GetLineC('// %s'))
call tcomment#type#Define('go_block', g:tcomment#block_fmt_c)
call tcomment#type#Define('go_inline', g:tcomment#inline_fmt_c)

"=== Undo tree
nnoremap <F5> :UndotreeToggle<CR>
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 6

"=== Vim-move
let g:move_key_modifier = 'C-M'

"=== VimWiki
let g:vimwiki_ext2syntax = {
  \ '.Rmd': 'markdown', '.rmd': 'markdown', '.md': 'markdown',
  \ '.markdown': 'markdown', '.mdown': 'markdown'
  \ }
let g:vimwiki_list = [
  \ {'path': '~/notes', 'syntax': 'markdown', 'ext': '.md'}
  \ ]

"=== VCoolor
nmap <silent> <leader>co :VCoolor<CR>
let g:vcoolor_disable_mappings = 1

"=== Vifm
let g:vifm_exec = 'VIFM=~/.config/vifm/sessions/select vifm'
map <leader>n :Vifm<CR>
map <leader>N :TabVifm<CR>

" Disable loading netrw
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
" Replace netrw with Vifm
let g:vifm_replace_netrw = 1

"=== Hexokinase
nmap <silent> <leader>ch :HexokinaseToggle<CR>
let g:Hexokinase_ftEnabled = ['css', 'html', 'scss', 'javascript.jsx']
let g:Hexokinase_highlighters = ['backgroundfull']

" }}}
"=====================================================================
" FUNCTIONS {{{
"=====================================================================

" Open help in full-window view (empty buffer OR new tab)
function! HelpTab(...)
  let cmd = 'tab help %s'
  if bufname('%') ==# '' && getline(1) ==# ''
    let cmd = 'help %s | only'
  endif
  exec printf(cmd, join(a:000, ' '))
endfunction

command! -nargs=* -complete=help H call HelpTab(<q-args>)

" Open or create a tab at the given tab index
function! Tabnm(n)
  try
    exec 'tabn ' . a:n
  catch
    $tabnew
  endtry
endfunction

function! ToggleColorColumn()
  if &colorcolumn
    set colorcolumn= | set nolist
  else
    set colorcolumn=80 | set list
  endif
endfunction

" Toggle between tabs and spaces
let my_tab=4
function! ToggleTab()
  if &expandtab
    set shiftwidth=8 softtabstop=0 noexpandtab
    echom 'Using TABs to insert a <Tab>'
  else
    exe 'set shiftwidth='.g:my_tab
    exe 'set softtabstop='.g:my_tab
    set expandtab
    echom 'Using'g:my_tab'SPACEs to insert a <Tab>'
  endif
endfunction

" Append modeline after last line in buffer
function! AppendModeline()
  let l:modeline = printf(' vim: set ts=%d sw=%d tw=%d %set :',
    \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
  call append(line('$'), l:modeline)
endfunction

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
  \ | wincmd p | diffthis

" }}}
"=====================================================================
" AUTOCMD {{{
"=====================================================================

augroup vimrc
  " Suppress readonly warning
  au BufEnter /etc/*,/usr/* set noro

  " Ensure files are read as what I want:
  au BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
  au BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
  au BufRead,BufNewFile *.tex set filetype=tex
  au BufRead,BufNewFile *.rasi set filetype=css
  au BufRead,BufNewFile /tmp/zsh* set filetype=bash

  " Enable Goyo by default for mutt writting
  au BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
  au BufRead,BufNewFile /tmp/neomutt* :Goyo
  au BufRead,BufNewFile /tmp/neomutt* map Q :Goyo\|:confirm qall<CR>
  au BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
  au BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

  " Indent rules for specific filetypes
  " au FileType text,html,css,scss,javascript.jsx,yaml,toml,xml,markdown,vimwiki
  "   \ set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

  " Disable automatic commenting on newline
  au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

  " Enable spell-check for gitcommit; set textwidth to 72
  au Filetype gitcommit setlocal spell | setlocal tw=72

  " Disable folding for some files
  au Filetype gitcommit,vimwiki setlocal nofoldenable

  " Automatically deletes all trailing whitespace on save.
  " au BufWritePre * %s/\s\+$//e

  " Equalize diff splits as the window size changes
  if exists('##VimResized')
    if &diff
      au VimResized * wincmd =
    endif
  endif

  " Run command whenever these files are updated.
  au BufWritePost *Xresources,*Xdefaults,~/.config/X11/colors/* !xrdb %
  au BufWritePost ~/.config/fontconfig/* !fc-cache
  au BufWritePost *sxhkdrc !pkill -USR1 sxhkd

  " Runs a script that cleans out tex build files whenever I close out of a .tex file.
  au VimLeave *.tex !texclear %
augroup END

" }}}
"=====================================================================
