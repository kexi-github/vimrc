"source $VIMRUNTIME/vimrc_example.vim

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"*******************************配置1**************************************"
"解决vim提示信息乱码
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8
set encoding=cp936 "set encoding=utf-8

filetype on 
set buftype=
set noundofile "关闭自动备份
set nobackup
set noswapfile " 不生成交换文件
set wildmenu " 自动补全的时候，将补全内容使用一个漂亮的单行菜单形式显示出来。
set clipboard+=unnamed "共享剪贴板  

set smartindent   "设置智能缩进
set shortmess=atI "去掉欢迎界面
set clipboard+=unnamed " 与windows共享剪贴板
"colorscheme slate          "sublime的配色方案
set guifont=Courier_New:h12      "字体与字号
set tabstop=4                " 设置tab键的宽度
set shiftwidth=2             " 换行时行间交错使用4个空格
set autoindent               " 自动对齐
set backspace=2              " 设置退格键可用
set cindent shiftwidth=2     " 自动缩进4空格
set smartindent              " 智能自动缩进
set ai!                      " 设置自动缩进
set nu!                      " 显示行号
set mouse=a                  " 启用鼠标
set ruler                    " 右下角显示光标位置的状态行
set incsearch                " 查找book时，当输入/b时会自动找到
set hlsearch                 " 开启高亮显示结果
set incsearch                " 开启实时搜索功能
set nowrapscan               " 搜索到文件两端时不重新搜索
set nocompatible             " 关闭兼容模式
set vb t_vb=                 " 关闭提示音
au GuiEnter * set t_vb=      " 关闭闪屏
set hidden                   " 允许在有未保存的修改时切换缓冲区
set list                     " 显示Tab符，使用一高亮竖线代替
set listchars=tab:\|\ ,
syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype plugin indent on    " 启用自动补全

"*******************************配置1**************************************"

"*******************************配置2**************************************"

" ctags设置
set autochdir "自动切换目录
set tags=tags; "自动查找

"将 vendor 里的第三方库文件的 tags 文件单独存到 tags.vendor 文件里，
"而每次保存文件的时候只用执行 !ctags src 就行,vendor 生成的 tags 文件变化少，
"在安装了新的库之后执行一次 ctags -f tags.vendor vendor 就行了
"set tags+=tags.vendor   "ctags -f tags.vendor vendor
"autocmd BufWritePost *.php silent execute "![ -d src ] && ctags src"

" 为自己的代码目录生成tags方法与楼主为库文件生成代码的步骤相同
"1. 一般来说可以把库文件生成的tags复制到自己的tags目录下，如果为多个库生成了tags, 可以保存为不同的文件名比如stdc.tags posix.tags, 然后在_vimrc里设置。设置的例子：
"set tags=~/vimfiles/posix.tags,~/vimfiles/stdc.tags,tags
"2. 在自己的代码目录下执行同样的命令ctags   -R   --c++-kinds=+p   --fields=+iaS   --extra=+q-R: 循环生成子目录的 tags

"*: 当前目录下的所有文件，不递归
"–c++-kinds=+px : 记录 c++ 文件中的函数声明和各种外部和前向声明
"–fields=+iaS : ctags 要求描述的信息，其中i表示如果有继承，则标识出父类；a 表示如果元素是类成员的话，要标明其调用权限（即是 public 还是 private）；S 表示如果是函数，则标识函数的 signature。
"–extra=+q: 强制要求ctags做如下操作—如果某个语法元素是类的一个成员，ctags默认会给其记录一行，可以要求ctags对同一个语法元素再记一行，这样可以保证在VIM中多个同名函数可以通过路径不同来区分。

"*******************************配置2**************************************"

"*******************************配置3**************************************"

func! CompileCode()
exec "w"
if &filetype == "c"
exec "!gcc %<.c "
elseif &filetype == "cpp"
exec "!gcc %<.cpp "
elseif &filetype == "python"
exec "!python %<.py"
endif
endfunc

" 运行可执行文件
func! RunCode()
exec "w"
if &filetype == "c" || &filetype == "cpp" || &filetype == "haskell"
exec "!gcc %<.c"
elseif &filetype == "python"
exec "!python %<.py"
endif
endfunc

" Ctrl + C 一键保存、编译
map <c-c> :call CompileCode()<CR>
imap <c-c> <ESC>:call CompileCode()<CR>
vmap <c-c> <ESC>:call CompileCode()<CR>

" Ctrl + R 一键保存、运行
map <c-r> :call RunCode()<CR>
imap <c-r> <ESC>:call RunCode()<CR>
vmap <c-r> <ESC>:call RunCode()<CR>

"*******************************配置3**************************************"

"*******************************配置4**************************************"

autocmd! bufwritepost _vimrc source %     "vimrc文件修改之后自动加载。 windows。
autocmd! bufwritepost .vimrc source %     "vimrc文件修改之后自动加载。 linux。

" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\

" netrw文件浏览器 
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20
set autochdir

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

" 打开文件位置
function OpenFileLocation()  
    if ( expand("%") != "" )  
        execute "!start explorer /select, %"   
    else  
        execute "!start explorer /select, %:p:h"  
    endif  
endfunction  
map gl <ESC>:call OpenFileLocation()<CR>  

"*******************************配置4**************************************"

"*******************************配置5**************************************"

" 设置 leader 键，例子为空号键，也可以设置为其他的
let mapleader=" "

" LeaderF config
let g:Lf_ReverseOrder = 1
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_RootMarkers = ['.project', '.root', '.svn' , '.hg' , '.git']

"文件搜索
nnoremap <silent> <Leader>p :LeaderfFile<CR> 
"历史打开过的文件
nnoremap <silent> <Leader>u :LeaderfMru<CR> 
"Buffer
nnoremap <silent> <Leader>b :LeaderfBuffer<CR> 
"函数搜索（仅当前文件里）
nnoremap <silent> <Leader>f :LeaderfFunction!<CR> 
"模糊搜索，很强大的功能，迅速秒搜
nnoremap <silent> <Leader>r :Leaderf rg<CR> 

"排除搜索目录设置
"let g:Lf_WildIgnore = {
"            \ 'dir': ['.svn','.git','.hg','.vscode','.wine','.deepinwine','.oh-my-zsh'],
"            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.c']
"            \}

let g:neocomplete#enable_at_startup = 1

"*******************************配置5**************************************"

"*******************************配置6**************************************"

" neocomplete 插件配置 关键字补全、文件路径补全、tag补全
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=python3complete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType c setlocal omnifunc=ccomplete#Complete


"filetype plugin on  “启用filetype插件
let g:pydiction_location = 'D:\Program Files (x86)\Vim\vimfiles\ftplugin\pydiction\complete-dict' 
"let g:pydiction_menu_height = 20 ”设置弹出菜单的高度，默认是15

"*******************************配置6**************************************"
