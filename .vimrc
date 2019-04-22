" This .vimrc was forked on 2017-10-01 from
" https://github.com/riceissa/dotfiles.
" The mistakes are my own. -Colton

scriptencoding utf-8
set nocompatible

" To fix an error from VimTex that prevents folding. <2019-04-21>
" This seems futile, since vim-plug should execute both commands.
" filetype plugin indent on
" syntax on

" Use vim-plug to manage Vim plugins. Install with
"     curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Once all Vim config files are in the right places, just do :PlugInstall in
" Vim to install the plugins.
call plug#begin('~/.vim/plugged')
  " colorscheme
  Plug 'altercation/vim-colors-solarized'
  " format tables with :Tabularize
  Plug 'godlygeek/tabular'
  Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
  Plug 'junegunn/gv.vim'
  Plug 'lervag/vimtex', {'for': 'tex'}
  Plug 'tpope/vim-characterize'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-rsi'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-speeddating'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-vinegar'
  " TODO Test these extensions. <ccg, 2019-04-21> "
  Plug 'SirVer/ultisnips'
  Plug 'Konfekt/FastFold'
  Plug 'matze/vim-tex-fold'
  Plug 'mileszs/ack.vim'
  Plug 'AndrewRadev/splitjoin.vim'
  " TODO Here's a list of plugins to tentatively remove. <ccg, 2019-04-21> "
  " Plug 'fatih/vim-go'
  " Plug 'goerz/ipynb_notedown.vim'
  " Plug 'aperezdc/vim-template'
  " Plug 'coltongrainger/vim-markdown'
call plug#end()

" Workaround for https://github.com/tpope/vim-sleuth/issues/29.
" Define autocmd as early as possible so other autocmds can override.
runtime! plugin/sleuth.vim

" Override ttimeoutlen later
runtime! plugin/sensible.vim

set nomodeline ignorecase smartcase showcmd noequalalways nojoinspaces ea noeb vb t_vb= 
set spellfile=~/.spell.en.utf-8.add wildmode=list:longest,full sidescroll=1

" `yay history!` --matze 
set formatprg=par\ -w80qes0

nnoremap Y y$
if has('autocmd')
  augroup vimrc
    autocmd!
    " I don't know if I have any files for which I need this autocmd. <ccg, 2019-04-21> "
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
    autocmd BufWritePost .vimrc source $HOME/.vimrc
    autocmd FileType cls setlocal filetype=tex
    autocmd FileType conf,gitcommit,mail,markdown,mediawiki,tex setlocal spell linebreak
    autocmd FileType crontab setlocal commentstring=#%s
    autocmd FileType gitignore setlocal commentstring=#\ %s
    autocmd FileType help,man,qf nnoremap <buffer> <silent> q :q<CR>
    autocmd FileType help,man setlocal nolist nospell
    " indentation defaults for written documents
    autocmd FileType mail,markdown,tex setlocal expandtab shiftwidth=4 tabstop=4 textwidth=0
    autocmd FileType mail,text,help setlocal comments=fb:*,fb:-,fb:+,n:>
    autocmd FileType make setlocal noexpandtab
    autocmd FileType tex let g:tex_fold_enabled=1
    " autocmd FileType tex setlocal conceallevel=1 
    " surround wrappers for TeX
    autocmd FileType tex let b:surround_{char2nr('M')} = "\\[\n\r\n\\]"
    autocmd FileType tex let b:surround_{char2nr('m')} = "\\(\r\\)"
    autocmd FileType tex let b:surround_{char2nr('Q')} = "``\r''"
    autocmd FileType tex let b:surround_{char2nr('q')} = "`\r'"
    autocmd FileType tex setlocal fillchars=fold:\ 
    " More aggressively check spelling in LaTeX; see
    " http://stackoverflow.com/questions/5860154/vim-spell-checking-comments-only-in-latex-files
    autocmd FileType tex syntax spell toplevel
    autocmd FileType vim setlocal keywordprg=:help
  augroup END
endif

colorscheme solarized
set background=light

let g:dispatch_terminal_exec='urxvt -e'

" :FZF to search for files.
" Similarly to {ctrlp.vim}{2}, use enter key, CTRL-T, CTRL-X or CTRL-V to open
" selected files in the current window, in new tabs, in horizontal splits, or in
" vertical splits respectively.
" default layout
" let g:fzf_layout = { 'down': '~40%' }
" default bindings
" let g:fzf_action = {
"   \ 'ctrl-t': 'tab split',
"   \ 'ctrl-x': 'split',
"   \ 'ctrl-v': 'vsplit' }

" administrivia for snippets and templates
let g:email='colton.grainger@colorado.edu'
let g:license='CC-0 Public Domain'
let g:snips_author='ccg'
let g:snips_email='colton.grainger@colorado.edu'
let g:snips_github='https://github.com/coltongrainger'
let g:templates_directory=['$HOME/.vim/templates']
let g:templates_no_builtin_templates=1
let g:templates_use_licensee=1
let g:UltiSnipsEditSplit="tabdo"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
let g:username='ccg'

" TeX syntax options.
let g:tex_flavor='latex'
" Conceal greek characters in TeX.
" let g:tex_conceal='g'

" vim-tex-fold.
" Provides additional fold environments, as opposed to vimtex's default
" folding. 
let g:tex_fold_override_foldtext=0
let g:tex_fold_additional_envs = [
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
" Don't fold. 
" \'itemize',
" \'enumerate',
" (These organize arguments, and are already nested in a foldable environment.)

" fastfold
let g:fastfold_fold_movement_commands = []
let g:fastfold_minlines=0
nmap <F5> <Plug>(FastFoldUpdate)

" vimtex
" disable options that (might) slow down insert mode
" let g:vimtex_syntax_enabled=0
let g:tex_fast = "mM"
let g:vimtex_fold_enabled=0
let g:vimtex_indent_enabled=0
let g:vimtex_matchparen_enabled=0
" continuous compilation options
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

" My common mistakes.
noremap <F2> :so ~/.vimrc<CR>
noremap <F3> :Start latex-help.sh<CR>
noremap <F4> :UltiSnipsEdit<CR>

" Give suggestions for last misspelled word.
noremap <C-S> [sz=

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

" Remap arrow keys to 'useful' things.
noremap <Left> <<
noremap <Right> >>
noremap <S-Up> :call DelEmptyLineBelow()<CR>
noremap <S-Down> :call AddEmptyLineBelow()<CR>
noremap <Up> :call DelEmptyLineAbove()<CR>
noremap <Down> :call AddEmptyLineAbove()<CR>

" I don't want to suspend my terminal.
nnoremap <C-z> <nop>

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

" TODO Remove all artifacts from the pandoc workflow. Commenting out for now
" to see what breaks. <ccg, 2019-04-21> "
" " https://retorque.re/zotero-better-bibtex/cayw/
" function! ZoteroCite()
"   " pick a format based on the filetype (customize at will)
"   let format = &filetype =~ '.*tex' ? 'pandoc' : 'pandoc'
"   let api_call = 'http://localhost:23119/better-bibtex/cayw?format='.format.'&brackets=1'
"   let ref = system('curl -s '.shellescape(api_call))
"   return ref
" endfunction
"
" " pandoc era hotkeys 2019-01-01
" nmap \pz ZoteroCite()<CR>p
" nmap \pc :Start pc.sh %<CR>
" nmap \pv :Dispatch! pv.sh %<CR>
