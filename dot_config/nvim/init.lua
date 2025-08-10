-- Section: General Options
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.undofile = true
vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.scrolloff = 3

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1
vim.g.netrw_browse_split = 0
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 50

vim.env.FZF_DEFAULT_OPTS = "--bind=tab:down,btab:up"

vim.opt.fillchars = {
  horiz = '━',
  horizup = '┻',
  horizdown = '┳', 
  vert = '┃',
  vertleft = '┫',
  vertright = '┣',
  verthoriz = '╋',
}

-- all functions & autocommands
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end
})

-- Markdown formatting configuration
local function setup_markdown_formatting()
  vim.opt_local.textwidth = 80
  vim.opt_local.colorcolumn = "80"
  vim.opt_local.wrap = true
  vim.opt_local.linebreak = true
  vim.opt_local.showbreak = "↪ "
  vim.opt_local.breakindent = true
  vim.opt_local.breakindentopt = "shift:2"

  -- Enable spell checking
  -- vim.opt_local.spell = true
  -- vim.opt_local.spelllang = "en_us"

  vim.opt_local.formatoptions = "tcqjn"

  vim.opt_local.conceallevel = 2

  vim.opt_local.tabstop = 2
  vim.opt_local.shiftwidth = 2
  vim.opt_local.expandtab = true
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "md" },
  callback = setup_markdown_formatting,
  desc = "Set markdown formatting options"
})

-- Section: Keymaps
vim.keymap.set('n', '<leader>e', ':Sex<CR>', { desc = 'Open netrw file explorer', noremap = true, silent = true })
vim.keymap.set('n', '<leader>gg', ':Neogit<CR>', { desc = 'Open Neogit', noremap = true, silent = true })

-- Strip trailing whitespace from visual selection
vim.keymap.set("x", "<leader>st", ":s/\\s\\+$//g<CR>", { desc = "Strip trailing whitespace" })

-- Strip leading whitespace from visual selection  
vim.keymap.set("x", "<leader>sl", ":s/^\\s\\+//g<CR>", { desc = "Strip leading whitespace" })

-- Strip both leading and trailing whitespace
vim.keymap.set("x", "<leader>sa", ":s/^\\s\\+\\|\\s\\+$//g<CR>", { desc = "Strip leading & trailing whitespace" })

vim.keymap.set('n', '<Esc>', ':nohls<CR><Esc>', { noremap = true, silent = true })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<leader>wv', ':vsplit<CR>', { desc = 'Vertical split', noremap = true, silent = true })
vim.keymap.set('n', '<leader>ws', ':split<CR>', { desc = 'Horizontal split', noremap = true, silent = true })

vim.keymap.set('n', '<leader>ww', '<C-w>w', { desc = 'Switch window', noremap = true, silent = true })

vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = 'Switch to left window', noremap = true, silent = true })
vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = 'Switch to right window', noremap = true, silent = true })
vim.keymap.set('n', '<leader>wk', '<C-w>k', { desc = 'Switch to above window', noremap = true, silent = true })
vim.keymap.set('n', '<leader>wj', '<C-w>j', { desc = 'Switch to below window', noremap = true, silent = true })

vim.keymap.set('n', '<leader>wH', '<C-w>H', { desc = 'Move window left', noremap = true, silent = true })
vim.keymap.set('n', '<leader>wJ', '<C-w>J', { desc = 'Move window down', noremap = true, silent = true })
vim.keymap.set('n', '<leader>wK', '<C-w>K', { desc = 'Move window up', noremap = true, silent = true })
vim.keymap.set('n', '<leader>wL', '<C-w>L', { desc = 'Move window right', noremap = true, silent = true })

vim.keymap.set('n', '<leader>t', ':split | terminal<CR>', { desc = 'Open terminal in split', noremap = true, silent = true })

-- Section: Plugins
-- lazyvim
-- TODO: set lazyvim path and plugin path to the same folder
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--depth=1",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
      "ibhagwan/fzf-lua",
      keys = {
        -- File search
        { "<leader><leader>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
        { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Files" },

        -- Buffers
        { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
        { "<leader>T", "<cmd>FzfLua tabs<cr>",  desc = "Tab picker" },

        -- Search
        { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live Grep" },
        { "<leader>fw", "<cmd>FzfLua grep_cword<cr>", desc = "Word under cursor" },

        -- Git
        { "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Commits" },
        { "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Status" },
        { "<leader>gb", "<cmd>FzfLua git_branches<cr>", desc = "Branches" },

        -- History/help
        { "<leader>fh", "<cmd>FzfLua oldfiles<cr>", desc = "File History" },
        { "<leader>fH", "<cmd>FzfLua help_tags<cr>", desc = "Help Tags" },

        -- Advanced
        { "<leader>fz", "<cmd>FzfLua resume<cr>", desc = "Resume last search" },
        { "<leader>ft", "<cmd>FzfLua tags<cr>", desc = "Tags" },

        -- Themes
        { "<leader>ut", "<cmd>FzfLua colorschemes<cr>", desc = "Theme picker" },
      },
      opts = {
        winopts = {
          width = 0.9,
          height = 0.9,
          preview = {
            layout = "vertical",
          }
        }
      },
    },
    {
        "https://github.com/NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = "Neogit",
        config = function()
            require("neogit").setup()
        end,
    },
    {
    "https://github.com/nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
        require("lualine").setup {
            options = { 
                theme = 'auto',
                component_separators = '|',
                section_separators = '',
                globalstatus = true
            },
        }
    end,
    },
    {
      "ej-shafran/compile-mode.nvim",
      version = "^5.0.0",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        vim.g.compile_mode = {
            bang_expansion = true,
        }
      end
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        delay = 0,
        preset = "helix",
      },
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
      event = "InsertEnter",
      config = function()
        local cmp = require("cmp")

        cmp.setup({
          snippet = {
        expand = function(args)
          vim.fn.feedkeys(args.body, "i")
        end,
          },

        mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          }),

          sources = cmp.config.sources({
         {
          name = "buffer", 
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end
          },
          enabled = function()
            local ft = vim.bo.filetype
            return not (ft == "text" or ft == "markdown" or ft == "md")
          end,
        },
        { name = "path" },
          })
        })
      end,
    },
    {
      'lmantw/themify.nvim',

      lazy = false,
      priority = 999,

      config = {
        'folke/tokyonight.nvim',
        'Shatur/neovim-ayu',
        'ellisonleao/gruvbox.nvim',
        'shaunsingh/nord.nvim',
        'tokyonord',
      },
    },
    {
      "stevearc/conform.nvim",
      event = { "BufWritePre" },
      cmd = { "ConformInfo" },
      keys = {
        {
          "<leader>uf",
          function()
            require("conform").format({ async = true, lsp_format = "fallback" })
          end,
          mode = "",
          desc = "Format buffer",
        },
      },
      config = function()
        require("conform").setup({
          formatters_by_ft = {
            c = { "clang_format" },
            cpp = { "clang_format" },
            go = { "gofmt" },
            python = { "ruff_organize_imports", "ruff_format" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
          },
        })
      end,
    },
    {
      "jake-stewart/multicursor.nvim",
      branch = "1.0",
      event = "VeryLazy",
      config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        -- Core multicursor actions
        vim.keymap.set({"n", "x"}, "<C-n>", function() mc.matchAddCursor(1) end, { desc = "Add cursor to next match" })
        vim.keymap.set({"n", "x"}, "<C-s>", function() mc.matchSkipCursor(1) end, { desc = "Skip next match" })
        vim.keymap.set({"n", "x"}, "<C-N>", function() mc.matchAddCursor(-1) end, { desc = "Add cursor to prev match" })
        vim.keymap.set({"n", "x"}, "<C-S>", function() mc.matchSkipCursor(-1) end, { desc = "Skip prev match" })

        -- Add/skip cursors vertically
        vim.keymap.set({"n", "x"}, "<M-j>", function() mc.lineAddCursor(1) end, { desc = "Add cursor below" })
        vim.keymap.set({"n", "x"}, "<M-k>", function() mc.lineAddCursor(-1) end, { desc = "Add cursor above" })
        vim.keymap.set({"n", "x"}, "<M-J>", function() mc.lineSkipCursor(1) end, { desc = "Skip line below" })
        vim.keymap.set({"n", "x"}, "<M-K>", function() mc.lineSkipCursor(-1) end, { desc = "Skip line above" })

        -- Mouse support
        vim.keymap.set("n", "<C-LeftMouse>", mc.handleMouse, { desc = "Add/remove cursor" })
        vim.keymap.set("n", "<C-LeftDrag>", mc.handleMouseDrag)
        vim.keymap.set("n", "<C-LeftRelease>", mc.handleMouseRelease)

        -- Toggle cursors on/off
        vim.keymap.set({"n", "x"}, "<C-q>", mc.toggleCursor, { desc = "Toggle cursor" })

        -- Mode hub under leader
        vim.keymap.set({"n", "x"}, "<leader>mc", mc.addCursor, { desc = "Add cursor at current position" })
        vim.keymap.set({"n", "x"}, "<leader>ma", mc.alignCursors, { desc = "Align cursors" })
        vim.keymap.set({"n", "x"}, "<leader>mA", mc.matchAllAddCursors, { desc = "Add cursors to all matches" })
        vim.keymap.set("x", "<leader>ms", mc.splitCursors, { desc = "Split cursors by regex" })
        vim.keymap.set("x", "<leader>mm", mc.matchCursors, { desc = "Match cursors by regex" })
        vim.keymap.set({"n", "x"}, "<leader>mr", mc.restoreCursors, { desc = "Restore cursors" })

        -- Keymap layer - only active when multiple cursors exist
        mc.addKeymapLayer(function(layerSet)
          -- Navigate between cursors
          layerSet({"n", "x"}, "<C-h>", mc.prevCursor, { desc = "Previous cursor" })
          layerSet({"n", "x"}, "<C-l>", mc.nextCursor, { desc = "Next cursor" })

          -- Delete current cursor
          layerSet({"n", "x"}, "<leader>x", mc.deleteCursor, { desc = "Delete cursor" })

          -- Enable/clear cursors with escape
          layerSet("n", "<Esc>", function()
            if not mc.cursorsEnabled() then
              mc.enableCursors()
            else
              mc.clearCursors()
            end
          end, { desc = "Toggle/clear cursors" })
        end)

        -- Visual customization (matches Tokyonight theme)
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { reverse = true })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn" })
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { reverse = true })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
      end,
    }
})
