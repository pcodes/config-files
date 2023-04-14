local keymap = vim.keymap

require("which-key").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
})

keymap.set("n", "<leader>ff", ":Telescope find_files<cr>")
keymap.set("n", "<leader>fb", ":Telescope buffers<cr>")
keymap.set("n", "bn", ":BufferLineCycleNext<cr>")
keymap.set("n", "bp", ":BufferLineCyclePrev<cr>")

keymap.set("n", "<Up>", "<C-w><C-k>", { desc = 'Move cursor up window' })
keymap.set("n", "<Down>", "<C-w><C-j>")
keymap.set("n", "<Left>", "<C-w><C-h>")
keymap.set("n", "<Right>", "<C-w><C-l>")

vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
