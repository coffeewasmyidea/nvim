require("coffeewasmyidea")

vim.opt.termguicolors = true
vim.opt.guicursor = ""
vim.opt.nu = false
vim.opt.mouse = ""
vim.opt.wrap = false
vim.opt.textwidth = 0
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 1
vim.opt.isfname:append("@-@")
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.autochdir = false
vim.opt.backspace = {"indent", "eol" ,"start" }
vim.opt.smd = false
vim.opt.hidden = true
vim.opt.previewwindow = false
vim.opt.spell = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildmenu = true
vim.opt.wildmode = "full"
vim.opt.foldmethod = "indent"
vim.opt.foldenable = true
vim.opt.foldlevelstart = 10
vim.opt.foldnestmax = 10
vim.opt.ruler = true
vim.opt.list = true

-- Statusline
vim.cmd("set statusline=%<%f\\ %h%m%r%=%-16.(%y\\ %l,%c\\ %)\\ %P\\ \\ ")

-- Global variables
vim.g.syntax = true
vim.g.indent = true

-- UltiSnips
vim.g.UltiSnipsExpandTrigger = "<leader>t"

-- better Netrw
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25

-- background
vim.o.background = "dark"

local c = require("vscode.colors").get_colors()
require("vscode").setup({
    transparent = true,
    italic_comments = true,
    disable_nvimtree_bg = true,
    -- Override colors (see ./lua/vscode/colors.lua)
    -- color_overrides = {
    --     vscLineNumber = "#FFFFFF",
    -- },
    group_overrides = {
        Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
    }
})
require("vscode").load("dark")

-- copy/paste
vim.opt.clipboard = "unnamedplus"

-- lsp config
local lsp = require("lsp-zero").preset({})
-- lsp.preset("recommended")

lsp.ensure_installed({
    "tsserver",
    "clangd",
    "eslint",
    "pyright",
    "rust_analyzer",
    "gopls",
    "sqlls",
    "dockerls",
})

local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
  ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
  ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  ["<CR>"] = cmp.mapping.confirm({ select = true }, {"i", "s", "c" }),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = "E",
        warn = "W",
        hint = "H",
        info = "I"
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  if client.name == "eslint" then
      vim.cmd.LspStop("eslint")
      return
  end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<space>di", vim.diagnostic.disable, opts)
    vim.keymap.set("n", "<space>en", vim.diagnostic.enable, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<space>vq", vim.diagnostic.setloclist, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.setup()

vim.diagnostic.config({ virtual_text = true, })

-- python
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.black_linelength = 80

-- F keys
-- vim.keymap.set("n", "<F3>", ":set rnu! nu!<CR>")
vim.keymap.set("n", "<F3>", ":set nu!<CR>")
vim.keymap.set("n", "<F8>", ":TagbarToggle<CR>")

-- search
require("telescope").setup{ pickers = { find_files = { disable_devicons = true }, live_grep = { disable_devicons = true }, }}
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-f>", builtin.live_grep, {})
vim.keymap.set("n", "<C-p>", builtin.find_files, {})

-- resize
vim.keymap.set("n", "<M-Up>", ":resize -4<CR>")
vim.keymap.set("n", "<M-Down>", ":resize +4<CR>")
vim.keymap.set("n", "<M-Right>", ":vertical resize +4<CR>")
vim.keymap.set("n", "<M-Left>", ":vertical resize -4<CR>")

-- move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- join with cursor stay in place
vim.keymap.set("n", "J", "mzJ`z")

-- search with cursor stay in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- chmod +x
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- navigate 4x faster when holding down Ctrl
vim.keymap.set("n", "<C-j>", "4j")
vim.keymap.set("n", "<C-k>", "4k")
vim.keymap.set("n", "<C-l>", "4l")
vim.keymap.set("n", "<C-h>", "4h")
vim.keymap.set("n", "<C-Down>", "4<Down>")
vim.keymap.set("n", "<C-Up>", "4<Up>")
vim.keymap.set("n", "<C-Left>", "b")
vim.keymap.set("n", "<C-Right>", "e")

-- for visual mode: x[nore]map
vim.keymap.set("x", "<C-j>", "4j")
vim.keymap.set("x", "<C-k>", "4k")
vim.keymap.set("x", "<C-h>", "4h")
vim.keymap.set("x", "<C-l>", "4l")
vim.keymap.set("x", "<C-Down>", "4<Down>")
vim.keymap.set("x", "<C-Up>", "4<Up>")
vim.keymap.set("x", "<C-Left>", "b")
vim.keymap.set("x", "<C-Right>", "e")

-- find and replace
vim.keymap.set("n", "S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- git
vim.keymap.set("n", "<Leader>b", ":Git blame<CR>")
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- explore
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>s", vim.cmd.Vexplore)
vim.keymap.set("n", "<leader>S", vim.cmd.Hexplore)
vim.keymap.set("n", "<leader>T", vim.cmd.Texplore)

if vim.g.vscode == "" then
    -- tree-sitter
    require"nvim-treesitter.configs".setup {
      ensure_installed = { "help", "python", "c", "rust", "go", "lua", "sql" },
      sync_install = false,
      auto_install = true,

      -- List of parsers to ignore installing (for "all")
      ignore_install = { "javascript" },

      highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = { "c", "rust" },
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
    }
end

-- noh
vim.keymap.set("n", "<Leader><space>", ":noh<CR>")

-- autopairs
require("nvim-autopairs").setup({
  disable_filetype = { "vim" },
})

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- zen
require("zen-mode").setup { window = { width = 85, }, }

vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").toggle()
    vim.cmd.GitGutterToggle()
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end)

-- harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

-- mason
require("mason").setup()

-- Go
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require("go.format").goimport()
  end,
  group = format_sync_grp,
})

require("go").setup()
require("dapui").setup()
require("nvim-dap-virtual-text").setup()
