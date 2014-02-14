"
" .vimrc
"

set nocompatible

" shiftwidth
set sw=2
" tabstop
set ts=2
" softtabstop
set sts=2
" autoindent
"set ai
" tab to space
set expandtab
" Backspace
set backspace=start,eol,indent

" hidden
set hidden
" hlsearch
set hlsearch
" incremental search
set incsearch
" ic
set ic
set smartcase
" clipboard
"set clipboard=unnamed,autoselect
set clipboard=autoselect
" wildmenu
set wildmenu
" fix east asian UTF-8 charactor width
set ambiwidth=double

" cursor motion in insert mode
"inoremap <C-n> <Down>
"inoremap <C-p> <Up>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" extend key map
"inoremap { {}<LEFT>
vnoremap <Leader>" "zdi"<C-R>z"<ESC>
vnoremap <Leader>' "zdi'<C-R>z'<ESC>

" colorscheme
" colorscheme newspaper
"hi Normal ctermbg=Black ctermfg=White
colorscheme myjellybeans
"colorscheme hybrid

" statusline
" set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set laststatus=2
" syntax
syntax on
" split below
set splitbelow
set splitright
" tab
"set showtabline=2

" set filetype to php when open the *.inc
au BufNewFile,BufRead *.inc setf php
au BufNewFile *.php set fileencoding=euc-jp
au BufNewFile *.sql set fileencoding=euc-jp
au FileType php setlocal ts=4 sts=4 sw=4 et

" set filetype to ruby when open a file.
au FileType ruby setlocal ts=2 sts=2 sw=2 et
au FileType eruby setlocal ts=2 sts=2 sw=2 et

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,euc-jisx0213,sjis


" NeoBundle
set nocompatible               " be iMproved
filetype plugin indent off     " required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

if exists('*neobundle#rc')
  NeoBundleFetch 'Shougo/neobundle.vim'

  NeoBundle 'Shougo/vimproc', {
    \   'build' : {
    \     'mac' : 'make -f make_mac.mak'
    \   }
    \ }
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/vimfiler'
  NeoBundle 'Shougo/vimshell'
  NeoBundle 'Shougo/neocomplcache'

  NeoBundle 'thinca/vim-quickrun'
  "NeoBundle 'thinca/vim-ref'

  NeoBundle 'kien/ctrlp.vim'

  NeoBundle 'tpope/vim-endwise'
  "NeoBundle 'ruby-matchit'
  "NeoBundle 'ujihisa/unite-rake'
  "NeoBundle 'basyura/unite-rails'
  NeoBundle 'scrooloose/syntastic.git'

  NeoBundle 'mattn/emmet-vim'
  NeoBundle 'mattn/sonictemplate-vim'
  "NeoBundle 'bling/vim-airline.git'
  NeoBundle 'itchyny/lightline.vim'

  "NeoBundle 'xolox/vim-misc'
  "NeoBundle 'xolox/vim-session'

  NeoBundleCheck
endif

filetype plugin indent on
"filetype plugin on


" Keys
nmap <Space>f :VimFiler<CR>
nmap <Space>l :Unite buffer<CR>
nmap <Space>h :Unite file_mru<CR>
nmap <Space>t :Template<Space>
"nmap <Space>s :15sp +VimShell getcwd()<CR>
"nmap <Space>s :let mycwd=getcwd()\|15sp +VimShell mycwd\|unlet mycwd<CR>
"nmap <Space>s :15sp +VimShell<CR>
nmap <Space>s :let g:myvsbufnr=bufnr("%")\|VimShell<CR>
nmap <Space>c :SyntasticCheck<CR>
nnoremap <silent> <C-l> :noh<CR><C-l>
nmap <Space>2 :set ts=2 sts=2 sw=2<CR>
nmap <Space>z :w<CR>

function! g:MyDeleteBuffer()
    let l:bn = bufnr("%")
    if buflisted(bufnr("#")) && bufname(bufnr("#")) != ''
        exe "buf " . bufnr("#")
    else
        let l:find = 0
        for i in range(1, bufnr('$'))
            if i != l:bn && buflisted(i)
                if bufname(i) == ''
                    exe "bdel " . i
                else
                    exe "buf " . i
                    let l:find = 1
                    break
                endif
            endif
        endfor
        if !l:find
            enew
        endif
    endif
    if bufwinnr(l:bn) == -1
        exe "bdel " . l:bn
    endif
endfunction

"nmap <Space>d :let bn=bufnr("%")\|enew\|exe "bdel ".bn\|unlet bn<CR>
"nmap <silent> <Space>d :let bn=bufnr("%")\|exe buflisted(bufnr("#")) ? "buf ".bufnr("#"): "enew"\|exe "bdel ".bn\|unlet bn<CR>
"nmap <Space>d :let bn=bufnr("%")\|exe buflisted(bufnr("#")) ? "buf ".bufnr("#"): "new"\|exe "bdel ".bn\|unlet bn<CR>
nmap <silent> <Space>d :call g:MyDeleteBuffer()<CR>
nmap <Space>v :vsp<CR>

let g:vimfiler_safe_mode_by_default=0
let g:vimfiler_execute_file_list = {'_': 'vim'}

let g:quickrun_config = {}
let g:quickrun_config['_'] = {
                           \ 'split': ''
                           \ }

"                           \ 'runner': 'vimproc:500',

let g:quickrun_config.html = {
            \ 'outputter' : 'null',
            \ 'command' : 'open',
            \ 'cmdopt' : '-a',
            \ 'args' : 'Google\ Chrome',
            \ 'exec' : '%c %o %a %s'
            \ }

"let g:syntastic_phpcs_conf = 0
let g:syntastic_phpcs_conf = '-n'
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['php'] }

" for vimshell
function! g:MyVimShellClose()
"    wincmd k
"    close
    if bufexists(g:myvsbufnr) && bufnr("%") != g:myvsbufnr
        exe "buf " . g:myvsbufnr
    else
        enew
    endif
"    <Plug>(vimshell_exit)
endfunction

"command! MyVimShellCloseCommand :call g:MyVimShellClose()
let g:vimshell_interactive_update_time = 10
let g:vimshell_max_command_history = 9999
let g:vimshell_prompt = '$ '
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
"let g:vimshell_split_command = 'close'
"let g:vimshell_split_command = 'MyVimShellCloseCommand'
let g:vimshell_split_command = 'call g:MyVimShellClose()'
"autocmd FileType vimshell imap <buffer> <C-d> <Plug>(vimshell_exit)
autocmd FileType vimshell imap <buffer> <C-d> <Esc>:<C-u>call g:MyVimShellClose()<CR>


" for neocomplcache
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" For lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" auto save and restore a vim session
"function! SaveSession()
"    mksession! ~/.vim/Session.vim
"    exe 'qa!'
"endfunction
"autocmd VimLeave * call SaveSession()
"
"function! RestoreSession()
"    let l:fn = $HOME . '/.vim/Session.vim'
"    if argc() == 0 && filereadable(l:fn)
"        execute 'source ' . l:fn
"        call delete(l:fn)
"    end
"endfunction
"autocmd VimEnter * call RestoreSession()

" For ctrlp
let g:ctrlp_working_path_mode = 'a'

" For vim-session
set sessionoptions-=curdir
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'

" load local vim environment
if exists('$HOME') && filereadable($HOME . '/.vimrc_local')
    source $HOME/.vimrc_local
endif

