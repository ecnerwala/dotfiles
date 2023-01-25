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
vim.cmd [[Plug 'scrooloose/nerdtree']]

-- UI Plugins
vim.cmd [[Plug 'vim-airline/vim-airline']]
vim.cmd [[Plug 'vim-airline/vim-airline-themes']]
vim.cmd [[Plug 'bling/vim-bufferline']]
vim.cmd [[Plug 'altercation/vim-colors-solarized']]

-- Editor plugins
vim.cmd [[Plug 'Raimondi/delimitMate']]
vim.cmd [[Plug 'scrooloose/nerdcommenter']]
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
vim.cmd [[Plug 'hrsh7th/cmp-nvim-lsp']]
vim.cmd [[Plug 'hrsh7th/cmp-vsnip']]
vim.cmd [[Plug 'hrsh7th/vim-vsnip']]

vim.cmd [[Plug 'tpope/vim-fugitive']]

vim.cmd [[Plug 'Exafunction/codeium.vim']]

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
    leadmultispace = '·',
    trail = '␣',
    extends = '▶',
    precedes = '◀',
    nbsp = '␣',
}

vim.opt.undofile = true

vim.opt.autoread = true
vim.cmd [[autocmd BufEnter,FocusGained * if mode() == 'n' && getcmdwintype() == '' | checktime | endif]]

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

if vim.env.TERM == 'rxvt' or vim.env.TERM == 'termite' or vim.env.TERM == 'alacritty' or vim.env.TERM == 'xterm-kitty' then
  vim.g.solarized_visibility = 'low'
  vim.opt.background = 'dark'
  vim.cmd [[colorscheme solarized]]
end

vim.cmd [[highlight! link SignColumn LineNr]]
vim.cmd [[highlight NonText ctermfg=10 cterm=NONE]]

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

local nvim_lsp = require('lspconfig')

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
      spacing = 8,
      severity_limit = "Error",
    },
    signs = false,
    update_in_insert = false,
  }
)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local lsp_on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

  -- Workspace management
  buf_set_keymap('n', '<Leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  buf_set_keymap('n', '<Leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>lf', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<Leader>le', '<cmd>lua vim.diagnostic.open_float({scope="c"})<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Leader>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', '<Leader>lw', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  else
    buf_set_keymap('n', '<Leader>lw', '<cmd>echom "LSP formatting not supported"<CR>', opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('v', '<Leader>lw', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  else
    buf_set_keymap('v', '<Leader>lw', '<cmd>echom "LSP range formatting not supported"<CR>', opts)
  end

  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    ]]
  end
end

vim.cmd [[highlight LspReferenceText cterm=bold guibg=LightYellow]]
vim.cmd [[highlight LspReferenceRead cterm=bold ctermbg=0 guibg=LightYellow]]
vim.cmd [[highlight LspReferenceWrite cterm=bold ctermbg=0 guibg=LightYellow]]

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.offsetEncoding = "utf-8"

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "clangd", "tsserver", "pyright", "rust_analyzer", "gopls", "solc" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = lsp_on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  }
end

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

vim.g['airline#extensions#wordcount#enabled'] = 1
vim.g['airline#extensions#wordcount#filetypes'] = { 'help', 'markdown', 'rst', 'org', 'text', 'asciidoc', 'tex', 'mail', 'pandoc' }

vim.g['pandoc#formatting#mode'] = 'h'
vim.g['pandoc#formatting#textwidth'] = 80

-- Hashing for ICPC book
vim.cmd [[
command -range=% -nargs=1 P exe "<line1>,<line2>!".<q-args> | y | sil u | echom @"
command -range=% Hash <line1>,<line2>P cpp -P -fpreprocessed | tr -d '[:space:]' | md5sum
autocmd FileType cpp com! -buffer -range=% Hash <line1>,<line2>P cpp -P -fpreprocessed | tr -d '[:space:]' | md5sum
]]
