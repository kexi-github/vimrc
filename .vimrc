call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'junegunn/vim-easy-align'
" Plugin options


call plug#end()

"颜色主题设置

set t_Co=256

let g:solarized_termcolors=16

"emmet 设置

let g:user_emmet_expandabbr_key = '<C-Y>'
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {"lang":"zh-cn"}

"Gist设置

let g:gist_detect_filetype = 1

let g:gist_clip_command = 'xclip -selection clipboard'
"javascript
let b:javascript_fold=1
let javascript_enable_domhtmlcss=1

autocmd FileType javascript set dictionary=~/.vim/my/extend/javascript.dict
autocmd FileType html set dictionary=~/.vim/my/extend/html.dict

"查找手册
autocmd FileType php set keywordprg=~/.vim/my/extend/phpman

autocmd FileType javascript,html set keywordprg=~/.vim/my/extend/man

autocmd FileType css set keywordprg=~/.vim/my/extend/cssman

inoremap <C-D> <ESC>:call PhpDocSingle()<CR>i 
nnoremap <C-D> :call PhpDocSingle()<CR> 
vnoremap <C-D> :call PhpDocRange()<CR> 

map <F2> <S-K><CR>

map! <F2> <C-O><S-K><CR>


map <F6> :! tab vim<CR><CR>
map! <F6> <Esc>:! tab vim<CR><CR>

"删除不剪切, rd

nnoremap r "_d
vnoremap r "_d

"快速生成tag文件

map <F3> :! ctags -R<CR>

map! <F3> <Esc>:! ctags -R<CR>

"快捷键设置

map <F11> :NERDTreeToggle<CR>

map! <F11> <Esc>:NERDTreeToggle<CR>

map <F12> :TagbarToggle<CR>

map! <F12> <Esc>:TagbarToggle<CR>

"快速查找文件

"map <C-P> :CommandT<CR>
"map! <C-P> <Esc>:w<CR>:CommandT<CR>

"文件新tab页打开, CommandT插件配置
let g:CommandTAcceptSelectionMap = '<space>'
let g:CommandTAcceptSelectionTabMap = '<CR>'

" 用FZF 查找文件 
" 设置查找时排除的目录
:let $FZF_DEFAULT_COMMAND  = 'find . -type f ! -path "./node_modules/*" ! -path "./bower_components/*" ! -path "./.git/*" ! -path "*.swp"'
map <C-P> :tabnew<CR>:FZF<CR>
map!<C-P> <ESc>:w<CR> :tabnew<CR>:FZF<CR>

"快速对齐
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

"快速查找文函数

map <C-F> :FufTag<CR>

map! <C-F> <Esc>:w<CR>:FufTag<CR>

"快速关闭

map <S-Q> :qa<CR>

nnoremap <c-]> g<c-]>

vnoremap <c-]> g<c-]>

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

"双击时高亮

map <2-leftmouse> \m
inoremap <2-leftmouse> <Esc>\m

"ctrl+鼠标左键跳转

"--------------------
" Function: Open tag under cursor in new tab
" Source:   http://stackoverflow.com/questions/563616/vimctags-tips-and-tricks
"--------------------
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"--------------------
" Function: Remap keys to make it more similar to firefox tab functionality
" Purpose:  Because I am familiar with firefox tab functionality
" 切换tab页 用gt
"--------------------
map     <C-T>       :tabnew<CR>

map <A-LeftMouse> <C-]>

map! <A-LeftMouse> <Esc><C-]>

 

function! InsertTabWrapper()

let col=col('.')-1

if !col || getline('.')[col-1] !~ '\k'

return "\<TAB>"

else

return "\<C-x>\<C-o>"

endif

endfunction

"按tab键，全能提示，

"注意要用inoremap，不能用map！，如果用map！在命令模式下tab键没有提示功能。
"支持鼠标

set mouse=a


" 多行缩进

vnoremap <Tab> >

vnoremap <S-Tab> <

"语法高亮
syntax enable
syntax on
set autoindent
set number
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
"加快速度
"set synmaxcol=200
set ttyfast " u got a fast terminal
set ttyscroll=3
set lazyredraw " to avoid scrolling problems
set scrolljump=5
"删除键
set backspace=eol,start,indent

"基本设置

set encoding=utf-8

set fileencoding=utf-8

set fileencodings=ucs-bom,utf-8,chinese

set ambiwidth=double

set wrap "自动换行

"设置无备份

set nobackup

set nowritebackup

