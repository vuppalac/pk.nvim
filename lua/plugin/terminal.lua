local M = {}
--local Log = require "lvim.core.log"
local terminal_config = {
  -- size can be a number or function which is passed the current terminal
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = false,
  -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
  direction = "float",
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_win_open'
    -- see :h nvim_win_open for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    border = "curved",
    -- width = <value>,
    -- height = <value>,
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
  -- Add executables on the config.lua
  -- { exec, keymap, name}
  -- lvim.builtin.terminal.execs = {{}} to overwrite
  -- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs+1] = {"gdb", "tg", "GNU Debugger"}
  execs = {
    -- TODO: this should probably be removed since it's hard to hit <leader>gg within the timeoutlen
    { "lazygit", "<leader>gg", "LazyGit", "float" },
    --{ "lazygit", "<c-\\>", "LazyGit", "float" },
  },
}

M.setup = function()
  local terminal = require "toggleterm"
  terminal.setup(terminal_config)

  -- setup the default terminal so it's always reachable
  local default_term_opts = {
    cmd = terminal_config.shell,
    keymap = terminal_config.open_mapping,
    label = "Toggle terminal",
    count = 1,
    direction = terminal_config.direction,
    size = terminal_config.size,
  }
  M.add_exec(default_term_opts)

  for i, exec in pairs(terminal_config.execs) do
    local opts = {
      cmd = exec[1],
      keymap = exec[2],
      label = exec[3],
      count = i + 1,
      direction = exec[4] or terminal_config.direction,
      size = terminal_config.size,
    }

    M.add_exec(opts)
  end
end

M.add_exec = function(opts)
  local binary = opts.cmd:match "(%S+)"
  if vim.fn.executable(binary) ~= 1 then
    --Log:error("Unable to run executable " .. binary .. ". Please make sure it is installed properly.")
    return
  end

  local exec_func = string.format(
    "<cmd>lua require('plugin.terminal')._exec_toggle({ cmd = '%s', count = %d, direction = '%s'})<CR>",
    opts.cmd,
    opts.count,
    opts.direction
  )

  vim.api.nvim_set_keymap(
    "n",
    opts.keymap,
    exec_func,
    { noremap = true, silent = true }
  )

  local wk_status_ok, wk = pcall(require, "whichkey")
  if not wk_status_ok then
    return
  end
  wk.register({ [opts.keymap] = { opts.label } }, { mode = "n" })
  wk.register({ [opts.keymap] = { opts.label } }, { mode = "t" })
end

M._exec_toggle = function(opts)
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new { cmd = opts.cmd, count = opts.count, direction = opts.direction }
  term:toggle(terminal_config.size, opts.direction)
end

return M
