" Comment the following line if you don't want Vim and NeoVim to share the
" same plugin download directory.
let g:spacevim_plug_home = '~/.vim/plugged'

" Uncomment the following line to override the leader key. The default value is space key "<\Space>".
" let g:spacevim_leader = "<\Space>"

" Uncomment the following line to override the local leader key. The default value is comma ','.
" let g:spacevim_localleader = ','

" Enable the existing layers in space-vim.
" Refer to https://github.com/liuchengxu/space-vim/blob/master/layers/LAYERS.md for all available layers.
"      \ 'fzf', 'better-defaults', 'which-key',
    " \ 'fzf', 'better-defaults', 'which-key', 'editing', 'formatting', 'markdown',  'programming', 
let g:spacevim_layers = [
    \ 'fzf',  'which-key',  'markdown', 'editing', 'formatting', 'programming',
      \ ]

" Uncomment the following line if your terminal(-emulator) supports true colors.
" let g:spacevim_enable_true_color = 1

" Uncomment the following if you have some nerd font installed.
" let g:spacevim_nerd_fonts = 1

" If you want to have more control over the layer, try using Layer command.
" if g:spacevim.gui
"   Layer 'airline'
" endif

" Manage your own plugins.
" Refer to https://github.com/junegunn/vim-plug for more detials.
function! UserInit()

  " Add your own plugin via Plug command.
  " Plug 'scrooloose/nerdtree'
  " Plug 'neowit/vim-force.com'
  Plug 'liuchengxu/eleline.vim'
  Plug 'junegunn/seoul256.vim'
  Plug 'mg979/vim-visual-multi'
  Plug 'jiangmiao/auto-pairs'
  Plug 'nathanaelkane/vim-indent-guides'
""sheerun/vim-polyglot
  Plug 'skywind3000/asyncrun.vim'
  " Plug 'chr4/nginx.vim'
  Plug 'tmhedberg/SimpylFold'
  Plug 'Konfekt/FastFold'
  Plug 'kopischke/vim-stay'
  Plug 'mhinz/vim-signify'
  Plug 'mhinz/vim-startify'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  " Plug 'christoomey/vim-tmux-navigator'
  Plug 'romainl/vim-qf'
  Plug 'dbeniamine/cheat.sh-vim'
  Plug 'vim-test/vim-test'
  Plug 'easymotion/vim-easymotion'
  Plug 'junegunn/vim-easy-align'
  Plug 'zackhsi/fzf-tags'
  Plug 'dense-analysis/ale'
  Plug 'tpope/vim-obsession'
  Plug 'AndrewRadev/bufferize.vim'
  Plug 'scrooloose/vim-slumlord'
  Plug 'aklt/plantuml-syntax'
  " Plug 'fholgado/minibufexpl.vim'
  Plug 'ap/vim-buftabline'
  Plug 'djoshea/vim-autoread'
  " Plug 'SirVer/ultisnips'
  " Plug 'honza/vim-snippets'
  Plug 'github/copilot.vim'
  Plug 'mechatroner/rainbow_csv'
  " Plug 'maralla/completor.vim'
	" Plug 'numirias/semshi'
  " Plug 'neoclide/coc.nvim'
  " Plug 'ncm2/ncm2'


endfunction

" Override the default settings from space-vim as well as adding extras
function! UserConfig()

  " Override the default settings.
  " Uncomment the following line to disable relative number.
  " set norelativenumber


  autocmd bufwritepost .vimrc source $MYVIMRC
  autocmd bufwritepost .spacevim source $MYVIMRC
  " Adding extras.
  " Uncomment the following line If you have installed the powerline fonts.
  " It is good for airline layer.
  let g:airline_powerline_fonts = 1
  set laststatus=2
  " Execute current line or current selection as Vim EX commands.
  nnoremap <F2> :exe '!'.getline(".")<CR>
  vnoremap <F2> :<C-w>exe '!'.join(getline("'<","'>"),'<Bar>')<CR>
  " nnoremap <silent> <Leader>x :exe '!'.getline(".")<CR>
  " xnoremap <silent> <Leader>x :<C-w>exe '!'.join(getline("'<","'>"),'<Bar>')<CR>
  nnoremap <silent> <Leader>l :exe 'AsyncRun '.getline(".")<CR>
  xnoremap <silent> <Leader>l :<C-w> exe 'AsyncRun '.join(getline("'<","'>"),'<Bar>')<CR>

  nmap <c-s> :w<CR>
  imap <c-s> <Esc>:w<CR>a

  inoremap <leader>ss :write <CR>
  nnoremap <F5> :call <SID>compile_and_run()<CR>
  nnoremap <silent> <Leader>x :call <SID>compile_and_run()<CR>
  nnoremap <silent> <Leader>gc :Git commit -am 'updates'<CR>:Git push<CR>

  " let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsExpandTrigger="<c-l>"
" list all snippets for current filetype
  let g:UltiSnipsListSnippets="<Leader>hh"

  " set guifont=Fira\ Code:h12
  set clipboard+=unnamedplus
  " dangerous
  " set paste
  set go+=amT

  imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
  " imap <silent><script><expr> <TAB> copilot#Accept()
  " imap <silent><script><expr> <C-l> copilot#Accept()
  " let g:copilot_no_tab_map = v:true

  " inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  " inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

  function! s:compile_and_run()
  exec 'w'
  if &filetype == 'c'
  exec "AsyncRun! gcc % -o %<; time ./%<"
  elseif &filetype == 'cpp'
  exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
  elseif &filetype == 'java'
  exec "AsyncRun! javac %; time java %<"
  elseif &filetype == 'sh'
  exec "AsyncRun! time bash %"
  elseif &filetype == 'python'
  exec "AsyncRun! time python -u %"
  endif
  endfunction



  " set statusline=%{LinterStatus()}
  set autoread
  nmap <silent> <leader>aj :ALENext<cr>
  nmap <silent> <leader>ak :ALEPrevious<cr>
  nmap <silent> ]n :ALENext<cr>
  nmap <silent> [n :ALEPrevious<cr>

  " Execute current line or current selection as Vim EX commands.
  nnoremap <F2> :exe '!'.getline(".")<CR>
  vnoremap <F2> :<C-w>exe '!'.join(getline("'<","'>"),'<Bar>')<CR>
  nmap <c-s> :w<CR>
  imap <c-s> <Esc>:w<CR>a
  set tags=~/.tags
  let g:python3_host_prog='/work/anaconda3/bin/python3'
  setlocal foldmethod=expr
  if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m

  nmap zuz <Plug>(FastFoldUpdate)
  let g:fastfold_savehook = 1
  let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
  let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
  let g:markdown_folding = 1
  let g:vimsyn_folding = 'af'
  let g:xml_syntax_folding = 1
  let g:javaScript_fold = 1
  let g:python_fold= 1
  let g:php_folding = 1

  let g:fzf_tags_command = 'ctags -R'
  au BufReadPost *.spacevim set syntax=vim

  set iskeyword+=-
  set autochdir

  endif

endfunction
