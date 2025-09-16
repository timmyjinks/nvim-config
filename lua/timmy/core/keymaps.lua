vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":noh<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>ns", "<S-v>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>d", "<CR>vim.diagnostics.open_float()", { desc = "Clear search highlights" })
