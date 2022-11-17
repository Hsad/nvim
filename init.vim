" This is for another plugin system, but I'm gonna try to stick to vim Plug
" since most of the examples from zig are using that.  
" The lua/plugins.lua file is from that other plugin system, might just want
" to nuke that one...
" lua require("plugins")

nmap <space>w :w<cr>
imap jk <esc>


" Zig language server stuff
call plug#begin('~/.config/nvim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'ziglang/zig.vim'
call plug#end()

:lua << EOF
    local lspconfig = require('lspconfig')

    local on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        require('completion').on_attach()
    end

    local servers = {'zls'}
    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
            on_attach = on_attach,
        }
    end
EOF

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Enable completions as you type
let g:completion_enable_auto_popup = 1

" Autocomplete driven by tabs
" inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<C-n>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-x><C-o>"
inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

function! Tab_Or_Complete()
  if pumvisible()
    return "\<C-n>"
  else
    if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
      return "\<C-n>"
    else
      return "\<Tab>"
    endif
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>









