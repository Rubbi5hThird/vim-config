-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	-- status line
	use 'nvim-lualine/lualine.nvim'
	require('lualine').setup {
		options = {
			icons_enabled = true,
			theme = 'auto',
			component_separators = { left = ')', right = '('},
			section_separators = { left = '', right = '' },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			}
		},
		sections = {
			lualine_a = {
				{ 'mode' },
				{ 'datetime', style = "%H:%M" }
			},
			lualine_b = {'branch', 'diff', 'diagnostics'},
			lualine_c = {'filename'},
			lualine_x = {'encoding', 'fileformat', 'filetype'},
			lualine_y = {'progress'},
			lualine_z = {'location'}
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {'filename'},
			lualine_x = {'location'},
			lualine_y = {},
			lualine_z = {}
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {}
	}
	-- fuzzy finder
	use 'junegunn/fzf'
	use 'junegunn/fzf.vim'
	use 'vivien/vim-linux-coding-style'
	use 'gennaro-tedesco/nvim-peekup'
	-- syntax
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require'nvim-treesitter.configs'.setup {
				ensure_installed = { "c", "lua", "vim", "cpp", "java", "bash", "python" },
				sync_install = true,
				auto_install = true,
				ignore_install = {},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			}
		end
	}
	-- comment
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}
	-- file expolorer
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional, for file icons
		},
		config = function()
			require("nvim-tree").setup()
		end
	}
	use {
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup {}
		end
	}
	use {
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup {
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map('n', ']c', function()
						if vim.wo.diff then return ']c' end
						vim.schedule(function() gs.next_hunk() end)
						return '<Ignore>'
					end, {expr=true})

					map('n', '[c', function()
						if vim.wo.diff then return '[c' end
						vim.schedule(function() gs.prev_hunk() end)
						return '<Ignore>'
					end, {expr=true})

					-- Actions
					map('n', '<leader>hs', gs.stage_hunk)
					map('n', '<leader>hr', gs.reset_hunk)
					map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
					map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
					map('n', '<leader>hS', gs.stage_buffer)
					map('n', '<leader>hu', gs.undo_stage_hunk)
					map('n', '<leader>hR', gs.reset_buffer)
					map('n', '<leader>hp', gs.preview_hunk)
					map('n', '<leader>hb', function() gs.blame_line{full=true} end)
					map('n', '<leader>tb', gs.toggle_current_line_blame)
					map('n', '<leader>hd', gs.diffthis)
					map('n', '<leader>hD', function() gs.diffthis('~') end)
					map('n', '<leader>td', gs.toggle_deleted)

					-- Text object
					map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
				end
			}
		end
	}
	-- indent
	use {
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup {
				char_highlight_list = {
					"IndentBlanklineIndent1",
					"IndentBlanklineIndent2",
					"IndentBlanklineIndent3",
					"IndentBlanklineIndent4",
					"IndentBlanklineIndent5",
					"IndentBlanklineIndent6",
				},
			}
		end
	}
	use 'google/vim-maktaba'
	use 'google/vim-codefmt'
	-- fileline
	use 'bogado/file-line'
end)
