
"Code highlighting
syntax on

"show line number
set number

"Higlight when you search for the word
set hlsearch

"folding code,you can use zc or zo
set foldmethod=manual

"keyboard setting
let mapleader=","

"save, use ,+w
inoremap <leader>w <Esc>:w<cr>

"Nerdtree
"open the folder and file's view,you can use ,+n
noremap <leader>n :NERDTreeToggle<CR>
"open the current file location in Nerdtree,you can use ,f
noremap <leader>f :NERDTreeFind<CR>
"show hidden files
let NERDTreeShowHidden=1
"Ingore files
let NERDTreeIgnore=[
			\'\.git$',
			\]

"easymotion
"quickly search files based on two characters,you can use ss
nmap ss <Plug>(easymotion-s2)

"insert mode to normal mode,you can use jj
inoremap jj <Esc>`^

"split screen,you can use ctrl+h/j/k/l
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

"Format JSON,use :FormatJSON
"undo,use :e!
com! FormatJSON %!python3 -m json.tool

"sudo option
cnoremap w!! w !sudo tee % >/dev/null

"""""""""""""""""""""
"      Plugins      "
"""""""""""""""""""""
call plug#begin('~/.vim/plugged')

"show recently edited files
Plug 'mhinz/vim-startify'

"MarkdownPreview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

"show your file's information
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"add indentation
Plug 'Yggdroot/indentLine'

"add hybrid colorscheme
Plug 'w0ng/vim-hybrid'
" Initialize plugin system

"folder and file's view
Plug 'scrooloose/nerdtree'

"search files quickly,you can try ctrl+p
Plug 'ctrlpvim/ctrlp.vim'

"move the current position quickly
Plug 'easymotion/vim-easymotion'

"quick edit similar to double quotes,you can try cs"' and ds' and ysiw"
Plug 'tpope/vim-surround'

"search files quickly,you can try :Files and :Ag(maybe you need to install the_silver_searcher)
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

"search and replace,you can try :Far A B
Plug 'brooth/far.vim'

"goland's plugin...
Plug 'fatih/vim-go'
call plug#end()


"set colorscheme
set background=dark
colorscheme hybrid

"MarkdownPreVie,you can use :MarkdownPreview
"If you want to use other browser,you need to add your browser'commond or
"delete the following configuration(it will use your default browser)
let g:mkdp_browser = 'google-chrome-stable'



