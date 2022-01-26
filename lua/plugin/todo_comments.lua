local M = {}

M.setup = function()
  local status_ok, todo = pcall(require, "todo-comments")
  if not status_ok then
    return
  end

  -- local error_red = '#F44747'
  -- local warning_orange = '#ff8800'
  -- local info_yellow = '#FFCC66'
  -- local hint_blue = '#4FC1FF'
  -- local perf_purple = '#7C3AED'
  -- local note_green = '#10B981'

  local icons = require("user.lsp_kind").todo_comments
  todo.setup {
    keywords = {
      --[[FIX = {
        icon = " ", -- icon used for the sign, and in search results
        color = error_red, -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = " ", color = hint_blue },
      HACK = { icon = " ", color = warning_orange },
      WARN = { icon = " ", color = warning_orange, alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", color = perf_purple, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = info_yellow, alt = { "INFO" } },--]]
      FIX = { icon = icons.FIX },
      TODO = { icon = icons.TODO, alt = { "WIP" } },
      HACK = { icon = icons.HACK, color = "hack" },
      WARN = { icon = icons.WARN },
      PERF = { icon = icons.PERF },
      NOTE = { icon = icons.NOTE, alt = { "INFO", "NB" } },
      ERROR = { icon = icons.ERROR, color = "error", alt = { "ERR" } },
      REFS = { icon = icons.REFS },
    },
    highlight = { max_line_len = 400 },
    -- colors = {
    --   error = { "DiagnosticError" },
    --   warning = { "DiagnosticWarn" },
    --   info = { "DiagnosticInfo" },
    --   hint = { "DiagnosticHint" },
    --   hack = { "Function" },
    --   ref = { "FloatBorder" },
    --   default = { "Identifier" },
    -- },
    colors = {
      error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
      warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
      info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
      hint = { "LspDiagnosticsDefaultHint", "#10B981" },
      hack = { "Function" },
      ref = { "FloatBorder" },
      default = { "Identifier", "#7C3AED" },
    },
  }
end

return M
