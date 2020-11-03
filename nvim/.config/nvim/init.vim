set mouse=a
set number relativenumber
set nu rnu
set background=dark
set expandtab
set tabstop=2
set shiftwidth=2
set termguicolors

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:fzf_preview_window = 'right:60%'
let mapleader=" "

call plug#begin()
  if !exists('g:vscode')
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'drewtempelmeyer/palenight.vim'
    Plug 'mhinz/vim-signify'
    Plug 'tpope/vim-fugitive'
    Plug 'chemzqm/vim-jsx-improve'
    Plug 'leafgarland/typescript-vim'
    Plug 'peitalin/vim-jsx-typescript'
    Plug 'metakirby5/codi.vim'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'voldikss/vim-floaterm'
  endif
  Plug 'tpope/vim-surround'
call plug#end()

colorscheme palenight

function Colab()
  :tab
  :cd ~/gradient
  :term ./start.bash

  :tabnew 
  :cd ~/gradient/portal/static
  :term npm run build:rtf:watch

  :tabnew 
  :cd ~/gradient/portal/static
  :term npm run build:watch
endfunction

nmap <leader>a :CocCommand explorer<CR>
nmap <leader>s :CocCommand prettier.formatFile<cr>
nmap <leader>d :Rg<CR>
nmap <leader>f :GFiles<CR>
nmap <leader>r <Plug>(coc-rename)
nmap <leader>j :FloatermNew --autoclose=2 --name=doingstuff zsh<CR>
nmap <leader>k :tabnew<CR>
nmap <leader>c :call Colab()<CR>
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Random shit COC recommends
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

highlight htmlArg cterm=italic

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')
augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
