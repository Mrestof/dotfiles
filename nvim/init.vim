" Plugins: {{{
  " load plugins
  lua require('plugins')
  " load lsp
  lua require('lsp')
" }}}
" Scripts: {{{
  source ~/.config/nvim/scripts/restore_view.vim
" }}}
" Binds: {{{
  let mapleader = ","
  nmap <leader>sv <Cmd>source $MYVIMRC<CR>

  nmap <Tab> <Cmd>bnext<CR>
  nmap <S-Tab> <Cmd>bprevious<CR>
  nmap <CR> <Cmd>w<CR>
  nmap \ <Cmd>:nohlsearch<CR>

  " dmitmel dotfiles: {{{
    " <C-i> is treated as <tab> in terminals, so the original function of <C-i>
    " is inaccessible when something is bound to <tab> (buffer switching in my
    " case). <C-n> and <C-p> are basically useless because they are equivalent
    " to j and k respectively, but now they go to newer or older recorded cursor
    " position in the jump list.
    nnoremap <C-n> <C-i>
    nnoremap <C-p> <C-o>
  " }}}

  nmap <C-h> <C-w>h
  nmap <C-j> <C-w>j
  nmap <C-k> <C-w>k
  nmap <C-l> <C-w>l
" }}}

" Auto: {{{
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
" }}}

" Visual: {{{
  " be more aware of current cursor position
  set number relativenumber
  set cursorline cursorcolumn

  " folding
  set foldmethod=marker

  " use 2 spaces for indentination
  set expandtab shiftwidth=2 tabstop=2 softtabstop=2
  " round indents to multiple of shiftwidth when using shift (< and >) commands
  set shiftround

  " be more verbose about file  content
  set list listchars=tab:<->,trail:¬,space:⋅,nbsp:%,extends:>,precedes:<
" }}}
" Search {{{
  set ignorecase
  set smartcase
" }}}
" Mouse {{{
  set mouse=a
" }}}
