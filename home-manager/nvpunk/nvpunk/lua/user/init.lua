-- SET LEADER KEYMAP --
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- vim.o.sessionoptions =
-- 	'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'

-- SET VIM OPTIONS --
vim.opt.clipboard:append('unnamedplus')
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.g.concaellevel = 1

-- vim.opt.list=true
-- vim.opt.listchars='tab:ﲒ,extends:›,precedes:‹,nbsp:␣,trail:·,eol:↲'

-- vim.g.splitjoin_split_mapping = ''
-- vim.g.splitjoin_join_mapping = ''
-- vim.g.splitjoin_align=1

-- CUSTOM KEYMAPS --
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<leader>rw', ':s/<c-r><c-w>//g<Left><Left>')
map('n', '<leader>rW', ':%s/<c-r><c-w>//g<Left><Left>')

-- Window hide --
map('n', '<leader>whh', '<C-w>h:hide<CR>')
map('n', '<leader>whj', '<C-w>j:hide<CR>')
map('n', '<leader>whk', '<C-w>k:hide<CR>')
map('n', '<leader>whl', '<C-w>l:hide<CR>')

-- Tabs --
map('n', '<leader>tn', ':tabnew<CR>')
map('n', '<leader>tx', ':tabclose<CR>')

map('n', '<leader>fev', ':e $HOME/.config/nvpunk/lua/user/init.lua<CR>')
map('n', '<leader>fn', '<cmd>NvpunkNewFileDialog<CR>')

-- TPOPE/FUGITIVE --
map('n', '<leader>gc', '<cmd>:Git commit<CR>')
map('n', '<leader>gd', '<cmd>:Gvdiffsplit<CR>')
map('n', '<leader>gr', '<cmd>:Gremove<CR>')
map('n', '<leader>gl', '<cmd>:Git pull<CR>')
map('n', '<leader>gm', '<cmd>:Git merge<CR>')
map('n', '<leader>gp', '<cmd>:Git push<CR>')
map('n', '<leader>gs', '<cmd>:Git <CR>')

map('n', '<Tab>', ':BufferLineCycleNext<CR>')
map('n', '<S-Tab>', ':BufferLineCyclePrev<CR>')

-- FOLKE/TROUBLE --
map('n', '<leader>xt', '<cmd>TroubleToggle<cr>')
map('n', '<leader>xf', '<cmd>Trouble<cr>')
map('n', '<leader>xx', '<cmd>TroubleClose<cr>')
map('n', '<leader>xw', '<cmd>Trouble document_diagnostics<cr>')
map('n', '<leader>xW', '<cmd>Trouble workspace_diagnostics<cr>')
map('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>')
map('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>')
map('n', '<leader>xr', '<cmd>Trouble lsp_references<cr>')
map('n', '<leader>xd', '<cmd>TodoTrouble<cr>')
map('n', '<leader>xD', '<cmd>TodoTelescope<cr>')

-- QUIT VIM --
map('n', '<leader>qq', ':qa!<CR>')

require('todo-comments').setup({
	signs = true,     -- show icons in the signs column
	sign_priority = 8, -- sign priority
	-- keywords recognized as todo comments
	keywords = {
		FIX = {
			icon = ' ', -- icon used for the sign, and in search results
			color = 'error', -- can be a hex color, or a named color (see below)
			alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
			-- signs = false, -- configure signs for some keywords individually
		},
		TODO = { icon = ' ', color = 'info' },
		HACK = { icon = ' ', color = 'warning' },
		WARN = {
			icon = ' ',
			color = 'warning',
			alt = { 'WARNING', 'XXX' },
		},
		PERF = {
			icon = ' ',
			alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' },
		},
		NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
	},
	merge_keywords = true, -- when true, custom keywords will be merged with the defaults
	-- highlighting of the line containing the todo comment
	-- * before: highlights before the keyword (typically comment characters)
	-- * keyword: highlights of the keyword
	-- * after: highlights after the keyword (todo text)
	highlight = {
		before = '',                   -- "fg" or "bg" or empty
		keyword = 'wide',              -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
		after = 'fg',                  -- "fg" or "bg" or empty
		pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
		comments_only = true,          -- uses treesitter to match keywords in comments only
		max_line_len = 400,            -- ignore lines longer than this
		exclude = {},                  -- list of file types to exclude highlighting
	},
	-- list of named colors where we try to extract the guifg from the
	-- list of hilight groups or use the hex color if hl not found as a fallback
	colors = {
		error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
		warning = { 'DiagnosticWarning', 'WarningMsg', '#FBBF24' },
		info = { 'DiagnosticInfo', '#2563EB' },
		hint = { 'DiagnosticHint', '#10B981' },
		default = { 'Identifier', '#7C3AED' },
	},
	search = {
		command = 'rg',
		args = {
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
		},
		-- regex that will be used to match keywords.
		-- don't replace the (KEYWORDS) placeholder
		pattern = [[\b(KEYWORDS):]], -- ripgrep regex
		-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
	},
})

-- local actions = require('telescope.actions')
local trouble = require('trouble.providers.telescope')

local telescope = require('telescope')

telescope.setup({
	defaults = {
		mappings = {
			i = { ['<c-t>'] = trouble.open_with_trouble },
			n = { ['<c-t>'] = trouble.open_with_trouble },
		},
	},
	pickers = {
		find_files = { theme = "ivy", hidden = true },
		lsp_references = { theme = "ivy" },
		live_grep = { theme = "ivy" },
		lsp_document_symbols = { theme = "ivy" },
	},
	keys = {
		{
			'<leader>td',
			function()
				require('nvpunk.internals.telescope_pickers').document_diagnostics()
			end,
			desc = 'Document Diagnostics',
		},

		{
			'<leader>ts',
			function()
				require('nvpunk.internals.telescope_pickers').lsp_document_symbols()
			end,
			desc = 'Search Document Symbols',
		},
	}
})
