-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        'lua_ls', 'gopls', 'jsonls', 'yamlls'
    }
})

require("mason-null-ls").setup({
    ensure_installed = { "stylua", 'luacheck' },
    automatic_setup = true
})

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities()


require('mason-lspconfig').setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities
        })
    end,
    ["lua_ls"] = function()
        require('lspconfig').lua_ls.setup({
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { 'vim' },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                },
                capabilities = capabilities
            }
        })
    end
})


require('trouble').setup {}

-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")
--
-- -- Use an on_attach function to only map the following keys
-- -- after the language server attaches to the current buffer
-- local on_attach = function(client, bufnr)
--   -- Enable completion triggered by <c-x><c-o>
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--
-- end
--
-- require'lspconfig'.lua_ls.setup {
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = {'vim'},
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file("", true),
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- }
--
-- -- require'lspconfig'.sumneko_lua.setup {
-- --     settings = {
-- --         Lua = {
-- --             runtime = {
-- --                 -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
-- --                 version = 'LuaJIT',
-- --                 -- Setup your lua path
-- --                 path = runtime_path
-- --             },
-- --             diagnostics = {
-- --                 -- Get the language server to recognize the `vim` global
-- --                 globals = {'vim'}
-- --             },
-- --             workspace = {
-- --                 -- Make the server aware of Neovim runtime files
-- --                 library = vim.api.nvim_get_runtime_file("", true)
-- --             },
-- --             -- Do not send telemetry data containing a randomized but unique identifier
-- --             telemetry = {enable = false}
-- --         }
-- --     },
-- --     capabilities = capabilities
-- -- }
--
-- require'lspconfig'.bashls.setup{
--     on_attach = on_attach
-- }
--
-- require'lspconfig'.jsonls.setup{
--     on_attach = on_attach
-- }
--
-- require'lspconfig'.gopls.setup{
--     on_attach = on_attach
-- }
--
-- require('lspconfig').yamlls.setup {
--     on_attach = on_attach,
--   settings = {
--     yaml = {
--       schemas = {
--         ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "~/uss_enterprise/*"
--       },
--     },
--   }
-- }

-- require'lspconfig'.yamlls.setup{}
