set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" to fold methods and classes
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
" auto completion
" installation instructions @ https://github.com/ycm-core/YouCompleteMe#installation
Bundle 'Valloric/YouCompleteMe'
" syntax checking/highlighting
Plugin 'vim-syntastic/syntastic'
" PEP 8 checking
Plugin 'nvie/vim-flake8'
" color scheme
Plugin 'jnurmine/Zenburn'
" file system browser
Plugin 'scrooloose/nerdtree'
" for searching anything on VIM
Plugin 'kien/ctrlp.vim'
" for git
Plugin 'tpope/vim-fugitive'
" rainbow brackets
Plugin 'frazrepo/vim-rainbow'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" Indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |

"define BadWhitespace before using in a match
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
"copied from here -> https://dev.to/sansyrox/vim-python-virtualenv-a-plugin-to-manage-virtual-environments-in-python-54c
python3 << EOF
import os
import subprocess

if "VIRTUAL_ENV" in os.environ:
    project_base_dir = os.environ["VIRTUAL_ENV"]
    script = os.path.join(project_base_dir, "bin/activate")
    pipe = subprocess.Popen(". %s; env" % script, stdout=subprocess.PIPE, shell=True)
    output = pipe.communicate()[0].decode('utf8').splitlines()
    env = dict((line.split("=", 1) for line in output))
    os.environ.update(env)

EOF

let python_highlight_all=1
syntax on
set nu

" nerd tree settings
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Rainbow bracket settings
let g:rainbow_active = 1

" powerline
" powerline was installed globally using pip
set rtp+=/Users/Govind/opt/anaconda3/lib/python3.8/site-packages/powerline/bindings/vim
set laststatus=2
set t_Co=256

set clipboard=unnamed

