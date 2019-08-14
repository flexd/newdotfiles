" use comma as <Leader> key instead of backslash
let mapleader=","

" If fzf is installed using git
set rtp+=~/.fzf
set rtp+=~/.vim/bundle/fzf.vim

nnoremap <leader>f :FZF<CR>

call plug#begin('~/.vim/plugged')
"Plug 'drewtempelmeyer/palenight.vim'
Plug 'rakr/vim-one'
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdcommenter'
Plug 'mattn/webapi-vim'
Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'bling/vim-airline'
" assuming you're using vim-plug: https://github.com/junegunn/vim-plug
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-go'
Plug 'ncm2/ncm2-racer'
" Initialize plugin system
call plug#end()
" Rust settings
let g:rustfmt_autosave = 1
let g:rust_cargo_check_tests = 1
let g:rust_clip_command = 'xclip -selection clipboard'

" Syntastic
set hidden          " don't save file every time we goto rust def
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" keybinds
au FileType rust nmap <buffer> <C-t> :e#<CR>
au FileType rust nmap <C-]> <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)<Paste>

" Remove trailing whitespace on save
autocmd BufWritePre * call s:StripTrailing()
function! s:StripTrailing()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction
