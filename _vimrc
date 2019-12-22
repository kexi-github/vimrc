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

"*******************************����1**************************************"
"���vim��ʾ��Ϣ����
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8
set encoding=cp936 "set encoding=utf-8

filetype on 
set buftype=
set noundofile "�ر��Զ�����
set nobackup
set noswapfile " �����ɽ����ļ�
set wildmenu " �Զ���ȫ��ʱ�򣬽���ȫ����ʹ��һ��Ư���ĵ��в˵���ʽ��ʾ������
set clipboard+=unnamed "���������  

set smartindent   "������������
set shortmess=atI "ȥ����ӭ����
set clipboard+=unnamed " ��windows���������
"colorscheme slate          "sublime����ɫ����
set guifont=Courier_New:h12      "�������ֺ�
set tabstop=4                " ����tab���Ŀ��
set shiftwidth=2             " ����ʱ�м佻��ʹ��4���ո�
set autoindent               " �Զ�����
set backspace=2              " �����˸������
set cindent shiftwidth=2     " �Զ�����4�ո�
set smartindent              " �����Զ�����
set ai!                      " �����Զ�����
set nu!                      " ��ʾ�к�
set mouse=a                  " �������
set ruler                    " ���½���ʾ���λ�õ�״̬��
set incsearch                " ����bookʱ��������/bʱ���Զ��ҵ�
set hlsearch                 " ����������ʾ���
set incsearch                " ����ʵʱ��������
set nowrapscan               " �������ļ�����ʱ����������
set nocompatible             " �رռ���ģʽ
set vb t_vb=                 " �ر���ʾ��
au GuiEnter * set t_vb=      " �ر�����
set hidden                   " ��������δ������޸�ʱ�л�������
set list                     " ��ʾTab����ʹ��һ�������ߴ���
set listchars=tab:\|\ ,
syntax enable                " ���﷨����
syntax on                    " �����ļ��������
filetype indent on           " ��Բ�ͬ���ļ����Ͳ��ò�ͬ��������ʽ
filetype plugin on           " ��Բ�ͬ���ļ����ͼ��ض�Ӧ�Ĳ��
filetype plugin indent on    " �����Զ���ȫ

"*******************************����1**************************************"

"*******************************����2**************************************"

" ctags����
set autochdir "�Զ��л�Ŀ¼
set tags=tags; "�Զ�����

"�� vendor ��ĵ��������ļ��� tags �ļ������浽 tags.vendor �ļ��
"��ÿ�α����ļ���ʱ��ֻ��ִ�� !ctags src ����,vendor ���ɵ� tags �ļ��仯�٣�
"�ڰ�װ���µĿ�֮��ִ��һ�� ctags -f tags.vendor vendor ������
"set tags+=tags.vendor   "ctags -f tags.vendor vendor
"autocmd BufWritePost *.php silent execute "![ -d src ] && ctags src"

" Ϊ�Լ��Ĵ���Ŀ¼����tags������¥��Ϊ���ļ����ɴ���Ĳ�����ͬ
"1. һ����˵���԰ѿ��ļ����ɵ�tags���Ƶ��Լ���tagsĿ¼�£����Ϊ�����������tags, ���Ա���Ϊ��ͬ���ļ�������stdc.tags posix.tags, Ȼ����_vimrc�����á����õ����ӣ�
"set tags=~/vimfiles/posix.tags,~/vimfiles/stdc.tags,tags
"2. ���Լ��Ĵ���Ŀ¼��ִ��ͬ��������ctags   -R   --c++-kinds=+p   --fields=+iaS   --extra=+q-R: ѭ��������Ŀ¼�� tags

"*: ��ǰĿ¼�µ������ļ������ݹ�
"�Cc++-kinds=+px : ��¼ c++ �ļ��еĺ��������͸����ⲿ��ǰ������
"�Cfields=+iaS : ctags Ҫ����������Ϣ������i��ʾ����м̳У����ʶ�����ࣻa ��ʾ���Ԫ�������Ա�Ļ���Ҫ���������Ȩ�ޣ����� public ���� private����S ��ʾ����Ǻ��������ʶ������ signature��
"�Cextra=+q: ǿ��Ҫ��ctags�����²��������ĳ���﷨Ԫ�������һ����Ա��ctagsĬ�ϻ�����¼һ�У�����Ҫ��ctags��ͬһ���﷨Ԫ���ټ�һ�У��������Ա�֤��VIM�ж��ͬ����������ͨ��·����ͬ�����֡�

"*******************************����2**************************************"

"*******************************����3**************************************"

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

" ���п�ִ���ļ�
func! RunCode()
exec "w"
if &filetype == "c" || &filetype == "cpp" || &filetype == "haskell"
exec "!gcc %<.c"
elseif &filetype == "python"
exec "!python %<.py"
endif
endfunc

" Ctrl + C һ�����桢����
map <c-c> :call CompileCode()<CR>
imap <c-c> <ESC>:call CompileCode()<CR>
vmap <c-c> <ESC>:call CompileCode()<CR>

" Ctrl + R һ�����桢����
map <c-r> :call RunCode()<CR>
imap <c-r> <ESC>:call RunCode()<CR>
vmap <c-r> <ESC>:call RunCode()<CR>

"*******************************����3**************************************"

"*******************************����4**************************************"

autocmd! bufwritepost _vimrc source %     "vimrc�ļ��޸�֮���Զ����ء� windows��
autocmd! bufwritepost .vimrc source %     "vimrc�ļ��޸�֮���Զ����ء� linux��

" �ڱ��ָ�Ĵ��ڼ���ʾ�հף������Ķ�
set fillchars=vert:\ ,stl:\ ,stlnc:\

" netrw�ļ������ 
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

" ���ļ�λ��
function OpenFileLocation()  
    if ( expand("%") != "" )  
        execute "!start explorer /select, %"   
    else  
        execute "!start explorer /select, %:p:h"  
    endif  
endfunction  
map gl <ESC>:call OpenFileLocation()<CR>  

"*******************************����4**************************************"

"*******************************����5**************************************"

" ���� leader ��������Ϊ�պż���Ҳ��������Ϊ������
let mapleader=" "

" LeaderF config
let g:Lf_ReverseOrder = 1
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_RootMarkers = ['.project', '.root', '.svn' , '.hg' , '.git']

"�ļ�����
nnoremap <silent> <Leader>p :LeaderfFile<CR> 
"��ʷ�򿪹����ļ�
nnoremap <silent> <Leader>u :LeaderfMru<CR> 
"Buffer
nnoremap <silent> <Leader>b :LeaderfBuffer<CR> 
"��������������ǰ�ļ��
nnoremap <silent> <Leader>f :LeaderfFunction!<CR> 
"ģ����������ǿ��Ĺ��ܣ�Ѹ������
nnoremap <silent> <Leader>r :Leaderf rg<CR> 

"�ų�����Ŀ¼����
"let g:Lf_WildIgnore = {
"            \ 'dir': ['.svn','.git','.hg','.vscode','.wine','.deepinwine','.oh-my-zsh'],
"            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.c']
"            \}

let g:neocomplete#enable_at_startup = 1

"*******************************����5**************************************"

"*******************************����6**************************************"

" neocomplete ������� �ؼ��ֲ�ȫ���ļ�·����ȫ��tag��ȫ
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


"filetype plugin on  ������filetype���
let g:pydiction_location = 'D:\Program Files (x86)\Vim\vimfiles\ftplugin\pydiction\complete-dict' 
"let g:pydiction_menu_height = 20 �����õ����˵��ĸ߶ȣ�Ĭ����15

"*******************************����6**************************************"
