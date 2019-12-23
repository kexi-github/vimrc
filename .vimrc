"语法高亮
syntax enable
syntax on
set autoindent
set number
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

"基本设置
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese
set ambiwidth=double
set wrap "自动换行

"设置无备份
set nobackup
set nowritebackup

"设置vim-plug
call plug#begin('~/.vim/plugged')

" add plug github

" Make sure you use single quotes
Plug 'junegunn/vim-easy-align'
" Plugin options


call plug#end()

"颜色主题设置

set t_Co=256

let g:solarized_termcolors=16

"Gist设置

let g:gist_detect_filetype = 1
let g:gist_clip_command = 'xclip -selection clipboard'
"javascript
let b:javascript_fold=1
let javascript_enable_domhtmlcss=1

autocmd FileType javascript set dictionary=~/.vim/my/extend/javascript.dict
autocmd FileType html set dictionary=~/.vim/my/extend/html.dict

"删除不剪切, rd

nnoremap r "_d
vnoremap r "_d

"快速生成tag文件

map <F3> :! ctags -R<CR>

map! <F3> <Esc>:! ctags -R<CR>

"映射复制、粘贴、剪贴ctrl+c ctrl+v ctrl+x

map <C-V> "+pa<Esc>

map! <C-V> <Esc>"+pa

map <C-C> "+y

map <C-X> "+x

" 映射全选 ctrl+a

map <C-A> ggVG

map! <C-A> <Esc>ggVG

"ctrl+s为保存

map <C-S> :w<CR>
inoremap <C-S> <C-O>:w<CR>

"ctrl+z撤销

map <C-Z> :u<CR>

map! <C-Z> <C-O>:u<CR>
