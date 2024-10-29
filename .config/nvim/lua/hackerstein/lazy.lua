local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Colorscheme
	{
		"slugbyte/lackluster.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.opt.termguicolors = true
			vim.background = "dark"
			vim.cmd.colorscheme("lackluster-hack")

			-- latex tweak for Conceal
			vim.cmd[[ hi! link Conceal LocalIdent ]]
		end
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.opt.timeout = true
			vim.opt.timeoutlen = 300
		end,
		opts = {}
	},
	-- Icons
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true
	},
	-- Git signs
	{
		"lewis6991/gitsigns.nvim",
		config = true
	},
	-- Neogit
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",

			"nvim-telescope/telescope.nvim"
		},
		config = true
	},
	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim"
		},
		config = function()
			require('telescope').setup({
				pickers = {
					find_files = {
						find_command = { "rg", "--files", "--hidden", "--no-ignore-vcs", "--glob", "!**/.git/*", "--sort", "path" }
					}
				}
			})
			require('telescope').load_extension('fzf')

			require("which-key").add({
				{ "<leader>f", group = "Fuzzy finding" },
				{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "Find files" },
				{ "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "Find in files" },
			})
		end
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function ()
			require("telescope").setup {
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown {
						}
					}
				}
			}

			require("telescope").load_extension("ui-select")
		end
	},
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				sync_install = false,
				highlight = {
					enable = true,
					disable = { "latex" },
					additional_vim_regex_syntax_highlighting = { "latex" }
				}
			})

			vim.cmd([[
				set foldmethod=expr
				set foldexpr=nvim_treesitter#foldexpr()
				set nofoldenable
			]])
		end
	},
	-- Treesitter text objects
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
			"nvim-treesitter/nvim-treesitter"
		}
	},
	-- LSP Zero
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v4.x",
		lazy = true,
		config = false
	},
	-- Mason
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
	},
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim"
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			local cmp = require("cmp")
			local cmp_action = lsp_zero.cmp_action()

			local lspkind = require("lspkind")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "copilot" }
				},
				formatting = {
					format = lspkind.cmp_format()
				},
				mapping = cmp.mapping.preset.insert({
					["<C-e>"] = cmp.mapping.abort(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() and cmp.get_active_entry() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
							else
								fallback()
							end
						end,
						s = cmp.mapping.confirm({ select = true }),
						c = cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
					}),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-j>"] = cmp_action.luasnip_jump_forward(),
					["<C-k>"] = cmp_action.luasnip_jump_backward(),
				})
			})
		end
	},
	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim"
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig({
				capabilities = require('cmp_nvim_lsp').default_capabilities(),
				lsp_attach = function(client, buffer)
					require("which-key").add({
						{ "<leader>c", buffer = buffer, group = "Code actions" },
						{ "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", buffer = buffer, desc = "Action" },
						{ "<leader>cf", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", buffer = buffer, desc = "Format" },
						{ "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", buffer = buffer, desc = "Rename" },
						{ "<leader>cs", "<cmd>ClangdSwitchSourceHeader<cr>", buffer = buffer, desc = "Switch Header/Source (C/C++ only)" },
						{ "<leader>d", buffer = buffer, group = "Diagnostics" },
						{ "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<cr>", buffer = buffer, desc = "Next" },
						{ "<leader>do", "<cmd>lua vim.diagnostic.open_float()<cr>", buffer = buffer, desc = "Open float" },
						{ "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<cr>", buffer = buffer, desc = "Previous" },
						{ "<leader>g", buffer = buffer, group = "Go to..." },
						{ "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", buffer = buffer, desc = "Declaration" },
						{ "<leader>gK", "<cmd>lua vim.lsp.buf.hover()<cr>", buffer = buffer, desc = "Symbol information" },
						{ "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<cr>", buffer = buffer, desc = "Definition" },
						{ "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", buffer = buffer, desc = "Implementation" },
						{ "<leader>go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", buffer = buffer, desc = "Type definition" },
						{ "<leader>gr", "<cmd>Telescope lsp_references<cr>", buffer = buffer, desc = "References" },
						{ "<leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", buffer = buffer, desc = "Signature help" },
					})
				end,
				float_border = 'rounded',
				sign_text = true
			})

			require("mason-lspconfig").setup({
				ensure_installed = {},
				handlers = {
					lsp_zero.default_setup,
					lua_ls = function()
						require("lspconfig").lua_ls.setup(lsp_zero.nvim_lua_ls())
					end
				}
			})
		end
	},
	-- DAP
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"jay-babu/mason-nvim-dap.nvim"
		},
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mason-nvim-dap").setup()

			require("which-key").add({
				{ "<leader>D", group = "Debugging" },
				{ "<leader>Db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle breakpoint" },
				{ "<leader>Dc", "<cmd>lua require('dap').continue()<cr>", desc = "Continue" },
				{ "<leader>Df", "<cmd>lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames)<cr>", desc = "Frames" },
				{ "<leader>Dh", "<cmd>lua require('dap.ui.widgets').hover()<cr>", desc = "Hover" },
				{ "<leader>Dn", "<cmd>lua require('dap').step_over()<cr>", desc = "Step over" },
				{ "<leader>Dp", "<cmd>lua require('dap.ui.widgets').preview()<cr>", desc = "Preview" },
				{ "<leader>Dr", "<cmd>lua require('dap').repl.open()<cr>", desc = "Open REPL" },
				{ "<leader>Ds", "<cmd>lua require('dap').step_into()<cr>", desc = "Step into" }
			})
		end
	},
	-- Lualine
	{
		"nvim-lualine/lualine.nvim",
		config = true
	},
	-- VimTex
	{
		"lervag/vimtex",
		ft = "tex",
		config = function()
			vim.cmd[[filetype plugin on]]

			vim.g.vimtex_view_method = "zathura_simple"
			vim.g.maplocalleader = "\\"

			-- Conceal
			vim.opt.concealcursor = "nc"
			vim.opt.conceallevel = 2
		end
	},
	-- Fidget
	{
		"j-hui/fidget.nvim",
		tag = "v1.4.5",
		opts = {}
	},
	-- Notify
	{
		"rcarriga/nvim-notify",
		-- lazy = false,
		-- priority = 1000,
		config = function()
			vim.notify = require("notify")
		end
	},
	-- Trouble
	{
		"folke/trouble.nvim",
		opts = {}
	},
	-- GUI font resizer
	{
		"ktunprasert/gui-font-resize.nvim",
		config = function()
			require("gui-font-resize").setup()

			require("which-key").add({
				{ "<leader>F", group = "Font size" },
				{ "<leader>Fd", "<cmd>GUIFontSizeDown<cr>", desc = "Down" },
				{ "<leader>Fu", "<cmd>GUIFontSizeUp<cr>", desc = "Up" },
			})
		end
	},
	-- Null LS
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim"
		},
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				-- sources = {
				-- 	null_ls.builtins.diagnostics.cppcheck.with({ extra_args = { "--inline-suppr" } }),
				-- },
			})
		end
	},
	-- Copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end
	},
	-- Copilot completion
	{
		"zbirenbaum/copilot-cmp",
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
		config = function()
			require("copilot_cmp").setup()
		end
	},
	-- Surround
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end
	}
})
