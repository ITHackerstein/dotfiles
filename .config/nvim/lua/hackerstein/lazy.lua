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
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			vim.opt.termguicolors = true
			vim.g.everforest_background = "hard"
			vim.cmd[[colorscheme everforest]]

			-- latex tweak for Conceal
			vim.cmd[[ hi! link Conceal LocalIdent ]]
		end
	},
	-- Which key
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

			require("which-key").register({
				f = {
					name = "Fuzzy finding",
					f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find files" },
					g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Find in files" }
				},
			}, { prefix = "<leader>" })
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
			"nvim=treesitter/nvim-treesitter"
		}
	},
	-- LSP Zero
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
		config = false,
		init = function()
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end
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
			"rafamadriz/friendly-snippets"
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			local cmp = require("cmp")
			local cmp_action = lsp_zero.cmp_action()

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip" }
				},
				formatting = lsp_zero.cmp_format(),
				mapping = cmp.mapping.preset.insert({
					["<C-e>"] = cmp.mapping.abort(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
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
			lsp_zero.extend_lspconfig()

			lsp_zero.on_attach(function(client, buffer)
				require("which-key").register({
					g = {
						name = "Go to...",
						d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
						D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
						i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation" },
						o = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type definition" },
						r = { "<cmd>Telescope lsp_references<cr>", "References" },
						s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature help" },
						K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Symbol information" }
					},
					d = {
						name = "Diagnostics",
						o = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Open float" },
						p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous" },
						n = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next" }
					},
					c = {
						name = "Code actions",
						r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
						f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
						a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Action" },
						s = { "<cmd>ClangdSwitchSourceHeader<cr>", "Switch Header/Source (C/C++ only)" }
					}
				}, { prefix = "<leader>", buffer = buffer })
			end)

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

			require("which-key").register({
				D = {
					name = "Debugging",
					c = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
					n = { "<cmd>lua require('dap').step_over()<cr>", "Step over" },
					s = { "<cmd>lua require('dap').step_into()<cr>", "Step into" },
					b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle breakpoint" },
					r = { "<cmd>lua require('dap').repl.open()<cr>", "Open REPL" },
					h = { "<cmd>lua require('dap.ui.widgets').hover()<cr>", "Hover" },
					p = { "<cmd>lua require('dap.ui.widgets').preview()<cr>", "Preview" },
					f = { "<cmd>lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames)<cr>", "Frames" },
					s = { "<cmd>lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes)<cr>", "Scopes" }
				}
			}, { prefix = "<leader>" })
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

			vim.g.vimtex_view_method = "zathura"
			vim.g.maplocalleader = "\\"

			-- Conceal
			vim.opt.concealcursor = "nc"
			vim.opt.conceallevel = 2
		end
	},
	-- Fidget
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		opts = {
			align = {
				bottom = false,
				right = true
			}
		}
	},
	-- Notify
	{
		"rcarriga/nvim-notify",
		lazy = false
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

			require("which-key").register({
				F = {
					name = "Font size",
					u = { "<cmd>GUIFontSizeUp<cr>", "Up" },
					d = { "<cmd>GUIFontSizeDown<cr>", "Down" }
				},
			}, { prefix = "<leader>" })
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
			require("copilot").setup({})

			require("copilot.suggestion").toggle_auto_trigger()

			local cmp = require("cmp")
			cmp.event:on("menu_opened", function()
				vim.b.copilot_suggestion_hidden = true
			end)

			cmp.event:on("menu_closed", function()
				vim.b.copilot_suggestion_hidden = false
			end)
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
