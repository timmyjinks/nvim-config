vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":noh<CR>", { desc = "Clear search highlights" })

