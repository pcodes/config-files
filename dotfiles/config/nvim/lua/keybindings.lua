local keymap = vim.keymap

keymap.set("n", "<leader>ff", ":Telescope find_files<cr>")
keymap.set("n", "<leader>fb", ":Telescope buffers<cr>")
keymap.set("n", "bn", ":BufferLineCycleNext<cr>")
keymap.set("n", "bp", ":BufferLineCyclePrev<cr>")
