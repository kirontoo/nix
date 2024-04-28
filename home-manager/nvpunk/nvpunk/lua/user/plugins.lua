return {
	{ 'tpope/vim-surround' },
	{ 'tpope/vim-unimpaired' },
	{ 'tpope/vim-fugitive' },
	{ 'tpope/vim-repeat' },
	{ 'tpope/vim-sleuth' },
	{ 'airblade/vim-rooter' },
	{ 'embark-theme/vim',    as = 'embark' },
	{
		'folke/todo-comments.nvim',
		requires = 'nvim-lua/plenary.nvim',
	},
	{ 'godlygeek/tabular' },
	{
		"iamcco/markdown-preview.nvim",

		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			workspaces = {
				{
					name = "mindmap",
					path = "~/Documents/mindmap",
					overrides = {
						notes_subdir = "03-Resources"
					}
				},
			},
			templates = {
				subdir = "templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
				substitutions = {},
			},
			new_notes_location = "03-Resources",
			note_id_func = function()
				return string.format("%s", tostring(os.date('%Y%m%d%H%M', os.time())))
			end,

			image_name_func = function()
				return string.format("%s", tostring(os.date('%Y%m%d%H%M', os.time())))
			end,

			attachments = {
				img_folder = "assets",
				img_text_func = function(client, path)
					path = client:vault_relative_path(path) or path
					return string.format("![%s](%s)", path.name, path)
				end,
			},

			mappings = {
				-- "Obsidian follow"
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
					desc = 'Follow link'
				},
				["gfv"] = {
					action = function()
						return '<cmd>ObsidianFollowLink vsplit<CR>'
					end,
					opts = { noremap = false, expr = true, buffer = true },
					desc = 'Follow link and Vertical split'
				},
				["gfh"] = {
					action = function()
						return '<cmd>ObsidianFollowLink hsplit<CR>'
					end,
					opts = { noremap = false, expr = true, buffer = true },
					desc = 'Follow link and Horizontal split'
				},
				["<leader>on"] = {
					action = function()
						return '<cmd>ObsidianNew<CR>'
					end,
					opts = { noremap = false, expr = true, buffer = true },
					desc = 'Create a new Obsidian note'
				},
				["<leader>ot"] = {
					action = function()
						return '<cmd>ObsidianTags<CR>'
					end,
					opts = { noremap = false, expr = true, buffer = true },
					desc = 'Search for notes by Tag'
				},
				["<leader>of"] = {
					action = function()
						return '<cmd>ObsidianSearch<CR>'
					end,
					opts = { noremap = false, expr = true, buffer = true },
					desc = 'Search for Obsidian file or create a note'
				},
				["<leader>orn"] = {
					action = function()
						return '<cmd>ObsidianRename<CR>'
					end,
					opts = { noremap = false, expr = true, buffer = true },
					desc = 'Rename a Obsidian file'
				},
				["<leader>op"] = {
					action = function()
						return '<cmd>ObsidianPasteImg<CR>'
					end,
					opts = { noremap = false, expr = true, buffer = true },
					desc = 'Paste an image'
				},
				-- Toggle check-boxes "obsidian done"
				["<leader>od"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true },
					desc = "Toggle check box"
				},
			},
		},
	}
}
