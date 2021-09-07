" use comma as <Leader> key instead of backslash
let mapleader=","

" If fzf is installed using git
set rtp+=~/.fzf
set rtp+=~/.vim/bundle/fzf.vim

nnoremap <leader>f :FZF<CR>

call plug#begin('~/.vim/plugged')
Plug 'drewtempelmeyer/palenight.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'rakr/vim-one'
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdcommenter'
Plug 'mattn/webapi-vim'
"Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
" assuming you're using vim-plug: https://github.com/junegunn/vim-plug
"Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'Chiel92/vim-autoformat'
Plug 'mhinz/vim-signify'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'Valloric/ListToggle'
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

" enable ncm2 for all buffers
"autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
"set completeopt=noinsert,menuone,noselect

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-path'
"Plug 'ncm2/ncm2-jedi'
"Plug 'ncm2/ncm2-go'
"Plug 'ncm2/ncm2-racer'
Plug 'https://github.com/Valloric/YouCompleteMe'
" Qt
Plug 'fedorenchik/qt-support.vim'
" Initialize plugin system
call plug#end()

" YCM stuff
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_complete_in_comments = 1

" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = "/usr/bin/clangd-11"

let g:pd_clangd_args_clangd_disabled = ['-cross-file-rename', '--clang-tidy=0']
let g:pd_clangd_args_clangd_enabled = ['-cross-file-rename', '--clang-tidy=1']
let g:pd_clang_tidy_enabled=0
let g:ycm_clangd_args = g:pd_clangd_args_clangd_disabled " Clang-tidy disabled by default



function ToggleClangTidy()
    if g:pd_clang_tidy_enabled
        let g:pd_clang_tidy_enabled=0
        let g:ycm_clangd_args = g:pd_clangd_args_clangd_disabled
    else
        let g:pd_clang_tidy_enabled=1
        let g:ycm_clangd_args = g:pd_clangd_args_clangd_enabled
    endif
endfunction

function PrintClangTidyStatus()
    if g:pd_clang_tidy_enabled
        echom "Clang-Tidy enabled"
    else
        echom "Clang-Tidy disabled"
    endif
endfunction

" Remap GoTo commands
nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <leader>gf :YcmCompleter FixIt<CR>
nnoremap <leader>gre :YcmCompleter RefactorRename
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>
nnoremap <leader>get :YcmCompleter GetType<CR>
nnoremap <leader>gim :YcmCompleter GoToImprecise<CR>

" Disable/Enable clang-tidy
nnoremap <leader>gt :call ToggleClangTidy() <CR> :YcmRestartServer <CR> :call PrintClangTidyStatus() <CR>

" Rust settings
let g:rustfmt_autosave = 1
let g:rust_cargo_check_tests = 1
let g:rust_clip_command = 'xclip -selection clipboard'

" Syntastic
set hidden          " don't save file every time we goto rust def
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set number                      "Line numbers are good
set ignorecase " We like finding things

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
