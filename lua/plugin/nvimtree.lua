-- nvimtree setup
local M = {}

function M.setup()
  local nvim_tree_config = require('nvim-tree.config')
  local tree_cb = nvim_tree_config.nvim_tree_callback

  local tree_view = require "nvim-tree.view"
  local open = tree_view.open
  tree_view.open = function()
    M.on_open()
    open()
  end
  vim.cmd "au WinClosed * lua require('plugin.nvimtree').on_close()"

  vim.g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
    tree_width = 30,
  }
  vim.g.nvim_tree_quit_on_open = 0
  vim.g.nvim_tree_follow = true
  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_disable_window_picker = 0
  vim.g.nvim_tree_root_folder_modifier = ":t"
  vim.g.nvim_tree_allow_resize = 1
  vim.g.nvim_tree_auto_ignore_ft = { "startify", "dashboard", 'alpha'}
  vim.g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
      unstaged = "",
      staged = "",
      unmerged = "",
      renamed = "➜",
      untracked = "",
      deleted = "",
      ignored = "◌",
    },
    folder = {
      arrow_closed = "",
      arrow_open = "",
      default = "",
      open = "",
      empty = "",
      empty_open = "",
      symlink = "",
      symlink_open = "",
    },
  }

  require'nvim-tree'.setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {
      "startify",
      "dashboard",
      "alpha",
    },
    update_to_buf_dir = {
      enable = true,
      auto_open = true,
    },
    auto_close = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = false,
    diagnostics = {
      enable = true,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
    },
    system_open = {
      cmd = nil,
      args = {},
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 200,
    },
    view = {
      width = 30,
      height = 30,
      side = "left",
      auto_resize = true,
      number = false,
      relativenumber = false,
      mappings = {
        custom_only = false,
        list = {
          { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
          { key = "h", cb = tree_cb "close_node" },
          { key = "v", cb = tree_cb "vsplit" },
          { key = "C", cb = tree_cb "cd" },
          { key = "gtf", cb = "<cmd>lua require'plugin.nvimtree'.start_telescope('find_files')<cr>" },
          { key = "gtg", cb = "<cmd>lua require'plugin.nvimtree'.start_telescope('live_grep')<cr>" },
        },
      },
    },
    filters = {
      dotfiles = false,
      custom = { ".git", "node_modules", ".cache" },
    },
  }
  vim.api.nvim_set_keymap('n', '<leader>e', ":NvimTreeToggle<cr>", { noremap = true, silent = true })
end

function M.on_open()
  if package.loaded["bufferline.state"] then
    require("bufferline.state").set_offset(30 + 1, "")
  end
end

function M.on_close()
  local buf = tonumber(vim.fn.expand "<abuf>")
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")
  if ft == "NvimTree" and package.loaded["bufferline.state"] then
    require("bufferline.state").set_offset(0)
  end
end

function M.change_tree_dir(dir)
  local lib_status_ok, lib = pcall(require, "nvim-tree.lib")
  if lib_status_ok then
    lib.change_dir(dir)
  end
end

function M.start_telescope(telescope_mode)
  local node = require("nvim-tree.lib").get_node_at_cursor()
  local abspath = node.link_to or node.absolute_path
  local is_folder = node.has_children and true
  local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ":h")
  vim.api.nvim_command("Telescope " .. telescope_mode .. " cwd=" .. basedir)
end

return M
