vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "tokyonord"

-- Hybrid color palette: Tokyonight + Nord
local colors = {
  -- Base colors (Nord-inspired backgrounds)
  bg = "#2e3440",           -- Nord polar night
  bg_dark = "#3b4252",      -- Nord darker
  bg_float = "#3b4252",
  bg_sidebar = "#2e3440",
  
  -- Foreground (Tokyonight-inspired)
  fg = "#c0caf5",           -- Tokyonight foreground
  fg_dark = "#a9b1d6",
  fg_gutter = "#565f89",
  
  -- Accent colors (mix of both)
  blue = "#81a1c1",         -- Nord blue
  cyan = "#88c0d0",         -- Nord frost
  green = "#a3be8c",        -- Nord green
  orange = "#d08770",       -- Nord orange
  purple = "#b48ead",       -- Nord purple
  red = "#bf616a",          -- Nord red
  yellow = "#ebcb8b",       -- Nord yellow
  
  -- Tokyonight blues for UI
  blue0 = "#3d59a1",
  blue1 = "#2ac3de", 
  blue2 = "#7aa2f7",        -- Your preferred border color
  blue5 = "#89ddff",
  blue6 = "#b4f9f8",
  blue7 = "#394b70",
  
  -- Special colors
  comment = "#616e88",      -- Blend of both comment styles
  line_number = "#4c566a",  -- Nord
  cursor_line = "#3b4252",  -- Nord darker
  selection = "#434c5e",    -- Nord
  search = "#5e81ac",       -- Nord blue variant
}

-- Apply highlights
local hl = vim.api.nvim_set_hl

-- Editor basics
hl(0, "Normal", { fg = colors.fg, bg = colors.bg })
hl(0, "NormalFloat", { fg = colors.fg, bg = colors.bg_float })
hl(0, "Comment", { fg = colors.comment, italic = true })
hl(0, "Constant", { fg = colors.orange })
hl(0, "String", { fg = colors.green })
hl(0, "Character", { fg = colors.green })
hl(0, "Number", { fg = colors.purple })
hl(0, "Boolean", { fg = colors.orange })
hl(0, "Float", { fg = colors.purple })

-- Identifiers
hl(0, "Identifier", { fg = colors.cyan })
hl(0, "Function", { fg = colors.blue })

-- Statements
hl(0, "Statement", { fg = colors.blue2 })
hl(0, "Conditional", { fg = colors.purple })
hl(0, "Repeat", { fg = colors.purple })
hl(0, "Label", { fg = colors.purple })
hl(0, "Operator", { fg = colors.cyan })
hl(0, "Keyword", { fg = colors.purple })
hl(0, "Exception", { fg = colors.purple })

-- PreProc
hl(0, "PreProc", { fg = colors.cyan })
hl(0, "Include", { fg = colors.purple })
hl(0, "Define", { fg = colors.purple })
hl(0, "Macro", { fg = colors.purple })
hl(0, "PreCondit", { fg = colors.purple })

-- Types
hl(0, "Type", { fg = colors.yellow })
hl(0, "StorageClass", { fg = colors.yellow })
hl(0, "Structure", { fg = colors.yellow })
hl(0, "Typedef", { fg = colors.yellow })

-- Special
hl(0, "Special", { fg = colors.blue })
hl(0, "SpecialChar", { fg = colors.blue })
hl(0, "Tag", { fg = colors.blue })
hl(0, "Delimiter", { fg = colors.fg })
hl(0, "SpecialComment", { fg = colors.comment })
hl(0, "Debug", { fg = colors.orange })

-- UI Elements
hl(0, "LineNr", { fg = colors.line_number })
hl(0, "CursorLine", { bg = colors.cursor_line })
hl(0, "CursorLineNr", { fg = colors.blue2, bold = true })
hl(0, "Visual", { bg = colors.selection })
hl(0, "Search", { bg = colors.search, fg = colors.bg })
hl(0, "IncSearch", { bg = colors.orange, fg = colors.bg })

-- Window separators (CLEAR and prominent)
hl(0, "WinSeparator", { fg = colors.blue2, bold = true })
hl(0, "VertSplit", { fg = colors.blue2, bold = true })

-- Floating windows and borders
hl(0, "FloatBorder", { fg = colors.blue2, bg = colors.bg_float })
hl(0, "NormalFloat", { bg = colors.bg_float })

-- Status line
hl(0, "StatusLine", { fg = colors.fg, bg = colors.bg_dark })
hl(0, "StatusLineNC", { fg = colors.comment, bg = colors.bg_dark })

-- Tabs
hl(0, "TabLine", { fg = colors.comment, bg = colors.bg_dark })
hl(0, "TabLineFill", { bg = colors.bg_dark })
hl(0, "TabLineSel", { fg = colors.fg, bg = colors.bg })

-- Diagnostics (if you add LSP later)
hl(0, "DiagnosticError", { fg = colors.red })
hl(0, "DiagnosticWarn", { fg = colors.yellow })
hl(0, "DiagnosticInfo", { fg = colors.blue })
hl(0, "DiagnosticHint", { fg = colors.cyan })

-- Git signs
hl(0, "GitSignsAdd", { fg = colors.green })
hl(0, "GitSignsChange", { fg = colors.yellow })
hl(0, "GitSignsDelete", { fg = colors.red })
