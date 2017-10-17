  " Some Linux distributions set filetype in /etc/vimrc.
  " Clear filetype flags before changing runtimepath to force Vim to reload them.
  if exists("g:did_load_filetypes")
    filetype off
    filetype plugin indent off
  endif
  set runtimepath+=/usr/local/go/misc/vim " replace $GOROOT with the output of: go env GOROOT
  filetype plugin indent on
  syntax on
  let g:vim_markdown_folding_disabled=1
  set number
  set clipboard=unnamed
  set backspace=indent,eol,start
