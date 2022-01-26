local M = {}

local layout_config = function ()
  return {
    width = 0.90,
    height = 0.85,
    preview_cutoff = 120,
    prompt_position = "bottom",
    horizontal = {
      preview_width = function(_, cols, _)
        if cols > 200 then
          return math.floor(cols * 0.5)
        else
          return math.floor(cols * 0.6)
        end
      end,
    },
    vertical = {
      width = 0.9,
      height = 0.95,
      preview_height = 0.5,
    },

    flex = {
      horizontal = {
        preview_width = 0.9,
      },
    },
  }
end

function M.code_actions()
  local opts = {
    winblend = 15,
    layout_config = {
      prompt_position = "top",
      width = 80,
      height = 12,
    },
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    border = {},
    previewer = false,
    shorten_path = false,
  }
  local builtin = require "telescope.builtin"
  local themes = require "telescope.themes"
  builtin.lsp_code_actions(themes.get_dropdown(opts))
end

function M.setup()
  local actions = require "telescope.actions"
  require('telescope').setup {
    defaults = {
      selection_caret = " ",
      layout_config = layout_config(),
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-c>"] = actions.close,
          ["<C-y>"] = actions.which_key,
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
        n = {
          ["<esc>"] = actions.close,
        },
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
      file_ignore_patterns = {
        "vendor/*",
        "%.lock",
        "__pycache__/*",
        "%.sqlite3",
        "%.ipynb",
        "node_modules/*",
        "%.jpg",
        "%.jpeg",
        "%.png",
        "%.svg",
        "%.otf",
        "%.ttf",
        ".git/",
        "%.webp",
        ".dart_tool/",
        ".github/",
        ".gradle/",
        ".idea/",
        ".settings/",
        ".vscode/",
        "__pycache__/",
        "build/",
        "env/",
        "gradle/",
        "node_modules/",
        "target/",
      },
      path_display = { shorten = 10 },
      winblend = 10,
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
    },
  }

  require('telescope').load_extension "fzf"

  --Add leader shortcuts
  vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>Telescope buffers<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>sf', [[<cmd>Telescope find_files<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>Telescope current_buffer_fuzzy_find<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>Telescope help_tags<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
  -- Custom key map
  vim.api.nvim_set_keymap('n', '<C-p>', [[<cmd>Telescope find_files<CR>]], { noremap = true, silent = true })

end

return M
