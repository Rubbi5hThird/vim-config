require('plugins')

-- vim option & general configure
vim.g.mapleader			= ','

-- turn off swapfile
vim.g.noswapfile		= true
vim.g.nobackup			= true
vim.g.nowb				= true

-- option here
vim.opt.termguicolors	= true
vim.opt.lazyredraw		= true
vim.opt.number			= true
vim.opt.title			= true
vim.opt.history			= 500
vim.opt.cursorline		= true
vim.opt.autoread		= true
vim.opt.smartcase		= true
vim.opt.hlsearch		= true
vim.opt.showmatch		= true
vim.opt.incsearch		= true
vim.opt.startofline		= false
vim.opt.laststatus		= 2
vim.opt.wrap			= true
vim.opt.linebreak		= true
vim.opt.hidden			= true
vim.opt.splitright		= true
vim.opt.hidden			= true
vim.opt.conceallevel	= 2
vim.opt.concealcursor	= 'i'
vim.opt.fileencoding	= 'utf-8'
vim.opt.encoding		= 'utf-8'
vim.opt.gcr				= 'a:blinkon500-blinkwait500-blinkoff500'
vim.opt.mouse			= 'h'
vim.opt.undofile		= true
vim.opt.smarttab		= true
vim.opt.shiftwidth		= 4
vim.opt.softtabstop		= 4
vim.opt.tabstop			= 4
vim.opt.smartindent		= true
vim.opt.autoindent		= true
vim.opt.foldenable		= false
vim.opt.backspace		= 'indent,eol,start'
vim.opt.wildmenu		= true
vim.opt.wildignore		= '*.o,*.obj,*~,*logs*,*DS_Store*,log/**,tmp/**,*.png,*.jpg,*.gif'
vim.opt.scrolloff		= 8
vim.opt.sidescrolloff	= 15
vim.opt.sidescroll		= 5
vim.opt.timeoutlen		= 1000
vim.opt.ttimeoutlen		= 200
vim.opt.list			= true
vim.opt.listchars:append "space:⋅"

-- nvim function here
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- vim cmd here
vim.cmd("colorscheme onehalfdark")
vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

-- keymap here
map("n", "<leader><space>", ":nohlsearch<CR>", { silent = true })
map("",  "q", "<c-v>")
map("n", "<leader>w", ":w<CR>", { noremap = true })
map("n", "<leader>l", ": set nu!<CR>", { noremap = true })

-- Easier window navigation
map("n",  "<c-h>", "<c-w>h")
map("n",  "<c-j>", "<c-w>j")
map("n",  "<c-k>", "<c-w>k")
map("n",  "<c-l>", "<c-w>l")
map("n", "<leader>v", "<c-w>v", { noremap = true })
map("n", "j", "gj", { noremap = true })
map("n", "k", "gk", { noremap = true })
map("n", "Y", "y$", { noremap = true })

-- open nvim tree
map("n", "<leader>n", ":NvimTreeToggle<CR>")

-- toggle between last 2 buffers
map("n", "<leader><tab>", "<c-^>", { noremap = true })

-- fzf command
map("n", "<leader>o", ":Files<CR>", { noremap = true, silent = true})
map("n", "<leader>h", ":History<CR>", { noremap = true, silent = true})
map("n", "<leader>b", ":Buffers<CR>", { noremap = true, silent = true})
map("n", "<leader>/", ":BLines <C-r><C-w><CR>", { noremap = true })
map("n", "<leader>g", ":RgGLitSearch <C-r><C-w><CR>")
map("v", "<leader>g", 'y:RgGLitSearch <c-r>"<CR>')

-- center highlighted search
map("n",  "n", "nzz")
map("n",  "N", "Nzz")

-- resize window with shift + and shift -
map("n", "+", "<c-w>5>", { noremap = true })
map("n", "_", "<c-w>5<", { noremap = true })

-- Maps for indentation in normal mode
map("n", "<tab>", ">>", { noremap = true })
map("n", "<s-tab>", "<<", { noremap = true })
map("x", "<tab>", ">gv", { noremap = true })
map("x", "<s-tab>", "<gv", { noremap = true })

-- Move selected lines up and down
map("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })
map("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
