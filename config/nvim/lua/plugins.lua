local fn = vim.fn

-- Install Packer if it's not installed already
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- I manually specify the `use` var to make the Lua LSP happy
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'folke/tokyonight.nvim'
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'onsails/lspkind-nvim'
    use 'SirVer/ultisnips'
    use 'quangnguyen30192/cmp-nvim-ultisnips'
    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }
    use "folke/which-key.nvim"
    use "windwp/nvim-autopairs"
end)

require('lualine').setup {options = {theme = 'tokyonight'}}

require('nvim-treesitter.configs').setup {ensure_installed = "maintained"}

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
               vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
                                                                          col)
                   :match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true),
                          mode, true)
end

require('nvim-autopairs').setup {}
local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local lspkind = require('lspkind')

cmp.setup {
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end
    },

    sources = {
        {name = 'nvim_lsp'}, {name = 'buffer'}, {name = 'treesitter'},
        {name = 'path'}
    },

    formatting = {
        format = lspkind.cmp_format({
            with_text = false,
            maxwidth = 50,
            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
                -- ...
                return vim_item
            end
        })
    },

    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                --            elseif vim.fn["vsnip#available"](1) == 1 then
                --                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, {"i", "s"}),

        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
                -- elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                --     feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, {"i", "s"}),
        ["<CR>"] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }
}

cmp.event:on('confirm_done',
             cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

require("which-key").setup {}
