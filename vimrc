""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => pathogen config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
" call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => function
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Platform
function MySys()
    if has("win32")
        return "windows"
    else
        return "linux"
    endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set cursorline

" Sets how many lines of history VIM has to remember
set history=900000

" Enable filetype plugin
filetype plugin on
filetype indent on

" 在状态栏显示正在输入的命令
set showcmd 
set laststatus=2
set statusline=
set statusline=%<%F " 文件名
set statusline+=%w%h%m%r " 选项
set statusline+=%{fugitive#statusline()} "Git
set statusline+=%= " Right aligned
set statusline+=\ %{&fenc!=''?&fenc:&enc}
set statusline+=\ A=%b\ H=0x%B " ASCII / Hexadecimal value of char
set statusline+=\ \ %l,%c%V\ %P " line,column

" 关闭/打开配对括号高亮
"NoMatchParen
"DoMatchParen

set modeline

" support mouse
set mouse=n
set selection=exclusive
set selectmode=key

" Set to auto read when a file is changed from the outside
" set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ";"
let g:mapleader = ";"

" Fast saving
nmap <leader>w :w<cr>
nmap <leader>x :x<cr>

" Fast editing of the _vimrc
if MySys() == "windows"
    map <leader>e :e! $vim/_vimrc<cr>
elseif MySys() == "linux"
    map <leader>e :e! ~/.vimrc<cr>
endif

" When vimrc is edited, reload it
if MySys() == "windows"
    autocmd! bufwritepost _vimrc source $vim/_vimrc
elseif MySys() == "linux"
    autocmd! bufwritepost .vimrc source ~/.vimrc
    autocmd! bufwritepost vimrc source ~/.vim/vimrc
endif

" miniBufExpl
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplModSelTarget = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical..
" set so=7

" set wildmenu "Turn on WiLd menu

set cmdheight=2 "The commandbar height

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase

set hlsearch "Highlight search things
set incsearch

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
" set noerrorbells
" set novisualbell
" set t_vb=
" set tm=500

" 如遇Unicode值大于255的文本，不必等到空格再折行。
set formatoptions+=m
" 合并两行中文时，不在中间加空格：
set formatoptions+=B

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

" Set font according to system
"if has("gui_running")
"    if has("gui_gtk2")
"        set guifont=Luxi\ Mono\ 12
"    elseif has("x11")
"        " Also for GTK 1
"        set guifont=*-lucidatypewriter-medium-r-normal-*-*-180-*-*-m-*-*
"    elseif has("gui_win32")
"        set guifont=Consolas:h10
"    endif
"endif

set background=dark
set nu
if has("gui_running")
    colorscheme desert
else
    colorscheme desert
endif
colorscheme desert

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=usc-bom,utf-8,gb2312,gb18030,big5,euc-jp,enc-kr,latin1
set fileformat=unix
set fileformats=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines
set nopaste
"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<leader>a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
"map <right> :bn<cr>
"map <left> :bp<cr>

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def

""""""""""""""""""""""""""""""
" => Plugins config 
""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" => Bash-support
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" => Code_Complete
""""""""""""""""""""""""""""""
let g:completekey = "<C-b>"
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
set completeopt=longest,menu 

""""""""""""""""""""""""""""""
" => C-support
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" => ctags
""""""""""""""""""""""""""""""
" ctags -R -f ~/ctags/systags --sort=yes --c-kinds=+px --c++-kinds=+px --fields=+iaS --extra=+q --python-kinds=-i /usr/include /usr/local/include
" ctags -R -f ~/ctags/platinum.tag --sort=yes --c-kinds=+px --c++-kinds=+px --fields=+iaS --extra=+q --python-kinds=-i ~/dlna/SRC/Platinum-f4d639/
" set tags=~/ctags/systags,~/ctags/platinum.tag
" only langures: c and cpp
" ctags -R -f avahi.tag --sort=yes --languages=C,C++ --c-kinds=+px --c++-kinds=+px --fields=+iaS --extra=+q ~/opensource/avahi-0.6.31/
set tags=~/ctags/systags,~/ctags/airplay-receiver.tag

""""""""""""""""""""""""""""""
" => DoxygenToolkit
""""""""""""""""""""""""""""""
let g:DoxygenToolkit_commentType = "C++"
" Add name of function/class/struct... after pre brief tag if you want 
let g:DoxygenToolkit_briefTag_className = "yes" 
let g:DoxygenToolkit_briefTag_structName = "no"
let g:DoxygenToolkit_briefTag_enumName = "no"
let g:DoxygenToolkit_briefTag_namespaceName = "no"
let g:DoxygenToolkit_briefTag_funcName = "no"

" let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
" let g:DoxygenToolkit_paramTag_pre="@Param "
" let g:DoxygenToolkit_returnTag="@Returns   "
" let g:DoxygenToolkit_blockHeader="=========================================================================="
" let g:DoxygenToolkit_blockFooter="============================================================================"
let g:DoxygenToolkit_authorName="hu_yinqiu"
" let g:DoxygenToolkit_licenseTag="My own license"   <-- Does not end with
" "\<enter>"

""""""""""""""""""""""""""""""
" => FencView(auto detect file encoding)
""""""""""""""""""""""""""""""
"关闭自动检测
let g:fencview_autodetect=0
map <leader>t :FencAutoDetect<cr>

"""""""""""""""""""""""""""""""
"" => NERDTree
"""""""""""""""""""""""""""""""
" use \n for NERTree
nnoremap <silent> \n :NERDTreeToggle<cr>

""""""""""""""""""""""""""""""
" => OmniCppComplete
""""""""""""""""""""""""""""""
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest

" 自动补全的窗口配色
hi Pmenu    ctermbg=DarkMagenta    ctermfg=Brown
hi PmenuSel ctermbg=LightCyan   ctermfg=LightYellow

"""""""""""""""""""""""""""""""
"" => Tagbar
"""""""""""""""""""""""""""""""
if MySys() == "windows"                "设定windows系统中ctags程序的位置
    let g:tagbar_ctags_bin = 'ctags'
elseif MySys() == "linux"              "设定windows系统中ctags程序的位置
    let g:tagbar_ctags_bin = '/usr/bin/ctags'
endif
let g:tagbar_left = 0                   "在右侧窗口中显示taglist窗口
let g:tagbar_autoclose = 0              "自动关闭
let g:tagbar_sort = 1                   "排序
"let g:tagbar_width = 40                "tagbar宽度
nmap \t :TagbarToggle<CR>
"autocmd FileType c,cpp,java nested :TagbarOpen
