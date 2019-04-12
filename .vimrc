" I borrowed most of this config on 2017-10-01 from
" https://github.com/riceissa/dotfiles

scriptencoding utf-8
set nocompatible

" Use vim-plug to manage Vim plugins. Install with
"     curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Once all Vim config files are in the right places, just do :PlugInstall in
" Vim to install the plugins.
call plug#begin('~/.vim/plugged')
Plug 'AndrewRadev/splitjoin.vim'
"Plug 'dbeniamine/vim-mail'
"Plug 'dbeniamine/cheat.sh-vim'
Plug 'coltongrainger/vim-markdown'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'goerz/ipynb_notedown.vim'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/gv.vim'
Plug 'lervag/vimtex', {'for': 'tex'}
"Plug 'ludovicchabant/vim-gutentags'
Plug 'nelstrom/vim-visual-star-search'
Plug 'riceissa/vim-dualist'
Plug 'riceissa/vim-inclusivespace'
Plug 'riceissa/vim-longmove'
Plug 'riceissa/vim-mediawiki'
Plug 'riceissa/vim-more-toggling'
Plug 'riceissa/vim-pasteurize'
Plug 'riceissa/vim-proselint'
Plug 'riceissa/vim-rsi'
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
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'aperezdc/vim-template'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

" Workaround for https://github.com/tpope/vim-sleuth/issues/29 to override
" sleuth.vim for some filetypes.
runtime! plugin/sleuth.vim

" Override ttimeoutlen later
runtime! plugin/sensible.vim

set nomodeline ignorecase smartcase showcmd noequalalways nojoinspaces ea number
set spellfile=~/.spell.en.utf-8.add wildmode=list:longest,full sidescroll=1
set formatprg=par\ -w72qe

nnoremap Y y$

if has('autocmd')
  augroup vimrc
    autocmd!
    autocmd bufwritepost .vimrc source $HOME/.vimrc
    autocmd FileType conf,gitcommit,mail,markdown,mediawiki,tex setlocal spell linebreak
    " outgoing emails hard wrap
    autocmd FileType mail,text,help setlocal comments=fb:*,fb:-,fb:+,n:>
    " we set a buffer-local variable to track if we have already run the autocmd so it
    " only runs once. Otherwise if we leave the buffer and come back, the
    " autocmd would run again.
    " also .md as filetype tex (for now 2019-04-10)
    autocmd FileType mail,tex,markdown if !exists('b:did_vimrc_markdown_textwidth_autocmd') | setlocal expandtab shiftwidth=4 tabstop=4 textwidth=0 filetype=tex | let b:did_vimrc_markdown_textwidth_autocmd = 1 | endif
    autocmd FileType crontab setlocal commentstring=#%s
    autocmd FileType gitconfig setlocal commentstring=#%s
    autocmd FileType help,man nnoremap <buffer> <silent> q :q<CR>
    autocmd FileType help,man setlocal nolist nospell
    autocmd FileType make setlocal noexpandtab
    " Prevent overzealous autoindent in align environment
    autocmd FileType tex setlocal indentexpr=
    autocmd FileType tex let b:surround_{char2nr('m')} = "\\(\r\\)"
    autocmd FileType tex let b:surround_{char2nr('M')} = "\\[\n\r\n\\]"
    " More aggressively check spelling in LaTeX; see
    " http://stackoverflow.com/questions/5860154/vim-spell-checking-comments-only-in-latex-files
    autocmd FileType tex syntax spell toplevel
    autocmd FileType vim setlocal keywordprg=:help
  augroup END
endif

let g:tex_flavor = 'latex'
let g:airline_theme='solarized'

let g:markdown_fenced_languages = ['python', 'haskell']
let g:templates_directory=['$HOME/.vim/templates']
let g:templates_use_licensee=1
let g:templates_no_builtin_templates=1
let g:license='CC0'
let g:username='Colton Grainger'
let g:email='colton.grainger@colorado.edu'

"vim-dispatch
"nnoremap <F9> :Dispatch<CR>

"https://github.com/scrooloose/nerdtree
map <C-n> :NERDTreeToggle<CR>

"pandoc continuous compilation
let g:dispatch_terminal_exec='urxvt -e'
nmap \pc :Start pc.sh %<CR>
"open mupdf if pdf exists
nmap \pv :Dispatch! pv.sh %<CR>

"paste time
:nnoremap <F5> "=strftime("%F")<CR>P
:inoremap <F5> <C-R>=strftime("%F")<CR>

" This inserts the citation at the cursor using the shortcut ctrl-z (in
" insert mode) or <leader>z (in normal, visual etc. modes, <leader> being
" backslash by default).
" https://retorque.re/zotero-better-bibtex/cayw/
function! ZoteroCite()
  " pick a format based on the filetype (customize at will)
  let format = &filetype =~ '.*tex' ? 'pandoc' : 'pandoc'
  let api_call = 'http://localhost:23119/better-bibtex/cayw?format='.format.'&brackets=1'
  let ref = system('curl -s '.shellescape(api_call))
  return ref
endfunction

nmap \pz ZoteroCite()<CR>p

"UtilSnips
nnoremap <C-z> <nop>
" Trigger configuration.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

"ctags shortcuts
"map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
"map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

highlight Folded ctermfg=DarkGray ctermbg=LightGray cterm=bold,underline

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k
