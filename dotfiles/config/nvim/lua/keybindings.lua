local keymap = vim.keymap

local wk = require("which-key")
wk.setup()


wk.register({
    ["<leader>f"] = { name = "+telescope" }
})
keymap.set("n", "<leader>ff", ":Telescope find_files<cr>")
keymap.set("n", "<leader>fb", ":Telescope buffers<cr>")

wk.register({
    ["<leader>b"] = { name = "+buffer" }
})
keymap.set("n", "bn", ":BufferLineCycleNext<cr>")
keymap.set("n", "bp", ":BufferLineCyclePrev<cr>")

keymap.set("n", "<Up>", "<C-w><C-k>", { desc = 'Move cursor up window' })
keymap.set("n", "<Down>", "<C-w><C-j>")
keymap.set("n", "<Left>", "<C-w><C-h>")
keymap.set("n", "<Right>", "<C-w><C-l>")


wk.register({
    ["<leader>x"] = { name = "+trouble" }
})

vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
    { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
    { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
    { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
    { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
    { silent = true, noremap = true }
)


-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
-- local bufopts = { noremap = true, silent = true }
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', { desc = 'Go to definition' })
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { desc = 'LSP hover' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature help' })
vim.keymap.set("n","<leader>o", "<cmd>Lspsaga outline<CR>", { desc = 'LSP outline'})
vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = 'Print workspace folders' })
vim.keymap.set('n', 'gt', "<cmd>Lspsaga goto_type_definition<CR>", { desc = 'Go to type definition' })
-- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
-- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
vim.keymap.set('n', '<space>F', function() vim.lsp.buf.format { async = true } end, { desc = 'Format file' })
