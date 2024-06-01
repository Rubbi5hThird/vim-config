-- vim option & general configure
vim.g.mapleader     = ','

-- turn off swapfile
vim.g.nobackup  = true
vim.g.nowb = true
vim.g.have_nerd_font = false

local function set_opts()
  vim.opt.swapfile = false
  vim.opt.colorcolumn = '80'
  vim.opt.termguicolors = true
  vim.opt.lazyredraw = false
  vim.opt.showmode = false
  vim.opt.number = true
  vim.opt.title = true
  vim.opt.history = 500
  vim.opt.cursorline = true
  vim.opt.autoread = true
  vim.opt.smartcase = true
  vim.opt.hlsearch = true
  vim.opt.showmatch = true
  vim.opt.incsearch = true
  vim.opt.startofline = false
  vim.opt.laststatus = 2
  vim.opt.wrap = true
  vim.opt.linebreak = true
  vim.opt.hidden = true
  vim.opt.splitright = true
  vim.opt.hidden = true
  vim.opt.conceallevel = 2
  vim.opt.concealcursor = 'i'
  vim.opt.fileencoding  = 'utf-8'
  vim.opt.encoding = 'utf-8'
  vim.opt.gcr  = 'a:blinkon500-blinkwait500-blinkoff500'
  vim.opt.mouse = 'h'
  vim.opt.undofile = true
  vim.opt.smarttab = true
  vim.opt.shiftwidth = 2
  vim.opt.softtabstop = 2
  vim.opt.tabstop = 2
  vim.opt.expandtab = true
  vim.opt.smartindent = true
  vim.opt.autoindent = true
  vim.opt.foldenable = false
  vim.opt.backspace = 'indent,eol,start'
  vim.opt.wildmenu = true
  vim.opt.wildignore = '*.o,*.obj,*~,*logs*,*DS_Store*,log/**,tmp/**,*.png,*.jpg,*.gif'
  vim.opt.scrolloff = 8
  vim.opt.sidescrolloff = 15
  vim.opt.sidescroll = 5
  vim.opt.timeoutlen = 1000
  vim.opt.ttimeoutlen = 200
end

local function set_colorscheme()
  vim.cmd("colorscheme onehalfdark")
end

local function set_keymaps()
  local opts = {noremap = true, silent = true}

  -- local command = 'c'
  -- local insert = 'i'
  local normal = 'n'
  -- local term = 't'
  local visual = 'v'
  -- local visual_block = 'x'

  vim.keymap.set(normal, '<leader><space>', ':nohlsearch<CR>', opts)
  vim.keymap.set(normal, '<leader>w', ':w<CR>', opts)
  vim.keymap.set(normal, "<leader>l", ": set nu!<CR>", opts)

  -- navigate
  vim.keymap.set(normal, "<c-h>", '<c-w>h', opts)
  vim.keymap.set(normal, "<c-j>", '<c-w>j', opts)
  vim.keymap.set(normal, "<c-k>", '<c-w>k', opts)
  vim.keymap.set(normal, "<c-l>", '<c-w>l', opts)

  -- split
  vim.keymap.set(normal, "<leader>v", "<c-w>v", opts)

  -- tabsize
  vim.keymap.set(normal, "<leader>2", ":call SetTab(2)<CR>")
  vim.keymap.set(normal, "<leader>4", ":call SetTab(4)<CR>")

  -- search
  vim.keymap.set(normal,  "n", "nzz", opts)
  vim.keymap.set(normal,  "N", "Nzz", opts)

  -- Move selected lines up and down
  vim.keymap.set(visual, "K", ":m '<-2<CR>gv=gv", opts)
  vim.keymap.set(visual, "J", ":m '>+1<CR>gv=gv", opts)
end

local function setup_autocmds()
  local general_settings = vim.api.nvim_create_augroup('general_settings', {clear = true})

  -- return to the same line when you reopen a file
  vim.cmd [[
  augroup line_return
  autocmd!
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line('$') |
  \     execute 'normal! g`"zvzz' |
  \ endif
  augroup end
  ]]

  -- automatically delete all trailing whitespace and newlines at end of file on save
  local trailing_whitespace = vim.api.nvim_create_augroup('trailing_whitespace', {clear = true})
  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    group = trailing_whitespace,
    callback = function()
      if vim.bo.filetype ~= 'diff' then
        vim.cmd('%s/\\s\\+$//e')
        vim.cmd('%s/\\n\\+\\%$//e')
      end
    end
  })
end

local function intall_plugins()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end

  vim.opt.rtp:prepend(lazypath)

  local opts = {noremap = true, silent = true}
  local normal = 'n'
  local visual = 'v'

  require("lazy").setup({
    { 'lewis6991/fileline.nvim' },
    { 'vivien/vim-linux-coding-style' },
    { 'lukas-reineke/indent-blankline.nvim' },
    { 'HiPhish/rainbow-delimiters.nvim' },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'numToStr/Comment.nvim', opts = {}, lazy = false, },
    { 'lewis6991/gitsigns.nvim', opts = {} },
    { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },
    { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
    { "dhananjaylatkar/cscope_maps.nvim",
      dependencies = { "nvim-telescope/telescope.nvim", "nvim-tree/nvim-web-devicons", },
    },
    { 'google/vim-codefmt', enabled = working,
      dependencies = { 'google/vim-maktaba', { 'google/vim-glaive', config = function() vim.cmd('call glaive#Install()') end },
      },
    },
    { 'nvim-telescope/telescope.nvim', tag = '0.1.6',
      dependencies = {
        'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim', { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      },
      init = function()
        vim.keymap.set(normal, '<leader>o', '<cmd>Telescope find_files<cr>', opts)
        vim.keymap.set(normal, '<leader>G', '<cmd>Telescope live_grep<cr>', opts)
        vim.keymap.set(normal, '<leader>g', '<cmd>Telescope grep_string<cr>', opts)
        vim.keymap.set(normal, '<leader>z', '<cmd>Telescope spell_suggest<cr>', opts)
        vim.keymap.set(normal, '<leader>b', '<cmd>Telescope buffers<cr>', opts)
      end
  },
})
end

local function plugin_treesitter()
  local configs = require('nvim-treesitter.configs')

  configs.setup({
    ensure_installed = { "c", "lua", "vim", "cpp", "java", "bash", "python", "diff", "make", "css" },
    sync_install = false,
    auto_install = false,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,

      -- due to https://github.com/nvim-treesitter/nvim-treesitter/issues/2916
      disable = {'markdown'},
    }
  })
end

local function plugin_lualine()
  local lualine = require('lualine')

  lualine.setup({
    options = {
      icons_enabled = true,
      theme = 'auto',
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' }
    },
    sections = {
      lualine_a = {
        'mode',
        {'datetime', style = '%H:%M'}
      },
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
  })

end

local function plugin_telescope()
  local telescope = require('telescope')

  telescope.setup {
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      }
    },
    defaults = {
      layout_config = {
        preview_width = 0.65,
        scroll_speed = 2,
      },
    },
  }
  telescope.load_extension('fzf')
end

local function plugin_ibl()
  local highlight = { "RainbowRed", "RainbowYellow", "RainbowBlue", "RainbowOrange", "RainbowGreen", "RainbowViolet", "RainbowCyan", }

  local hooks = require('ibl.hooks')
  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP,
  function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  end)

  vim.g.rainbow_delimiters = { highlight = highlight }
  require("ibl").setup {
    indent = { highlight = highlight, char = "│" },
    whitespace = {
      highlight = highlight,
      remove_blankline_trail = true,
    },
    scope = { enabled = false },
  }
end

local function plugin_cscope()
  local cm = require('cscope_maps')

  cm.setup{
    -- maps related defaults
    disable_maps = false, -- "true" disables default keymaps
    skip_input_prompt = false, -- "true" doesn't ask for input
    prefix = "<leader>c", -- prefix to trigger maps

    cscope = {
      picker = "telescope",
    }
  }
end

local function plugin_gitsigns()
  local gitsigns = require('gitsigns')
  gitsigns.setup{
    on_attach = function(bufnr)

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({']c', bang = true})
        else
          gitsigns.nav_hunk('next')
        end
      end)

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({'[c', bang = true})
        else
          gitsigns.nav_hunk('prev')
        end
      end)

      -- Actions
      map('n', '<leader>hs', gitsigns.stage_hunk)
      map('n', '<leader>hr', gitsigns.reset_hunk)
      map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      map('n', '<leader>hS', gitsigns.stage_buffer)
      map('n', '<leader>hu', gitsigns.undo_stage_hunk)
      map('n', '<leader>hR', gitsigns.reset_buffer)
      map('n', '<leader>hp', gitsigns.preview_hunk)
      map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
      map('n', '<leader>hd', gitsigns.diffthis)
      map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
      map('n', '<leader>td', gitsigns.toggle_deleted)

      -- Text object
      map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
  }

end

local function main()
  set_opts()
  set_colorscheme()
  set_keymaps()
  setup_autocmds()

  intall_plugins()
  plugin_treesitter()
  plugin_lualine()
  plugin_telescope()
  plugin_ibl()
  plugin_cscope()
  plugin_gitsigns()
end

main()
