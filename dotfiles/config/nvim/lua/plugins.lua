local fn = vim.fn

-- Install Packer if it's not installed already
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- I manually specify the `use` var to make the Lua LSP happy
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use { "catppuccin/nvim", as = "catppuccin" }
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'neovim/nvim-lspconfig'
    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }


    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lsp'
    use "hrsh7th/cmp-nvim-lsp-signature-help"
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
    use 'onsails/lspkind-nvim'
    use 'SirVer/ultisnips'
    use 'quangnguyen30192/cmp-nvim-ultisnips'
    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }
    use "folke/which-key.nvim"
    use "windwp/nvim-autopairs"
    use 'ray-x/go.nvim'
    use 'ray-x/guihua.lua' -- recommanded if need floating window support
end)

require('lualine').setup {options = {theme = 'catppuccin'}}

require('nvim-treesitter.configs').setup {
    ensure_installed = "all",
    highlight={enable=true}
}

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
        {name = 'path'}, {name = 'nvim_lsp_signature_help'}
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


require('go').setup()

require("which-key").setup {}

require('bufferline').setup {
options = {
    numbers = "buffer_id",
    indicator = {
	style = 'icon',
    },
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
	  -- name                | str        | the basename of the active file
	  -- path                | str        | the full path of the active file
	  -- bufnr (buffer only) | int        | the number of the active buffer
	  -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
	  -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
    color_icons = true, -- whether or not to add the filetype icon highlights
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = {"\u{e0b8}", "\u{e0ba}"},
    always_show_bufferline = true,
    hover = {
	enabled = true,
	delay = 200,
	reveal = {'close'}
    },
}
}

-- ### TELESCOPE ###
local telescope = require('telescope')
telescope.load_extension('fzf')

telescope.setup({
    pickers = {
        find_files = {
            find_command = {"rg", "--files", "-L"}
        }
    }
})


