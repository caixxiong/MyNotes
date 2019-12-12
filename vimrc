"判断vim是否支持python需要看两个地方:第一个是vim --version中是否有+python, 第二个是在末行模式下输入echo has("python"), 如果返回1则说明支持python
"   win下32位的gvim是不支持python的, 输入vim --version会出现-python, 此外vim的位数必须和python一致, 否则echo has("python")会返回0

"末行模式下输入source ~/.vimrc, 可以使得vimrc立即生效
"末行模式下输入%!xxd,会以16进制显示文件, %!xxd -r则返回文本模式
"末行模式下输入set rtp, 会显示vim环境变量rtp的值, rtp是vim的run time path, 所有插件只要放在了这目录下就可以用了, 当然还需要有Plugin ***这一句
":help key-notation 可以查看vim中按键符号和它的含义, 一般c是ctrl, m a是alt, s是shift
"ctrl + c, ctrl + [ 相当于esc, 从插入模式进入normal模式
":verbose imap <tab>可以显示tab被映射的键值含义

"caixiong 2018/10/17
set nocompatible "关闭与vi的兼容模式 required
set backspace=2
filetype off     "required
set nu 			 "显示行号 or:set number
set tabstop=4	 "设置tab为4个空格 or:set ts=4
set autoindent	 "设置保持自动缩进
set nowrap       "不自动折行
set splitbelow   "竖直分割窗口时,新窗口在下面显示
set splitright   "水平分割窗口时,新窗口在右边显示
"set noswapfile  "设置不要使用交换文件,其实使用交换文件更好,更安全 


"caixiong 2018/10/23
set shiftwidth=4    	"用于在v模式下 <和>缩进代码时的tabu对应空格数
set expandtab
set softtabstop=4
set pastetoggle=<f6> 	"copy前后均按一次f6 可保持原缩进
"autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,exc
"filetype plugin indent on


"add in blog 2018/11/02
set showmatch    	"显示匹配的括号
set scrolloff=3     "距离顶部和底部3行"
set encoding=utf-8  "指定vim内部的编码方式
set fenc=utf-8      "编码
set mouse=a        	"启用鼠标
"set hlsearch        "搜索高亮
syntax on    		"语法高亮
set foldmethod=indent	"代码折叠,indent方式,对大扩弧折叠
set foldlevel=99		"用zc创建折叠,用za来打开或者关闭折叠

"caixiong 2019/03/08 
set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1

"为py文件添加pep8（python enhencment proposal 8）风格配置
au BufNewFile,BufRead *.py
\ set tabstop=4     "tab宽度
\ set softtabstop=4 
\ set shiftwidth=4  
\ set textwidth=79  "行最大宽度
\ set expandtab     "tab替换为空格键
"\ set autoindent   "自动缩进
\ set fileformat=unix   "保存文件格式

"caixiong 2019/03/20 标志错误的空白字符
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"用ctrl-w代替ctrl-w-j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"用空格代替za
nnoremap <space> za		

"一键执行代码
map <F5> :call RunPython()<CR>
func! RunPython()
	exec "W"
	if &filetype == 'python'
		exec "!python %"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
	endif
endfunc

" 设置Vundle
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim  "设置vim的runtimepath环境变量, vim会根据这个环境变量去寻找插件的
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'	" let Vundle manage Vundle, required

"我的插件
Plugin 'vim-scripts/indentpython.vim'	"自动缩进
Plugin 'vim-syntastic/syntastic'		"语法检查
Plugin 'nvie/vim-flake8'                "flake8代码风格检查
Plugin 'Yggdroot/indentLine'			"缩进线
"Plugin 'Valloric/YouCompleteMe'         "自动补全
"Plugin 'zxqfl/tabnine-vim'
Plugin 'maralla/completor.vim'          "自动补全, 支持多种语言
Plugin 'davidhalter/jedi-vim'           "自动补全, python专用
Plugin 'jiangmiao/auto-pairs'			"自动补全括号,引号
Plugin 'tell-k/vim-autopep8'			"自动格式化工具
Plugin 'Lokaltog/vim-powerline'			"美化状态栏,可显示当前的文件名
Plugin 'scrooloose/nerdtree'			"添加树形目录,ctl+t开启目录
"Plugin 'altercation/vim-colors-solarized'	"solarized配色方案
"Plugin 'jnurmine/Zenburn'               "Zenburn配色方案
Plugin 'kien/ctrlp.vim'                 "超级搜索 ctrl+p
Plugin 'lervag/vimtex'                  "LaTex插件
Plugin 'SirVer/ultisnips'               "latex snips
Plugin 'ervandew/supertab'             "supertab插件, 在completor失败时使用

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"vimtex配置
let g:tex_flavor='latex'    "指定是latex, 否则vim-tex可能会把文件当成plaintex了
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mod=1
"set conceallevel=1
"let g:tex_conceal='abdmg'
let g:vimtex_complete_enabled=0

"latex snip配置
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories=["UltiSnips","mysnippets"]

"树形目录配置:
map <C-d> :NERDTreeToggle<CR>			
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']	"树形目录中忽略.pyc文件

"completor.vim配置:
"let g:completor_python_binary = '/usr/local/lib/python3.6/dist-packages/jedi/'
" Use `tab` key to select completions.  Default is arrow keys, 下面的代码不能注释掉, 否则就不能tab补全了
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
let g:completor_clang_binary = '/usr/bin/clang++'   "c++ 补全工具路径
let g:completor_python_binary = '/usr/bin/python'   "jedi模块所在python解释器路径

"jedi-vim配置, jedi-vim是专门为python补全的, 所以补全python功能更强大
"completor支持c等多种语言, 但是补全python没有jedi厉害
let g:jedi#completions_enabled = 0
let g:jedi#goto_command = "<leader>d"       "<leader>是'\', 即\d跳转到对应代码文件
let g:jedi#goto_assignments_command = "<leader>g"    " 显示函数调用
"let g:jedi#goto_definitions_command = "<leader>d"   "此命令弃用了
let g:jedi#documentation_command = "K"      " 显示函数的文档, 再按shift K返回
let g:jedi#usages_command = "<leader>n"     " 显示本文件中使用了该函数的行, 按enter返回
"let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
"let g:jedi#use_tabs_not_buffers = 1        "跳转时打开新的窗口
let g:jedi#use_splits_not_buffers = 'bottom'  "跳转时打开一个底部分割窗口
let g:jedi#smart_auto_mappings = 1
let g:jedi#show_call_signatures_delay = 300     "显示docstring的延迟时间300ms, 默认是500
"ctrl + t可以返回到\d跳转之前的代码(限同一个文件内部), 但是之前ctrl+t被nerdtree使用了, 后面
"即使是改成用<C-d>也没用, 这可能是因为没有撤销之前那个映射, 解决办法是先不安装nerdtree, 然
"后把映射改成<C-d>后重新安装就OK了

"supertab配置
let g:SuperTabDefaultCompletionType = "<c-n>"   " 设置此项可保证tab补全时从上之下, 而不是从下至上

"设置按f8可以自动格式化python代码:
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>

"配色方案选择:
"colorscheme solarized
"colorscheme zenburn
syntax enable
set background=light		"light or dark
if has('gui_running')		"终端使用dark,gui使用light
	set background=light
else
	set background=dark
endif

"syntastic语法检查配置:
"!!需要在vim中使用:SyntasticInfo来查看当前文件类型是否有支持的
"语法检查器，如果没有则需要安装，如果有则可以则可以检查语法了
"
"设置error和warning的标志
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='►'
"总是打开Location List（相当于QuickFix）窗口，如果你发现syntastic因为与其他插件冲突而经常崩溃，将下面选项置0
let g:syntastic_always_populate_loc_list = 1
"自动打开Locaton List，默认值为2，表示发现错误时不自动打开，当修正以后没有再发现错误时自动关闭，置1表示自动打开自动关闭，0表示关闭自动打开和自动关闭，3表示自动打开，但不自动关闭
let g:syntastic_auto_loc_list = 1
"修改Locaton List窗口高度
let g:syntastic_loc_list_height = 5
"打开文件时自动进行检查
let g:syntastic_check_on_open = 1
"自动跳转到发现的第一个错误或警告处
let g:syntastic_auto_jump = 1
"进行实时检查，如果觉得卡顿，将下面的选项置为1
let g:syntastic_check_on_wq = 0
"高亮错误
let g:syntastic_enable_highlighting=1
"让syntastic支持C++11
"let g:syntastic_cpp_compiler = 'g++'
"let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libc++'
"设置pyflakes为默认的python语法检查工具
let g:syntastic_python_checkers = ['flake8'] "['pyflakes', 'flake8', 'pylint']

"修复syntastic使用:lnext和:lprev出现的跳转问题，同时修改键盘映射使用sn和sp进行跳转
function! <SID>LocationPrevious()                       
  try                                                   
    lprev                                               
  catch /^Vim\%((\a\+)\)\=:E553/                        
    llast                                               
  endtry                                                
endfunction                                             
function! <SID>LocationNext()                           
  try                                                   
    lnext                                               
  catch /^Vim\%((\a\+)\)\=:E553/                        
    lfirst                                              
  endtry                                                
endfunction                                             
nnoremap <silent> <Plug>LocationPrevious    :<C-u>exe 'call <SID>LocationPrevious()'<CR>                                        
nnoremap <silent> <Plug>LocationNext        :<C-u>exe 'call <SID>LocationNext()'<CR>
nmap <silent> ss <Plug>LocationPrevious              
nmap <silent> sn <Plug>LocationNext
"关闭syntastic语法检查, 鼠标复制代码时用到, 防止把错误标志给复制了
nnoremap <silent> <Leader>ec :SyntasticToggleMode<CR>
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction
