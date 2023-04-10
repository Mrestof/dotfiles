" TODO: load lua configs and scripts from repo, not from user's configs
"
" First priority: {{{
  " make sure everyone knows the leader!
  let mapleader = "\<Space>"
" }}}
" Lua: {{{
  " Plugins: {{{
    " load plugins
    lua require('plugins')
    " load lsp
    lua require('lsp')
  " }}}
  " load second part of config on lua
  lua require('secondary_setup')
" }}}
" Scripts: {{{
  source ~/.config/nvim/scripts/restore_view.vim
" }}}
" Binds: {{{
  nmap <leader>sv <Cmd>source $MYVIMRC<CR>

  nmap <Tab> <Cmd>bnext<CR>
  nmap <S-Tab> <Cmd>bprevious<CR>
  nmap <Bslash> <Cmd>:nohlsearch<CR>

  " dmitmel dotfiles: {{{
    " <C-i> is treated as <tab> in terminals, so the original function of <C-i>
    " is inaccessible when something is bound to <tab> (buffer switching in my
    " case). <C-n> and <C-p> are basically useless because they are equivalent
    " to j and k respectively, but now they go to newer or older recorded cursor
    " position in the jump list.
    nnoremap <C-n> <C-i>
    nnoremap <C-p> <C-o>

    " TODO: do the suppression not in a cringe way

    " arguably one of the most useful mappings
    nnoremap <silent><expr> <CR> empty(&buftype) ? ":call \<SID>write_this_and_write_all()\<CR>" : "\<CR>"
    function s:write_this_and_write_all() abort
      " The `abort` in this function is necessary because it will prevent a second
      " attempt of writing from :wall from occuring had the first :write failed.
      try
        write
        " HACK: try to suppress the write to all buffers at the same time
        ":wall
      catch /^Vim(\%(write\|wall\)):/
        echohl ErrorMsg
        echomsg v:exception
        echohl None
      endtry
    endfunction
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
  set nofoldenable
  set foldmethod=marker

  " use 2 spaces for indentination
  set expandtab shiftwidth=2 tabstop=2 softtabstop=2
  " round indents to multiple of shiftwidth
  "   when using shift (< and >) commands
  set shiftround

  " be more verbose about file  content
  set list listchars=tab:<->,trail:¬,space:⋅,nbsp:%,extends:>,precedes:<

  " Don't save:
  " - :set options in the files created with :mksession and :mkview
  " - current directory, so that user can configure grep to know the scope 
  "   of search better
  set sessionoptions-=options viewoptions-=options
  set sessionoptions-=curdir viewoptions-=curdir

  " mark width boundary:
  " - my preferred wigth: 80
  " - general preferred width: 'textwidth'+1
  set colorcolumn=+1,81
" }}}
" Search {{{
  set ignorecase
  set smartcase
" }}}
" Mouse {{{
  set mouse=a
" }}}
