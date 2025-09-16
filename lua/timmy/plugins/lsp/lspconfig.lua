return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		vim.cmd([[autocmd BufRead,BufNewFile *.grz setfiletype grz]])
		require("lspconfig.configs").grezi = {
			default_config = {
				cmd = { "grezi", "--lsp" },
				filetypes = { "grz" },
				on_init = function(client, _)
					client.server_capabilities.semanticTokensProvider = nil -- turn off semantic tokens
					vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
					vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
					vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
					vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
				end,
				on_attach = function(client, bufnr)
					local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format()
							end,
						})
					end
				end,
				single_file_support = true,
			},
		}
		lspconfig.grezi.setup({})
		vim.lsp.inlay_hint.enable()

		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		})
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		parser_config.grz = {
			install_info = {
				url = "~/Downloads/grezi-next/tree-sitter-grz", -- local path or git repo
				files = { "src/parser.c", "src/scanner.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
				-- optional entries:
				branch = "nvim", -- default branch in case of git repo if different from master
				generate_requires_npm = false, -- if stand-alone parser without npm dependencies
				requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
			},
			filetype = "grz", -- if filetype does not match the parser name
		}
		parser_config.djot = {
			install_info = {
				url = "https://github.com/treeman/tree-sitter-djot", -- local path or git repo
				files = { "src/parser.c", "src/scanner.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
				-- optional entries:
				branch = "master", -- default branch in case of git repo if different from master
				generate_requires_npm = false, -- if stand-alone parser without npm dependencies
				requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
			},
			filetype = "dj", -- if filetype does not match the parser name
		}
		vim.treesitter.language.register("grz", "grz")

		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
		})
	end,
}
