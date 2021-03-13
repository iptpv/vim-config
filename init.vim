filetype off

"Plug
call plug#begin('~/.vim/plugged')

"colors
Plug 'bling/vim-airline'
Plug 'notpratheek/vim-luna'

"commenting
Plug 'scrooloose/nerdcommenter'

"completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"linting
Plug 'w0rp/ale'

"navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"go to file by import
Plug 'Galooshi/vim-import-js'

"highliting
Plug 'sheerun/vim-polyglot'

"git
Plug 'chrisbra/vim-diff-enhanced'

call plug#end()

"Editor config
filetype plugin indent on
syntax enable
set nonumber
set undofile
set undodir=/tmp
set encoding=utf-8
set wildmenu
set title
set showcmd
set scrolloff=999
set wrap
set colorcolumn=120
set textwidth=120
set formatoptions-=o
set linebreak
set autoindent
set smartindent
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set linespace=1
set cursorline
set t_Co=256
set shortmess+=I
set hidden
set laststatus=2
set visualbell
set incsearch
set hlsearch
set ignorecase
set smartcase
set gdefault
set backspace=indent,eol,start
set noswapfile
set viminfo='10,\"100,:20,%,n~/.viminfo
set history=1000
set autoread
set clipboard=unnamed


"Plugs configs
colorscheme luna-term

"airline
let g:airline#extensions#tabline#enabled = 1

"ale
let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }
let g:ale_fix_on_save = 1


"Functions
"toggle mouse support
set mouse=
  function! ToggleMouse()
    if &mouse == 'a'
      set mouse=
      echo "Mouse usage disabled"
    else
      set mouse=a
      echo "Mouse usage enabled"
    endif
  endfunction
function! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction


"save last cursor position
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
"automatically clean trailing whitespaces on save
autocmd BufWritePre *.* :call <SID>StripTrailingWhitespaces()

"Hotkeys
let mapleader = ","

"toggle mouse support
nnoremap <leader>m :call ToggleMouse()<CR>

vnoremap < <gv
vnoremap > >gv
nnoremap Y y$

map <leader>e :NERDTreeToggle<CR>

"fzf - fuzzy finder
nmap <leader>p :FZF<CR>

"buffers
map <leader>n :bn<CR>
map <leader>p :bp<CR>
map <leader>x :bd<CR>

"save file with sudo
command! W exec 'w !sudo tee % > /dmu/null' | e!

"navigation mapping
nmap <Space> <PageDown>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

"shortcut for :%s//
nnoremap <leader>s :%s/<C-r><C-w>//<left>
vnoremap <leader>s :s//<left>

"create a new window
nmap <leader><left>  :leftabove  vnew<CR>
nmap <leader><right> :rightbelow vnew<CR>
nmap <leader><up>    :leftabove  new<CR>
nmap <leader><down>  :rightbelow new<CR>
nmap <leader>f :Rg<CR>
nmap <leader>r :cfdo %s/<C-r>///g<left><left>

" started In Diff-Mode set diffexpr (plugin not loaded yet)
if &diff
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif

" completion by <TAB>
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
