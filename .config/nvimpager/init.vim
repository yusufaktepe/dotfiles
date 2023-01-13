if ! filereadable(expand('~/.config/nvimpager/colors/nord.vim'))
  silent !mkdir -p ~/.config/nvimpager/colors
  silent !curl "https://raw.githubusercontent.com/arcticicestudio/nord-vim/main/colors/nord.vim" > ~/.config/nvimpager/colors/nord.vim
endif

set shada='100,/50,h,n~/.local/state/nvim/shada/nvimpager.shada
set clipboard=unnamed,unnamedplus
set ignorecase
set smartcase
set mouse=

" set termguicolors
colorscheme nord
highlight manBold      gui=bold cterm=bold guifg=#BF616A ctermfg=1
highlight manUnderline gui=bold cterm=bold guifg=#A3BE8C ctermfg=2

nnoremap <silent> Q :quit<CR>
nnoremap <silent> <esc> :noh \| echo ""<CR>
nnoremap '. '0

