--== T H E M E ==--

vim.cmd.packadd('catppuccin')
require('catppuccin').setup({ show_end_of_buffer = true })
vim.cmd.colorscheme 'catppuccin-mocha'
vim.g.lightline = { colorscheme = 'catppuccin' }


--== T R E E S I T T E R ==-

pcall(function()
    vim.cmd.packadd('treesitter')
    require('nvim-treesitter.configs').setup {
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = true,
        },
    }
    vim.cmd.TSEnable('highlight')
end)


--== L A N G U A G E   S E R V E R S ==--

pcall(function()
    vim.cmd.packadd('lspconfig')
    local lspconfig = require('lspconfig')
    lspconfig.dartls.setup {}
    lspconfig.hls.setup {}
    lspconfig.ts_ls.setup {}
    lspconfig.purescriptls.setup {}

    lspconfig.pyright.setup {
        settings = { python = { analysis = { typeCheckingMode = 'off' }}},
        on_new_config = function(config, root_dir)
            config.settings.python.pythonPath =
                vim.trim(vim.fn.system('uv run --project "' .. root_dir .. '" which python'))
        end
    }

    lspconfig.haxe_language_server.setup {
        -- If it’s anywhere then it’s here.
        cmd = {'node', vim.env.HOME .. '/src/haxe-language-server/bin/server.js'}
    }

    require('lspconfig.ui.windows').default_options = {
        border = 'single'
    }
end)

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover, { border = 'single' }
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help, { border = 'single' }
)
vim.diagnostic.config {
    float = { border = 'single' }
}
vim.cmd.map('\\e', ':lua vim.diagnostic.open_float(0, {scope="line"})<CR>')


--== F I L E T Y P E S ==--

vim.filetype.add { extension = { hx = 'haxe' } }
vim.filetype.add { extension = { purs = 'purescript' } }


--== D E B U G   A D A P T E R S ==--

pcall(function()
  require('dap-python').setup('uv')
end)


--== C O D E W I N D O W   M I N I M A P ==--

pcall(function()
    local codewindow = require('codewindow')
    codewindow.setup()
    codewindow.apply_default_keybinds()
end)


--== O C A M L   T O O L S ==--

if vim.uv.fs_stat('~/.opam') then
    vim.opt.rtp:append({
        "~/.opam/default/share/merlin/vim",
        "~/.opam/default/share/ocp-indent/vim"
    })
end
