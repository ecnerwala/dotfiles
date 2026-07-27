require('vim._core.ui2').enable({})

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Run :lua vim.pack.update() to update
vim.pack.add({
  -- Navigation plugins
  'https://github.com/rbgrouleff/bclose.vim',
  'https://github.com/preservim/nerdtree',

  -- UI Plugins
  'https://github.com/vim-airline/vim-airline',
  'https://github.com/vim-airline/vim-airline-themes',
  'https://github.com/bling/vim-bufferline',

  --'https://github.com/altercation/vim-colors-solarized',
  --'https://github.com/overcache/NeoSolarized',
  { src = 'https://github.com/lifepillar/vim-solarized8', version = 'neovim' },

  -- Editor plugins
  'https://github.com/Raimondi/delimitMate',
  'https://github.com/scrooloose/nerdcommenter',
  'https://github.com/tpope/vim-sleuth',
  'https://github.com/airblade/vim-gitgutter',

  'https://github.com/junegunn/fzf',
  'https://github.com/junegunn/fzf.vim',

  'https://github.com/neovim/nvim-lspconfig',

  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },

  'https://github.com/tpope/vim-fugitive',

  --'https://github.com/Exafunction/codeium.vim',

  --'https://github.com/github/copilot.vim',

  -- Language specific
  --TODO
  'https://github.com/lervag/vimtex',
  'https://github.com/vim-pandoc/vim-pandoc',
  'https://github.com/Vimjas/vim-python-pep8-indent',
  'https://github.com/maxmellon/vim-jsx-pretty',
  'https://github.com/iden3/vim-circom-syntax',
  'https://github.com/tmhedberg/SimpylFold',

  -- Note taking
  'https://github.com/lukaszkorecki/workflowish',
})

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
    leadmultispace = '· ',
    trail = '␣',
    extends = '▶',
    precedes = '◀',
    nbsp = '␣',
}

vim.opt.undofile = true

vim.opt.autoread = true
vim.cmd [[autocmd BufEnter,FocusGained * if mode() == 'n' && getcmdwintype() == '' | checktime | endif]]

vim.cmd [[
function! Syn()
  for id in synstack(line("."), col("."))
    echo synIDattr(id, "name")
  endfor
endfunction
command! -nargs=0 Syn call Syn()
]]

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
vim.keymap.set('n', '*', [[/\<<C-R>=expand('<cword>')<CR>\><CR>]])
vim.keymap.set('n', '#', [[?\<<C-R>=expand('<cword>')<CR>\><CR>]])
-- Map <CR> to :nohl, except in quickfix windows
vim.keymap.set('n', '<CR>', function()
  return vim.bo.buftype == 'quickfix' and '<CR>' or '<Cmd>nohl<CR>'
end, { expr = true })

vim.keymap.set('n', 'gA', '<Cmd>%y+<CR>')

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

if vim.env.TERM == 'rxvt' or vim.env.TERM == 'termite' or vim.env.TERM == 'alacritty' or vim.env.TERM == 'xterm-kitty' or vim.env.TERM_PROGRAM == 'iTerm.app' then
  vim.g.solarized_visibility = 'low'
  --vim.g.neosolarized_contrast = 'normal'
  vim.opt.background = 'light'
  --vim.cmd [[colorscheme solarized]]
  --vim.cmd [[colorscheme NeoSolarized]]
  vim.cmd [[colorscheme solarized8]]
end

-- Fix airline: https://github.com/vim-airline/vim-airline/issues/2693
vim.cmd [[highlight statusline cterm=NONE gui=NONE]]
vim.cmd [[highlight tabline cterm=NONE gui=NONE]]
vim.cmd [[highlight winbar cterm=NONE gui=NONE]]

vim.cmd [[highlight! link SignColumn LineNr]]
-- Hack to fix tensor
vim.cmd [[highlight! link cErrInBracket cBracket]]
vim.cmd [[highlight NonText ctermfg=10 cterm=NONE]]

vim.opt.spellfile = vim.fn.stdpath('config') .. '/spell/en.utf-8.add'

-- GCC quickfix stuff?
-- TODO: why is this necessary again?
-- TODO: why doesn't the Lua form work?
--vim.opt.errorformat:prepend{[[%-GIn file included %.%#]]}
vim.cmd [[set errorformat^=%-GIn\ file\ included\ %.%#]]

vim.g.NERDAltDelims_c = 1

vim.keymap.set("n", "<Leader>n", "<Cmd>NERDTreeClose<CR><Cmd>silent! NERDTreeFind<CR><Cmd>NERDTreeFocus<CR>")

vim.g.fzf_command_prefix = 'Fzf'
vim.keymap.set("n", "<Leader><Space>", "<Cmd>call fzf#vim#gitfiles('-co --exclude-standard')<CR>")
vim.keymap.set("n", "<Leader>f", "<Cmd>FzfRg<CR>")
vim.keymap.set("n", "<Leader>b", "<Cmd>FzfBuffers<CR>")

-- Treesitter

-- Try to start treesitter for all buffer types
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    if pcall(vim.treesitter.start, args.buf) then
      vim.wo[0][0].foldmethod = 'expr'
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end
  end,
})
-- Use :InspectTree to inspect the current file

--vim.opt.foldlevel = 1
vim.o.foldmethod = 'syntax'

-- Completion
--
-- Prefer omnifunc, then up to 5 keyword matches from the current buffer
vim.o.complete = 'o,.^5'
vim.o.autocomplete = true
vim.o.autocompletedelay = 150
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup' }

-- LSP

--vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  --vim.lsp.diagnostic.on_publish_diagnostics, {
    --underline = true,
    --virtual_text = {
      --spacing = 8,
      --min = vim.diagnostic.severity.ERROR,
    --},
    --signs = false,
    --update_in_insert = false,
  --}
--)

vim.diagnostic.config({
  underline = true,
  virtual_text = {
    spacing = 8,
    min = vim.diagnostic.severity.ERROR,
  },
  signs = false,
  update_in_insert = false,
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local lsp_on_attach = function(client, bufnr)
  -- Mappings.
  local opts = { buffer = bufnr }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, nowait = true })
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)

  -- Workspace management
  vim.keymap.set('n', '<Leader>lwa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<Leader>lwr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<Leader>lwl', function() vim.print(vim.lsp.buf.list_workspace_folders()) end, opts)

  vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<Leader>le', function() vim.diagnostic.open_float({scope="c"}) end, opts)
  vim.keymap.set('n', '<Leader>lq', vim.diagnostic.setloclist, opts)

  if client:supports_method('textDocument/formatting') then
    vim.keymap.set('n', '<Leader>lw', vim.lsp.buf.format, opts)
  else
    vim.keymap.set('n', '<Leader>lw', function() vim.notify('LSP formatting not supported') end, opts)
  end
  if client:supports_method('textDocument/rangeFormatting') then
    vim.keymap.set('v', '<Leader>lw', vim.lsp.buf.format, opts)
  else
    vim.keymap.set('v', '<Leader>lw', function() vim.notify('LSP range formatting not supported') end, opts)
  end

  if client:supports_method('textDocument/documentHighlight') then
    vim.cmd [[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    ]]
  end

  if client:supports_method('textDocument/completion') then
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
  end
end

vim.cmd [[highlight LspReferenceText cterm=bold guibg=LightYellow]]
vim.cmd [[highlight LspReferenceRead cterm=bold ctermbg=0 guibg=LightYellow]]
vim.cmd [[highlight LspReferenceWrite cterm=bold ctermbg=0 guibg=LightYellow]]

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "clangd", "ts_ls", "pyright", "gopls" }
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, { on_attach = lsp_on_attach })
  vim.lsp.enable(lsp)
end

vim.lsp.config("solc", {
  on_attach = lsp_on_attach,
  root_markers = {'hardhat.config.ts', 'hardhat.config.js', 'foundry.toml', '.git'}
})
vim.lsp.enable("solc")

vim.lsp.config("rust_analyzer", {
  on_attach = lsp_on_attach,
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        disabled = { "unresolved-proc-macro" },
      },
    }
  }
})
vim.lsp.enable("rust_analyzer")

vim.lsp.config("kotlin_language_server", {
  on_attach = lsp_on_attach,
  root_markers = { 'settings.gradle', 'Makefile' }
})
vim.lsp.enable("kotlin_language_server")

------------------------------
-- Language specific config --
------------------------------

-- LaTeX configuration
vim.g.tex_flavor = 'latex'
vim.g.vimtex_compiler_progname = 'nvr'
--vim.g.vimtex_quickfix_latexlog = { fix_paths = 0 }
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_open_on_warning = 0

--vim.opt.printoptions:append{ paper = 'letter' }

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
