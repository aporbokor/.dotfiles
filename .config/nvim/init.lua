-- Concise way to escape termcodes
local function t(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.g.mapleader = t'<Space>'
vim.g.maplocalleader = t'<Space>'

vim.fn['plug#begin']()

-- Navigation plugins
vim.cmd [[Plug 'rbgrouleff/bclose.vim']]
vim.cmd [[Plug 'preservim/nerdtree']]

-- UI Plugins
vim.cmd [[Plug 'vim-airline/vim-airline']]
vim.cmd [[Plug 'vim-airline/vim-airline-themes']]
vim.cmd [[Plug 'bling/vim-bufferline']]
vim.cmd [[Plug 'altercation/vim-colors-solarized']]

-- Editor plugins
vim.cmd [[Plug 'Raimondi/delimitMate']]
vim.cmd [[Plug 'preservim/nerdcommenter']]
vim.cmd [[Plug 'tpope/vim-sleuth']]
vim.cmd [[Plug 'airblade/vim-gitgutter']]
vim.cmd [[Plug 'editorconfig/editorconfig-vim']]

vim.cmd [[Plug 'junegunn/fzf']]
vim.cmd [[Plug 'junegunn/fzf.vim']]

vim.cmd [[Plug 'neovim/nvim-lspconfig']]
vim.cmd [[Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}]]
vim.cmd [[Plug 'nvim-treesitter/playground']]
vim.cmd [[Plug 'hrsh7th/nvim-cmp']]
vim.cmd [[Plug 'hrsh7th/cmp-buffer']]
vim.cmd [[Plug 'hrsh7th/cmp-path']]
vim.cmd [[Plug 'hrsh7th/cmp-cmdline']]
-- vim.cmd [[Plug 'hrsh7th/cmp-nvim-lsp']]
vim.cmd [[Plug 'hrsh7th/cmp-vsnip']]
vim.cmd [[Plug 'hrsh7th/vim-vsnip']]

vim.cmd [[Plug 'tpope/vim-fugitive']]

--vim.cmd [[Plug 'github/copilot.vim']]
--vim.cmd [[Plug 'hrsh7th/cmp-copilot']]

-- Language specific
--TODO
vim.cmd [[Plug 'lervag/vimtex', { 'for': 'tex' }]]
vim.cmd [[Plug 'vim-pandoc/vim-pandoc']]
vim.cmd [[Plug 'Vimjas/vim-python-pep8-indent']]
vim.cmd [[Plug 'maxmellon/vim-jsx-pretty']]
vim.cmd [[Plug 'iden3/vim-circom-syntax']]
vim.cmd [[Plug 'tmhedberg/SimpylFold']]

-- Note taking
vim.cmd [[Plug 'lukaszkorecki/workflowish']]

vim.fn['plug#end']()

vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = false
vim.opt.number = true
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.title = true
vim.opt.joinspaces = false
vim.opt.mouse = 'a'
vim.opt.laststatus = 2

vim.opt.conceallevel = 2
vim.opt.list = true
vim.opt.listchars = {
    tab = '» ',
    trail = '␣',
    extends = '▶',
    precedes = '◀',
}

vim.opt.undofile = true


vim.opt.autoread = true
-- vim.cmd [[autocmd BufEnter,FocusGained * if mode() == 'n' && getcmdwintype() == '' | checktime | endif]]

-- Update gutters 200 ms
vim.opt.updatetime = 200

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.cindent = true
vim.opt.cinoptions = {'N-s', 'g0', 'j1', '(s', 'm1'}

-- Searching options
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Redefine * and # to obey smartcase
vim.api.nvim_set_keymap('n', '*', [[/\<<C-R>=expand('<cword>')<CR>\><CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '#', [[?\<<C-R>=expand('<cword>')<CR>\><CR>]], { noremap = true })
-- Map <CR> to :nohl, except in quickfix windows
vim.cmd [[nnoremap <silent> <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : ":nohl\<CR>"]]

vim.api.nvim_set_keymap('n', 'gA', ':%y+<CR>', { noremap = true })

vim.opt.hidden = false
-- Necessary for terminal buffers not to die
vim.cmd [[autocmd TermOpen * set bufhidden=hide]]

-- Write out files with sudo
-- TODO: This doesn't work in nvim because ! is not interactive
--vim.cmd [[cmap w!! w !sudo tee > /dev/null %]]

vim.g.delimitMate_expand_cr = 1
vim.cmd [[autocmd FileType tex let b:delimitMate_autoclose = 0]]

vim.g.airline_powerline_fonts = 1
vim.g.bufferline_rotate = 1
vim.g.bufferline_fixed_index = -1
vim.g.bufferline_echo = 0

vim.g.solarized_visibility = 'low'
vim.opt.background = 'dark'
vim.cmd [[colorscheme solarized]]

vim.cmd [[highlight! link SignColumn LineNr]]

vim.opt.spellfile = vim.fn.stdpath('config') .. '/spell/en.utf-8.add'

-- GCC quickfix stuff?
-- TODO: why is this necessary again?
-- TODO: why doesn't the Lua form work?
--vim.opt.errorformat:prepend{[[%-GIn file included %.%#]]}
vim.cmd [[set errorformat^=%-GIn\ file\ included\ %.%#]]

vim.g.NERDAltDelims_c = 1

vim.api.nvim_set_keymap("n", "<Leader>n", "<Cmd>NERDTreeClose<CR><Cmd>silent! NERDTreeFind<CR><Cmd>NERDTreeFocus<CR>", { silent=true, noremap=true })

vim.g.fzf_command_prefix = 'Fzf'
vim.api.nvim_set_keymap("n", "<Leader><Space>", "<Cmd>call fzf#vim#gitfiles('-co --exclude-standard')<CR>", { silent=true, noremap=true })
vim.api.nvim_set_keymap("n", "<Leader>f", "<Cmd>FzfRg<CR>", { silent=true, noremap=true })

-- Treesitter

local treesitter = require('nvim-treesitter.configs')

-- Use a fork
local treesitter_parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
--treesitter_parser_configs.cpp = {
--  install_info = {
--    url = "~/dev/tree-sitter-cpp",
--    files = { "src/parser.c", "src/scanner.cc" },
--    generate_requires_npm = true,
--  },
--  maintainers = { "@theHamsta" },
--}

treesitter.setup {
    ensure_installed = 'all',
    highlight = { enable = true, additional_vim_regex_highlighting = true },
    --indent = { enable = true },
}

--vim.opt.foldmethod = 'expr'
--vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
--vim.opt.foldlevel = 1

vim.opt.foldmethod = 'syntax'

-- Completion
--
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local cmp = require('cmp')
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.mapping.confirm({ select = false }), -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- LSP
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}



------------------------------
-- Language specific config --
------------------------------

-- LaTeX configuration
vim.g.tex_flavor = 'latex'
vim.g.vimtex_compiler_progname = 'nvr'
--vim.g.vimtex_quickfix_latexlog = { fix_paths = 0 }
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_open_on_warning = 0

vim.opt.printoptions:append{ paper = 'letter' }

vim.cmd [[autocmd BufNewFile,BufReadPost *.sol set filetype=solidity]]

vim.cmd [[autocmd BufNewFile,BufReadPost *.md set filetype=pandoc]]

--C++ configuration
vim.cmd [[autocmd BufNewFile *.cpp 0r ~/Templates/template.cpp]]
vim.cmd [[set makeprg=g++\ -static\ -DDEBUG\ -lm\ -s\ -x\ c++\ -Wall\ -Wextra\ -O2\ -std=c++17\ -o\ %:r\ %]]
vim.cmd [[autocmd filetype cpp nnoremap <F9> :w <bar> :make <CR>]]

-- Python configuration
-- TODO
-- vim.cmd [[autocmd BufNewFile * .py 0r ~/Templates/template.py]]

-- Racket configuration
-- vim.cmd [[autocmd BufNewFile * .rkt 0r ~/Templates/template.rkt]]

vim.g['airline#extensions#wordcount#enabled'] = 1
vim.g['airline#extensions#wordcount#filetypes'] = { 'help', 'markdown', 'rst', 'org', 'text', 'asciidoc', 'tex', 'mail', 'pandoc' }

vim.g['pandoc#formatting#mode'] = 'h'
vim.g['pandoc#formatting#textwidth'] = 80
