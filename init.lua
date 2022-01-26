require("impatient")
require("plugins")
require("config.options")

-- vim.g.tokyonight_style = "storm"
-- vim.g.tokyonight_italic_functions = true
-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- vim.cmd[[ colorscheme onedarker ]]
vim.cmd [[colorscheme kanagawa]]

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

require("config.lsp")
require("luasnip/loaders/from_vscode").load { paths = { "~/.config/nvim/snippets" } }
require("config.keymaps").load_all()
require("config.autocommands")
