scriptencoding utf-8
call plug#begin('~/.vim/plugged')
" Base:
  " help for japanese
  Plug 'vim-jp/vimdoc-ja'

  " status line customize
  Plug 'itchyny/lightline.vim'

  " preview on browser
  Plug 'kannokanno/previm'

  " fizzy finder
  Plug 'ctrlpvim/ctrlp.vim'

  " directory tree
  Plug 'scrooloose/nerdtree'

  " tags information, require ctags
  Plug 'majutsushi/tagbar'

  " generate tags file
  " TODO: consider tags directory
  " let g:vim_tags_cache_dir = expand($HOME)
  " default .vt_location is .git directory
  Plug 'szw/vim-tags'

  " snipets
  Plug 'mattn/sonictemplate-vim'

  " command runner
  Plug 'thinca/vim-quickrun'

  " check reference from current cursors words
  Plug 'thinca/vim-ref'

  " jump to words
  Plug 'easymotion/vim-easymotion'

" Git:
  " use git commands in vim
  Plug 'tpope/vim-fugitive'

  " display a git diff in sign column
  Plug 'airblade/vim-gitgutter'

" Language:
  " language server protocol
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'

  " diagnostics
  let s:useALE = v:false
  if s:useALE
    Plug 'w0rp/ale'
  else
    Plug 'vim-syntastic/syntastic'
  endif

  " dart
  Plug 'dart-lang/dart-vim-plugin'

  " c
  Plug 'justmao945/vim-clang'

  " javascript
  Plug 'heavenshell/vim-jsdoc'
  Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

  " rust
  Plug 'rust-lang/rust.vim'
  Plug 'racer-rust/vim-racer'

  " go
  Plug 'fatih/vim-go'

  " python
  Plug 'davidhalter/jedi-vim'

  " UML is Unified Modeling Language, see 'plantuml.com'
  " vim-slumlord is for insert the ASCII diagrams
  Plug 'scrooloose/vim-slumlord'
  Plug 'aklt/plantuml-syntax'

  " html css
  Plug 'mattn/emmet-vim'

" Colorscheme:
  Plug 'nanotech/jellybeans.vim'
  Plug 'w0ng/vim-hybrid'
  Plug 'cocopon/Iceberg.vim'
  Plug 'tomasr/molokai'
  "Plug 'trusktr/seti.vim'

" TODO: remove?
  "Plug 'google/vim-maktaba'
  "Plug 'google/vim-glaive'
  "Plug 'google/vim-codefmt'
call plug#end()

" TODO: split to files

" Let:

" sonictemplate-vim
let s:sonicdir = expand('~/dotfiles/vim/sonictemplate')
if isdirectory(s:sonicdir)
  let g:sonictemplate_vim_template_dir = s:sonicdir
else
  echoerr "not found " . s:sonicdir
endif

" lightline.vim
let g:lightline = {
  \ 'colorscheme': 'jellybeans',
  \ 'active': {
    \ 'left': [
      \ [ 'mode', 'paste', 'fugitive' ],
      \ [ 'readonly', 'filename', 'modified' ],
    \ ],
    \ 'right': [
      \ [ 'lineinfo', 'charvaluehex', 'percent', 'bufnum' ],
      \ [ 'spell', 'fileformat', 'fileencoding', 'filetype' ],
      \ [ 'syntastic', 'ale' ],
    \ ],
  \ },
  \ 'component': {
    \ 'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
    \ 'charvaluehex': '0x%04B',
  \ },
  \ 'component_visible_condition': {
    \ 'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())',
  \ },
  \ 'component_function': {
    \ 'syntastic': 'SyntasticStatuslineFlag',
    \ 'ale': 'ALEGetStatusLine',
  \ },
\ }
let g:lightline.tabline = {
  \ 'left': [
    \ [ 'tabs' ],
  \ ],
  \ 'right': [
    \ [ 'close' ],
  \ ],
\ }
let g:lightline.enable = {
  \ 'statusline': 1,
  \ 'tabline': 1,
\ }


" vim-gitgutter
let g:gitgutter_map_keys = v:false

" tagbar
if (has('win32') || has('win64'))
  " path to local biuld ctags.exe
  if executable(expand('~/opt/ctags/ctags.exe'))
    let g:tagbar_ctags_bin = expand('~/opt/ctags/ctags.exe')
  else
    echoerr 'not found "ctags.exe"'
  endif
endif
let g:tagbar_type_go = {
  \ 'ctagstype' : 'go',
  \ 'kinds' : [
    \ 'p:package',
    \ 'i:imports:1',
    \ 'c:constants',
    \ 'v:variables',
    \ 't:types',
    \ 'n:interfaces',
    \ 'w:fields',
    \ 'e:embedded',
    \ 'm:methods',
    \ 'r:constructor',
    \ 'f:functions'
  \ ],
  \ 'sro' : '.',
  \ 'kind2scope' : {
    \ 't' : 'ctype',
    \ 'n' : 'ntype'
  \ },
  \ 'scope2kind' : {
    \ 'ctype' : 't',
    \ 'ntype' : 'n'
  \ },
  \ 'ctagsbin' : 'gotags',
  \ 'ctagsargs' : '-sort -silent'
\ }

" vim-quickrun
" 設定するとデフォルトマップが無効になる
"let g:quickrun_no_default_key_mappings = 1
let g:quickrun_config = {}
" :QuickRun gotest
" go test -race $(pwd)
let g:quickrun_config['gotest'] = {'command': 'go', 'exec': ['%c test -v -race']}

" previm
if executable('firefox')
  let g:previm_open_cmd = 'exec firefox'
elseif executable('chromium')
  let g:previm_open_cmd = 'exec chromium'
endif

" vim-easymotion
let g:EasyMotion_do_mapping = 0

" vim-lsp
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

" Debug:
if v:false
  let g:lsp_log_verbose = 1
  " check: tail --follow $logfile
  let g:lsp_log_file = expand('~/tmp/vim-lsp.log')
endif

" Go:
if executable('golsp')
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'golsp',
        \ 'cmd': {server_info -> ['golsp', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
      \ })
endif
" Rust:
if executable('rls')
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'rls',
    \ 'cmd': {server_info -> ['rustup', 'run', 'nightly', 'rls']},
    \ 'root_uri': {
      \ server_info -> lsp#utils#path_to_uri(
        \ lsp#utils#find_nearest_parent_file_directory(
          \ lsp#utils#get_buffer_path(), 'Cargo.toml'
        \ )
      \ )
    \ },
    \ 'whitelist': ['rust'],
  \ })
endif

if s:useALE
  " ale
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_lint_on_save = 1
  let g:ale_lint_on_enter = 1
  " rustc is only use nightly
  " if use on stable or beta then be careful that is make the executable
  let g:ale_linters = {
    \ 'rust': ['cargo', 'rls', 'rustc'],
  \ }
else
  " syntastic
  " go
  let g:syntastic_go_checkers = ['gofmt', 'govet', 'golint', 'gotype']
  " rust
  let g:syntastic_rust_checkers = ['cargo']
  " cpp
  let g:syntastic_cpp_compiler = 'clang'
  let g:syntastic_cpp_compiler_options = '-std=c++1z --pedantic-errors'
  let g:syntastic_cpp_checkers = ['clang_check']
  " javascript
  let g:syntastic_javascript_checkers = ['eslint']
endif

" vim-clang
let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++1z --pedantic-errors'

" vim-go
if isdirectory(expand('~/dotfiles/vim/tmp/bin'))
  let g:go_bin_path = expand('~/dotfiles/vim/tmp/bin')
endif
let g:go_play_open_browser = 0
let g:go_fmt_autosave = 0
let g:go_template_autocreate = 0

" jedi-vim
"let g:jedi#auto_initialization = 0
let g:jedi#popup_on_dot = 0
let g:jedi#auto_close_doc = 0
"let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = 0
let g:jedi#rename_command = '<LocalLeader>R'

" Map:
if s:useALE
  " ale
  nnoremap <LocalLeader>ale :<C-u>ALEToggle<CR>
  nnoremap <LocalLeader>ad :<C-u>ALEDetail<CR>
  nnoremap <LocalLeader>an :<C-u>ALENextWrap<CR>
  nnoremap <LocalLeader>ap :<C-u>ALEPreviousWrap<CR>
else
  " syntastic
  " 保存時に常に走らせると少し重い時があるのでトグルをマップ
  " 非同期でチェックできる良いプラグインがあれば乗り換えたい
  nnoremap <LocalLeader>s :<C-u>SyntasticToggleMode<CR>
  nnoremap <LocalLeader>o :<C-u>Errors<CR>
  nnoremap <LocalLeader>e :<C-u>Errors<CR>
  nnoremap <LocalLeader>c :<C-u>lclose<CR>
endif

" nerdtree
nnoremap <LocalLeader>n :<C-u>NERDTreeToggle<CR>

" tagbar
nnoremap <LocalLeader>t :<C-u>TagbarToggle<CR>

" quickrun
nnoremap <LocalLeader>r :<C-u>QuickRun<CR>

" sonictemplate-vim
" すぐにテンプレートを編集できるように
function! s:editsonic() abort
  if isdirectory(g:sonictemplate_vim_template_dir)
    " open by NERDTree or netrw
    execute "vsplit" . " " . g:sonictemplate_vim_template_dir
  else
    echoerr "not directory g:sonictemplate_vim_template_dir"
  endif
endfunction
nnoremap <LocalLeader>ww :<C-u>call <SID>editsonic()<CR>

" vim-easymotion
map <LocalLeader>f <Plug>(easymotion-bd-w)
nmap <LocalLeader>f <Plug>(easymotion-overwin-w)

" vim-gitgutter
nnoremap <LocalLeader>ggt :<C-u>GitGutterToggle<CR>

filetype plugin indent on

" vim-lsp
" TODO: fix
function! s:term_lsp() abort
  let l:m = {
        \  's': 'LspStatus',
        \  'r': 'LspReferences',
        \  'd': 'LspDefinition',
        \  'h': 'LspHover',
        \  'n': 'LspNextError',
        \  'p': 'LspPreviousError',
        \  'f': 'LspDocumentFormat',
        \ }
  echo "Lsp:"
  for l:key in sort(keys(l:m))
    echo '  ' . l:key . '  ' . string(l:m[l:key])
  endfor
  echo 'Input:>'
  let l:c = nr2char(getchar())
  echo 'Input:' . l:c
  if has_key(l:m, l:c)
    execute l:m[l:c]
  endif
endfunction
function! s:mapping_for_lsp() abort
  nmap <buffer> <LocalLeader>s <plug>(lsp-status)
  nmap <buffer> <LocalLeader>r <plug>(lsp-references)
  nmap <buffer> <LocalLeader>d <plug>(lsp-definition)
  nmap <buffer> <LocalLeader>h <plug>(lsp-hover)
  "nmap <buffer> <LocalLeader>n <plug>(lsp-next-error)
  "nmap <buffer> <LocalLeader>p <plug>(lsp-previous-error)
  nmap <buffer> <LocalLeader>f <plug>(lsp-document-format)

  nnoremap <buffer> <LocalLeader>l :<C-u>call <SID>term_lsp()<CR>
endfunction

function! s:ftgo()
  " TODO: consider
  call s:mapping_for_lsp()

  " vim-go
  nnoremap <buffer> <LocalLeader>i :<C-u>GoImport<Space>
  nnoremap <buffer> <LocalLeader>d :<C-u>GoDrop<Space>
  nnoremap <buffer> <LocalLeader>gd :<C-u>GoDoc<Space>
  nnoremap <buffer> <LocalLeader>gf :<C-u>GoFmt<Space>

  " quickrun
  nnoremap <buffer> <LocalLeader>t :<C-u>QuickRun gotest<Space>
endfunction

function! s:ftrust()
  " TODO: consider
  call s:mapping_for_lsp()

  " vim-racer
  if executable(expand('~/.cargo/bin/racer'))
    let g:racer_cmd = expand('~/.cargo/bin/racer')
    let g:racer_experimental_completer = 1
    nmap <buffer> gd <Plug>(rust-def)
    nmap <buffer> gs <Plug>(rust-def-split)
    nmap <buffer> gx <Plug>(rust-def-vertical)
    nmap <buffer> <LocalLeader>gd <Plug>(rust-doc)
  else
    echoerr 'not found "racer"'
  endif

  " quickrun
  nmap <buffer> <LocalLeader>r <Plug>(quickrun)
endfunction

augroup plugin_manage_plug
  autocmd!
  autocmd FileType go call s:ftgo()
  autocmd FileType rust call s:ftrust()
augroup END
