" ------------------ others --------------------" 
" ------------------ some keys mapping ---------------------" 
imap zk <ESC>
nmap zk <ESC>
:map <C-]> g<C-]>
" nmap <F10> <Esc>:set nopaste<cr>
set pastetoggle=<F10>

" 窗口设置
" unmap <C-w>\
map <C-w>- <C-w>_   " 重映射最大化窗口快捷键，针对水平分割的情况
" map <C-w>\ <C-w>|

" map <F10> <Esc>:tabnew<cr>  " 设置F10为打开新标签页
" map <C-[> <C-t>  " 重映射函数往回跳转快捷键

" 自动补全括号
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
" inoremap " ""<left>
" inoremap ' ''<left>

function! RemoveNextDoubleChar(char)
    let l:line = getline(".")
    let l:next_char = l:line[col(".")]

    if a:char == l:next_char
        execute "normal! l"
    else
        " a means append
        execute "normal! a" . a:char . ""   
        " i means insert
        " execute "normal! i" . a:char . ""  
    end
endfunction

inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a

" Vertical Split Buffer Function
function! VerticalSplitBuffer(buffer)
    execute "vert sb" a:buffer
endfunction

" Vertical Split Buffer Mapping
command -nargs=1 Sb call VerticalSplitBuffer(<f-args>)


" ------------------ some configures of plugin --------------------" 
filetype on 
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" ADD YOUR PLUGIN
Plugin 'scrooloose/nerdtree'                "file / directory tree
Plugin 'scrooloose/nerdcommenter'           " code commenter
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'vim-scripts/cscope'             " 函数跳转的插件
Plugin 'vim-airline/vim-airline'                  " 状态条加强
Plugin 'vim-airline/vim-airline-themes'     " airline 的颜色主题
Plugin 'majutsushi/tagbar'                  " 可以在vim中显示函数目录
Plugin 'vim-scripts/SuperTab'               " 使tab键有更快捷的上下文提示功能，自动补全的功能
Plugin 'flazz/vim-colorschemes'             " 颜色主题库
Plugin 'Yggdroot/indentLine'                " 显示缩进指示线
" Plugin 'fholgado/minibufexpl.vim'           " 多文件之间的切换
Plugin 'tpope/vim-fugitive'                 " 方便在vim中使用git的命令
" Plugin 'lervag/vimtex'                      " 在vim中使用latex
" Plugin 'godlygeek/tabular'                  " 代码对齐
" Plugin 'tmux-plugins/vim-tmux-focus-events'        " 配置tmux使得在tmux中打开vim后FocusGained FocusLost有效
call vundle#end()
filetype plugin indent on


" ##################### vimtex config #####################  
" let g:tex_flavor='latex'
" let g:vimtex_view_method='zathura'
" let g:vimtex_quickfix_mode=0
" " 下面两行控制隐藏功能，开启之后，除了光标所在行之外，文本夹杂的latex代码会被隐藏掉，文档更易读。
" set conceallevel=1
" let g:tex_conceal='abdmg'


" ##################### vim-fugitive config #####################  

" ##################### indentLine config #####################  
nmap <F6> :IndentLinesToggle<cr>
"let g:indentLine_setColors = 0
let g:indentLine_color_term = 239
"let g:indentLine_setConceal = 0
let g:indentLine_char = "|"
let g:indentLine_enabled = 1
let g:autopep8_disable_show_diff = 1
" let g:indentLine_noConcealCursor = ""
" let g:vim_json_syntax_conceal = 0
" let g:indentLine_setConceal = 0
autocmd Filetype json let g:indentLine_enabled = 0  " indentLine插件会影响 json文件双引号的显示，所以关掉


" ##################### colorschemes config #####################  
" if uses 'solarized', iterm2 color should set to 'solarized dark'
" colorscheme solarized
"
" set background=dark
" colorscheme PaperColor
" colorscheme molokai
colorscheme monokain


" ##################### SuperTab config #####################  
" 设置不同vim模式下都可以用tab和shift tab进行缩进
" nmap <tab> V>
" nmap <s-tab> V<
vmap <tab> >gv
vmap <s-tab> <gv
"imap <S-tab> <Esc><<i

let g:SuperTabRetainCompletionType=2   " 0 - 不记录上次的补全方式; 1 - 记住上次的补全方式,直到用其他的补全命令改变它; 2 - 记住上次的补全方式,直到按ESC退出插入模式为止


" ##################### tagbar config #####################  
nmap <F9> :TagbarToggle<cr>
let g:tagbar_width=40
" let g:tagbar_autofocus=1          " 打开tagbar时自动转到tagbar窗口
let g:tagbar_sort=0               " if 0: 函数名按照在文件中的顺序排列，if 0: 函数名按照字典序排序


" ##################### vim-airline config #####################  
let g:airline#extensions#tabline#enabled = 1 " 显示tabline，相当于minibufexpl的功能。
let g:airline#extensions#tabline#buffer_nr_show = 1 " buffer 数字从1开始
let g:airline_theme='dark'  " 设置颜色主题
" let g:airline_section_c=''
" call airline#parts#define_accent('file', 'red')
" nmap <tab> :bn<CR>
" nmap <S-tab> :bp<CR>


" ##################### nerdtree config #####################  
nmap <F4> :NERDTreeToggle<cr>
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif  " 最后的文件关闭时自动关闭目录树
let NERDTreeWinSize=30


" ##################### nerdcommenter config #####################  
let mapleader=","  "默认是 \ ,mapleader的意思就是要启用注释时的启动命令一样

let g:NERDSpaceDelims=1 " add whitespace when commenting

"Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

"Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1



" ------------------ some setting --------------------" 
set t_Co=256
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8  " 兼容中文字体，防止中文乱码
set nocompatible  " 去掉vi一致性模式，避免以前版本的一些bug
set number
syntax on
set hls     "搜索时高亮显示被找到的文本
set colorcolumn=90
set cursorline   " 高亮光标所在的行
" hi cursorline ctermfg=None  ctermbg=8  guibg=NONE guifg=NONE
" 在多窗口情况下，非激活窗口关闭高亮当前行
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
	autocmd WinEnter * set colorcolumn=90
	autocmd WinLeave * set colorcolumn=0
augroup END
set is
set sw=4
set showcmd
set mouse=r
set confirm
set backspace=2   "可随时用退格键删除
set whichwrap=b,s,<,>,[,]  "默认情况下，在 VIM 中当光标移到一行最左边的时候，我们继续按左键，光标不能回到上一行的最右边。
set nobackup
set noswapfile  " 文件就不会产生.swp文件
if has("persistent_undo")
    set undofile
    set undodir=$HOME/.vim/undo
endif
" augroup BgHighlight
"     autocmd!
"     autocmd WinEnter * set colorcolumn=90
"     autocmd WinLeave * set colorcolumn=0
" augroup END
" set nowrap
" highlight MatchParen  guifg=#00005f guibg=#000000 gui=bold  " 设置括号匹配的颜色
" hi MatchParen ctermbg=116 guibg=lightblue
" highlight Search guifg=#FFFFFF guibg=#455354 " 设置在vim搜索时的颜色

" 代码折叠
set foldmethod=indent  " 折叠方式：manual, indent(用缩进表示折叠), syntax(用语法高亮来定义折叠), marker(用标志折叠)
set foldlevelstart=99  " 打开文件默认不折叠


" 设置空格与tab键
set smarttab  " 根据文件中其他地方的缩进空格个数来确定一个tab是多少个空格
set tabstop=4
set shiftwidth=4 " 每一级缩进是多少个空格
set expandtab  " 将tab扩展成空格。noexpandtab反之

" config vim to match tmux in background
if exists('$TMUX')
    set term=screen-256color
end

map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" 这个命令用于检测tags文件是否存在，若存在则自动更新tag file
function! AutoUpdateTags()
    if filereadable("ctags.sh") " content in ctags.sh should be: find . -name '.*py' | ctags -L -
        " au BufWritePost *.py,*.c,*.cpp,*.h silent! !eval 'ctags -R -o newtags; mv newtags tags' &
        au BufWritePost *.py,*.c,*.cpp,*.h silent! !eval 'sh ctags.sh' & 
    endif
endfunction
call AutoUpdateTags()


" 通过触发checktime命令，来执行autoread命令，从而可以自动更新当前文件(如果当前文件在其它地方修改了的话，就会被更新过来)
function! AutoFreshFile()
    set updatetime=1000  " 设置checktime的更新间隔为1秒, 默认4秒
    autocmd! CursorHold,CursorHoldI,FocusGained,BufEnter * silent! checktime   " silent!命令可以抑制错误信息的弹出
    " autocmd! CursorHold,CursorHoldI,FocusGained,BufEnter * if mode() != "c" | checktime | endif
    autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
    set autoread  " 让vim自动更新在其它地方修改过的文件, 一般就是用在git跳转的时候可以自动更新文件内容
                  " 但是这个命令要运行checktime之后才会执行，所以上面才需要通过一些触发事件来运行checktime
endfunction
call AutoFreshFile()

set tags=./tags;/  " 保证当前目录在ctags的子目录下也能进行函数跳转

" jump to the last position when reopening a file
if has("autocmd")
 au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."), "cd \"$(dirname \"$0\")\"")
    elseif &filetype == 'python'
        call setline(1,"#-*- coding: utf-8 -*-")
        " call append(line("."),"#File: ".expand("%"))
        " call append(line(".")+1, "#Author: webbley(liwb5@foxmail.com)")
        " call append(line(".")+2, "")
    " else
    "     call setline(1, "/*************************************************************************")
    "     call append(line("."), "    > File Name: ".expand("%"))
    "     call append(line(".")+1, "    > Author:")
    "     call append(line(".")+2, "    > Mail: ")
    "     call append(line(".")+3, "    > Created Time: ".strftime("%c"))
    "     call append(line(".")+4, "    > Usage: ")
    "     call append(line(".")+5, " ************************************************************************/")
    "     call append(line(".")+6, "")
    endif
    " if expand("%:e") == 'cpp'
    "     call append(line(".")+7, "#include<iostream>")
    "     call append(line(".")+8, "using namespace std;")
    "     call append(line(".")+9, "")
    " endif
    " if &filetype == 'c'
    "     call append(line(".")+7, "#include<stdio.h>")
    "     call append(line(".")+8, "")
    " endif
    " if expand("%:e") == 'h'
    "     call append(line(".")+7, "#ifndef _".toupper(expand("%:r"))."_H")
    "     call append(line(".")+8, "#define _".toupper(expand("%:r"))."_H")
    "     call append(line(".")+9, "#endif")
    " endif
endfunc
"新建文件后，自动定位到文件末尾
autocmd BufNewFile * normal G

