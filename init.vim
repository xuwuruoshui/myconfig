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
"Plug 'w0ng/vim-hybrid'
"One Dark主题
Plug 'joshdick/onedark.vim'
" Initialize plugin system


"folder and file's view
Plug 'scrooloose/nerdtree'
"注释
Plug 'preservim/nerdcommenter'
"nerdtree图标
Plug 'ryanoasis/vim-devicons'
"git notification
Plug 'xuyuanp/nerdtree-git-plugin'
"nerd sytax on
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"one nerd
Plug 'jistr/vim-nerdtree-tabs'

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

"Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"Python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

"easy to read code,you need to 'pacman ctags' lib
"Plug 'majutsushi/tagbar'

"show that you want to syntax on the  word
Plug 'lfv89/vim-interestingwords'

"Code completion
"if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
"  Plug 'Shougo/deoplete.nvim'
"  Plug 'roxma/nvim-yarp'
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif

" format code
"Plug 'sbdchd/neoformat'

"add note
"Plug 'tpope/vim-commentary'

"integrate with git
"Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
"Plug 'junegunn/gv.vim'

"Vue
"Plug  'posva/vim-vue'

call plug#end()


"""""""""""""""""""
""""Format Font""""
"""""""""""""""""""

"Code highlighting
syntax on

"show line number
set number

"Higlight when you search for the word
set hlsearch

"folding code,you can use zc or zo
set foldmethod=manual

"配置主题
"set background=dark
colorscheme onedark

"set unix
set ff=unix

"table 4
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set autoindent
set textwidth=80

""""""""""""""""""""""""
""""Keyboard Setting""""
""""""""""""""""""""""""
let mapleader=","
let maplocalleader=","


"保存
inoremap <leader>w <Esc>:w<cr>

"切换为Normal模式
inoremap jj <Esc>

"粘贴/赋值
"vim和系统复制粘贴不能统一，就下载xclip
set clipboard=unnamedplus
" linux下
noremap <leader>c "+y
noremap <leader>v "+p
" windows的wsl下
" paste.exe下载地址,https://www.c3scripts.com/tutorials/msdos/paste.zip
" noremap <leader>c :!/mnt/c/Windows/System32/clip.exe<cr>u
" noremap <leader>v :read !/mnt/c/Windows/System32/paste.exe <cr>i<bs><esc>l
" noremap! <leader>v <esc>:read !/mnt/c/Windows/System32/paste.exe <cr>i<bs><esc>l


"删除
inoremap <c-d> <Esc>ddi

"查找
nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>
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


"email
iabbrev @@ 1085252985@qq.com
iabbrev ssig --<cr>name: xuwuruoshui<cr>email: 1085252985@qq.com

"""""""""
"autocmd"
"""""""""
" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}


onoremap in( :<c-u>normal! f(vi(<cr>
onoremap in) :<c-u>normal! f)vi)<cr>
onoremap in< :<c-u>normal! f<vi<<cr>
onoremap in> :<c-u>normal! f>vi><cr>
onoremap in' :<c-u>normal! f'vi'<cr>
onoremap in" :<c-u>normal! f"vi"<cr>
onoremap in` :<c-u>normal! f`vi`<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap in} :<c-u>normal! f}vi}<cr>
onoremap in[ :<c-u>normal! f[vi[<cr>
onoremap in] :<c-u>normal! f]vi]<cr>




""""""""""""""""""""
"""Plugin Setting"""
""""""""""""""""""""
" Markdown Preview
"let g:mkdp_browser = 'google-chrome-stable'


" Nerdtree
" auto open nerdtree
"autocmd vimenter * NERDTree
"open the folder and file's view,you can use ,+n
noremap <leader>n :NERDTreeToggle<CR>
"open the current file location in Nerdtree,you can use ,f
noremap <leader>f :NERDTreeFind<CR>
"show hidden files
let NERDTreeShowHidden=1
"window size
let NERDTreeWinSize=20
"Ingore files
let NERDTreeIgnore=[
			\'\.git$',
			\]

" easymotion
"quickly search files based on two characters,you can use ss
nmap ss <Plug>(easymotion-s2)



