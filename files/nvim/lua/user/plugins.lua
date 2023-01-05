--------------------------------------------------------------------------------
-- Automatically installs and sets up packer.nvim
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

-- Did it clone?
local packer_bootstrap = ensure_packer()

-- Packer Configuration
require('packer').init({
    compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
    auto_clean = true, -- remove unused plugins on start
    display = {
        -- Open a floating window for packer's display.
        open_fn = function()
            return require('packer.util').float({ border = 'solid' })
        end,
    },
})

--------------------------------------------------------------------------------
-- Register Plugins:

-- Function to register plugins.
local use = require('packer').use

-- Must be the first plugin. (packer.nvim registers packer.nvim)
use('wbthomason/packer.nvim')

-- One Dark theme.
use({
    'jessarcher/onedark.nvim',
    config = function()
        vim.cmd('colorscheme onedark')

        vim.api.nvim_set_hl(0, 'FloatBorder', {
            fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
            bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
        })

        -- Make the cursor line background invisible
        vim.api.nvim_set_hl(0, 'CursorLineBg', {
            fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
            bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
        })

        vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#30323E' })

        vim.api.nvim_set_hl(0, 'StatusLineNonText', {
            fg = vim.api.nvim_get_hl_by_name('NonText', true).foreground,
            bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
        })

        vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#2F313C' })
    end,
})

-- Commenting support.
use('tpope/vim-commentary')

-- Changes surrounding parentheses, brackets, quotes, XML tags, and more.
use('tpope/vim-surround')

-- File management commands.
use('tpope/vim-eunuch')

-- Editor config support and tab width auto-detection.
use('tpope/vim-sleuth')

-- Allow plugin commands (not just native commands) to repeat using `.`
use('tpope/vim-repeat')

-- Support for tonnes of languages including PHP, Blade, JS, Vue, etc. (everything I use)
use('sheerun/vim-polyglot')

-- Opens files in the scroll position you last left it at.
use('farmergreg/vim-lastplace')

-- Use visual mode to select text and search from that using `*`
use('nelstrom/vim-visual-star-search')

-- Heritage ensures parent directories exist when writing a new file.
use('jessarcher/vim-heritage')

-- Automatically set the working directory to the project root.
use({
    'airblade/vim-rooter',
    setup = function()
        -- Instead of this running every time we open a file, we'll just run it once when Vim starts.
        vim.g.rooter_manual_only = 1
    end,
    config = function()
        vim.cmd('Rooter')
    end,
})

-- Automatically add closing brackets, quotes, etc.
use({
    'windwp/nvim-autopairs',
    config = function()
        require('nvim-autopairs').setup()
    end,
})

-- Brain fart cheat sheet
use {
    "folke/which-key.nvim",
    config = function()
        require('user/plugins/which-key')
    end
}

-- Adds smooth scrolling.
use({
    'karb94/neoscroll.nvim',
    config = function()
        require('neoscroll').setup()
    end,
})

-- Make it so closing a buffer won't affect the window splits.
use({
    'famiu/bufdelete.nvim',
    config = function()
        vim.keymap.set('n', '<Leader>q', ':Bdelete<CR>')
    end,
})

-- Split arrays and methods onto multiple lines, or join them back up.
use({
    'AndrewRadev/splitjoin.vim',
    config = function()
        vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
        vim.g.splitjoin_trailing_comma = 1
        vim.g.splitjoin_php_method_chain_full = 1
    end,
})

-- Automatically fix indentation when pasting code.
use({
    'sickill/vim-pasta',
    config = function()
        vim.g.pasta_disabled_filetypes = { 'fugitive' }
    end,
})

-- Fuzzy finder
use({
    'nvim-telescope/telescope.nvim',
    requires = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        'nvim-telescope/telescope-live-grep-args.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function()
        require('user/plugins/telescope')
    end,
})

-- File tree sidebar
use({
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
        require('user/plugins/nvim-tree')
    end,
})

-- Status line
use({
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
        require('user/plugins/lualine')
    end,
})

-- Display buffers as tabs.
use({
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    after = 'onedark.nvim',
    config = function()
        require('user/plugins/bufferline')
    end,
})

-- Display indentation lines.
use({
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        require('user/plugins/indent-blankline')
    end,
})

-- Add a dashboard/splash/welcome screen.
use({
    'glepnir/dashboard-nvim',
    config = function()
        require('user/plugins/dashboard-nvim')
    end
})

-- Git commands.
use({
    'tpope/vim-fugitive',
    requires = 'tpope/vim-rhubarb',
})

-- Improved syntax highlighting
use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
        require('nvim-treesitter.install').update({ with_sync = true })
    end,
    requires = {
        'JoosepAlviste/nvim-ts-context-commentstring',
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        require('user/plugins/treesitter')
    end,
})

-- Language Server Protocol.
use({
    'neovim/nvim-lspconfig',
    requires = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'b0o/schemastore.nvim',
        'jose-elias-alvarez/null-ls.nvim',
        'jayp0521/mason-null-ls.nvim',
    },
    config = function()
        require('user/plugins/lspconfig')
    end,
})

-- LSP Completion
use({
    'hrsh7th/nvim-cmp',
    requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'onsails/lspkind-nvim',
    },
    config = function()
        require('user/plugins/cmp')
    end,
})

-- PHP Refactoring Tools
use({
    'phpactor/phpactor',
    ft = 'php',
    run = 'composer install --no-dev --optimize-autoloader',
    config = function()
        vim.keymap.set('n', '<Leader>pm', ':PhpactorContextMenu<CR>')
        vim.keymap.set('n', '<Leader>pn', ':PhpactorClassNew<CR>')
    end,
})

--------------------------------------------------------------------------------
-- If packer.nvim was just cloned, automatically set my configuration.
if packer_bootstrap then
    require('packer').sync()
end

--------------------------------------------------------------------------------
-- Neovim should automatically run :PackerCompile whenever plugins.lua is updated.
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile>
    augroup end
]])

