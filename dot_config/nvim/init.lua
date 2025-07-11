-- general options
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
vim.g.netrw_browse_split = 3
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 50

vim.env.FZF_DEFAULT_OPTS = "--bind=tab:down,btab:up"

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

-- keymaps

vim.keymap.set('n', '<leader>e', ':Sex<CR>', { desc = 'Open netrw file explorer', noremap = true, silent = true })
vim.keymap.set('n', '<leader>gg', ':Neogit<CR>', { desc = 'Open Neogit', noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Esc>', ':nohls<CR><Esc>', { noremap = true, silent = true })
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
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    },
    {
        "https://github.com/nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require("lualine").setup {
                options = { 
                    theme = 'tokyonight-night',
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
          } 
        },
        { name = "path" },
          })
        })
      end,
    },
})

vim.cmd[[colorscheme tokyonight-night]]
