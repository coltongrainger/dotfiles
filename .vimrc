" This .vimrc was forked on 2017-10-01 from
" https://github.com/riceissa/dotfiles.
" The mistakes are my own. -Colton

scriptencoding utf-8
set nocompatible

" Use vim-plug to manage Vim plugins. Install with
"     curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Once all Vim config files are in the right places, just do :PlugInstall in
" Vim to install the plugins.
call plug#begin('~/.vim/plugged')
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'godlygeek/tabular'
  Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
  Plug 'junegunn/gv.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'tpope/vim-characterize'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-rsi'
  Plug 'tpope/vim-ragtag'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-speeddating'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-vinegar'
  " TODO Test these extensions. <ccg, 2019-04-21> "
  Plug 'lervag/vimtex', {'for': '*.tex'}
  Plug 'SirVer/ultisnips'
  Plug 'coltongrainger/vim-snippets'
  Plug 'Konfekt/FastFold'
  Plug 'mileszs/ack.vim'
  Plug 'davidhalter/jedi-vim'
  " TODO Here's a list of plugins to tentatively remove. <ccg, 2019-04-21> "
  " Plug 'fatih/vim-go'
  Plug 'goerz/ipynb_notedown.vim'
  Plug 'aperezdc/vim-template'
  " Plug 'coltongrainger/vim-markdown'
  Plug 'altercation/vim-colors-solarized'
  Plug 'pandysong/ghost-text.vim'
  Plug 'wmvanvliet/jupyter-vim'
call plug#end()

" Workaround for https://github.com/tpope/vim-sleuth/issues/29.
" Define autocmd as early as possible so other autocmds can override.
runtime! plugin/sleuth.vim

" Override ttimeoutlen later
runtime! plugin/sensible.vim

set nomodeline ignorecase smartcase showcmd noequalalways nojoinspaces number nowrap
set noerrorbells visualbell t_vb= 
set noshowmatch scrolljump=5 " scrolloff=5
set spellfile=~/.spell.en.utf-8.add wildmode=list:longest,full sidescroll=1
set formatprg=par\ -w80qes0
set fillchars=fold:\ 
set foldmethod=marker
nnoremap Y y$

if has('autocmd')
  augroup vimrc
    autocmd!
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    autocmd BufWritePost .vimrc source $HOME/.vimrc
    autocmd BufReadPost *muttrc set filetype=muttrc
    autocmd BufNewFile,BufRead ~/.mutt/temp/*mutt* set noautoindent filetype=mail nonumber nolist nopaste
    autocmd FileType vim setlocal keywordprg=:help
    autocmd FileType conf,gitcommit,mail,markdown,mediawiki,tex setlocal spell linebreak
    autocmd FileType crontab setlocal commentstring=#%s
    autocmd FileType gitignore setlocal commentstring=#\ %s
    autocmd FileType mail,text,help setlocal comments=fb:*,fb:-,fb:+,n:>
    autocmd FileType mail setlocal tw=0
    autocmd FileType help,man,qf nnoremap <buffer> <silent> q :q<CR>
    autocmd FileType help,man setlocal nolist nospell
    " indentation defaults for written documents
    " we set a buffer-local variable to track if we have already run the autocmd so it
    " only runs once. Otherwise if we leave the buffer and come back, the
    " autocmd would run again.
    autocmd FileType python,mail,tex,markdown if !exists('b:did_vimrc_markdown_textwidth_autocmd') | setlocal expandtab shiftwidth=4 tabstop=4 textwidth=80 | let b:did_vimrc_markdown_textwidth_autocmd = 1 | endif
    autocmd FileType tex setlocal noai nocin nosi inde=
    autocmd FileType text setlocal filetype=markdown
    autocmd FileType make setlocal noexpandtab
    autocmd FileType cls setlocal filetype=tex
    " autocmd FileType tex setlocal foldmethod=manual
    autocmd FileType tex setlocal g:tex_fold_enabled=1
    " More aggressively check spelling in LaTeX; see
    " http://stackoverflow.com/questions/5860154/vim-spell-checking-comments-only-in-latex-files
    autocmd FileType tex syntax spell toplevel
    autocmd FileType tex setlocal g:tex_flavor='latex'
    " autocmd FileType python let maplocalleader = "`"
    autocmd FileType python nnoremap <buffer> <silent> <leader>x :JupyterSendCell<CR>
    autocmd FileType python vmap     <buffer> <silent> <leader>x <Plug>JupyterRunVisual
    autocmd FileType python nnoremap <buffer> <silent> <leader>r :JupyterRunFile -i %:p<CR>
    " pdb debugging needs to be run local to the jupyter qt console, not [remote]
    autocmd FileType python nnoremap <buffer> <silent> <leader>R :Start python3 %<CR>
    autocmd FileType python nnoremap <buffer> <silent> <F12> :JupyterConnect<CR> :JupyterCd %:p:h<CR>
    autocmd FileType python setlocal noshowmode
  augroup END
endif


colorscheme solarized
set background=light

let mapleader = ","
let g:dispatch_terminal_exec='urxvt -e'

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'yaml']
let g:templates_directory=['$HOME/.vim/templates']
let g:templates_no_builtin_templates=1
let g:templates_use_licensee=1
let g:email='colton.grainger@colorado.edu'
let g:username='Colton Grainger'
let g:license='CC-0 Public Domain'

let g:snips_author='ccg'
let g:snips_email='colton.grainger@colorado.edu'
let g:snips_github='https://github.com/coltongrainger'


let g:UltiSnipsEditSplit="tabdo"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
" default trigger values
"    g:UltiSnipsExpandTrigger               <tab>
"    g:UltiSnipsListSnippets                <c-tab>
"    g:UltiSnipsJumpForwardTrigger          <c-j>
"    g:UltiSnipsJumpBackwardTrigger         <c-k>
inoremap <c-x><c-k> <c-x><c-k>

let g:ultisnips_python_style='jedi'
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"

let g:jupyter_mapkeys=0
let g:jedi#popup_on_dot=2
let g:jedi#show_call_signatures=2
let g:jedi#show_call_signatures_delay=0
let g:jedi#use_splits_not_buffers='winwidth'

let g:tex_fast = "mM"
let g:vimtex_indent_enabled=0
let g:vimtex_matchparen_enabled=0

let g:vimtex_view_method='mupdf'
let g:vimtex_quickfix_mode=0
let g:vimtex_quickfix_latexlog = {
      \ 'default' : 1,
      \ 'general' : 1,
      \ 'references' : 0,
      \ 'overfull' : 0,
      \ 'underfull' : 0,
      \ 'font' : 0,
      \}

let g:fastfold_fold_movement_commands = []
let g:fastfold_minlines=0
let g:fastfold_force=1
nmap <F5> <Plug>(FastFoldUpdate)

let g:vimtex_fold_enabled=1
let g:vimtex_fold_env_whitelist = [
      \'claim',
      \'comp',
      \'coro',
      \'defn',
      \'ex',
      \'fact',
      \'lem',
      \'note',
      \'proof',
      \'prop',
      \'quote',
      \'rem',
      \'thm',
      \'todo',
      \]
let g:vimtex_fold_env_blacklist = [
      \'itemize',
      \'enumerate',
      \]

noremap <F2> :so ~/.vimrc<CR>
noremap <F3> :Start latex-help.sh<CR>
noremap <F4> :UltiSnipsEdit<CR>
" Give suggestions for last misspelled word.
map <C-S> [sz=

" pandoc tools
" compile .pdf and watch
nmap <leader>pc :Start pc.sh %<CR>
" view available .pdf
nmap <leader>pv :Dispatch! pv.sh %<CR>

" https://github.com/vEnhance/dotfiles/blob/master/vimrc
function! DelEmptyLineAbove()
    if line(".") == 1
        return
    endif
    let l:line = getline(line(".") - 1)
    if l:line =~ '^\s*$'
        let l:colsave = col(".")
        .-1d
        "silent normal!
        call cursor(line("."), l:colsave)
    endif
endfunction

function! AddEmptyLineAbove()
    let l:scrolloffsave = &scrolloff
    " Avoid jerky scrolling with ^E at top of window
    set scrolloff=0
    call append(line(".") - 1, "")
    if winline() != winheight(0)
        "silent normal!
    endif
    let &scrolloff = l:scrolloffsave
endfunction

function! DelEmptyLineBelow()
    if line(".") == line("$")
        return
    endif
    let l:line = getline(line(".") + 1)
    if l:line =~ '^\s*$'
        let l:colsave = col(".")
        .+1d
        ''
        call cursor(line("."), l:colsave)
    endif
endfunction

function! AddEmptyLineBelow()
    call append(line("."), "")
endfunction

" https://stackoverflow.com/questions/7845671/executing-base64-decode-on-a-selection-in-vim
vnoremap <leader>64 c<c-r>=system('base64 --decode', @")<cr><esc>

" Remap arrow keys to 'useful' things.
noremap <Left> <<
noremap <Right> >>
noremap <S-Up> :call DelEmptyLineBelow()<CR>
noremap <S-Down> :call AddEmptyLineBelow()<CR>
noremap <Up> :call DelEmptyLineAbove()<CR>
noremap <Down> :call AddEmptyLineAbove()<CR>

" I don't want to suspend my terminal.
noremap <C-z> <nop>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" https://github.com/vEnhance/dotfiles/blob/master/vimrc
inoremap <C-U> <C-G>u<C-U>

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k
