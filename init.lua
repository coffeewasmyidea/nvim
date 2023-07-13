require("coffeewasmyidea")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = ""
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.ruler = true
vim.opt.showmode = true
vim.opt.autoindent = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true

-- Statusline
vim.cmd("set statusline=%<%f\\ %h%m%r%=%-16.(%y\\ %l,%c\\ %)\\ %P\\ \\ ")

-- Global variables
vim.g.syntax = true
vim.g.indent = true

-- UltiSnips
vim.g.UltiSnipsExpandTrigger = "<leader>t"

-- Better Netrw
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25

vim.cmd("colorscheme desert")
vim.cmd("highlight LineNr ctermfg=grey")

-- Copy/paste
vim.opt.clipboard = "unnamedplus"

-- LSP config
local lsp = require("lsp-zero").preset({})

lsp.ensure_installed({
    "tsserver",
    "clangd",
    -- "eslint",
    "pyright",
    "rust_analyzer",
    "gopls",
    -- "sqlls",
    -- "dockerls",
    -- "ansiblels",
    -- "awk_ls",
    "bashls",
    "cmake",
    -- "docker_compose_language_service",
    -- "helm_ls",
    -- "jsonls",
    -- "lua_ls",
    -- "terraformls",
    -- "yamlls",
})

local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
  ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
  ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  ["<CR>"] = cmp.mapping.confirm({ select = false}, {"i", "s", "c" }),
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
    vim.keymap.set("n", "<space>vd", vim.diagnostic.open_float, opts)
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

-- Python
vim.g.python3_host_prog = "/bin/python"
vim.g.black_linelength = 80

-- F keys
vim.keymap.set("n", "<F3>", ":set rnu! nu!<CR>")
-- vim.keymap.set("n", "<F3>", ":set nu!<CR>")
vim.keymap.set("n", "<F8>", ":TagbarToggle<CR>")

-- Search
require("telescope").setup{
pickers = {
    find_files = {
        disable_devicons = true },
        live_grep = { disable_devicons = true },
    }
}
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-f>", builtin.live_grep, {})
vim.keymap.set("n", "<C-p>", builtin.find_files, {})

-- Resize
vim.keymap.set("n", "<M-Up>", ":resize -4<CR>")
vim.keymap.set("n", "<M-Down>", ":resize +4<CR>")
vim.keymap.set("n", "<M-Right>", ":vertical resize +4<CR>")
vim.keymap.set("n", "<M-Left>", ":vertical resize -4<CR>")

-- Move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Join with cursor stay in place
vim.keymap.set("n", "J", "mzJ`z")

-- Search with cursor stay in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Chmod +x
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Navigate 4x faster when holding down Ctrl
vim.keymap.set("n", "<C-j>", "4j")
vim.keymap.set("n", "<C-k>", "4k")
vim.keymap.set("n", "<C-l>", "4l")
vim.keymap.set("n", "<C-h>", "4h")
vim.keymap.set("n", "<C-Down>", "4<Down>")
vim.keymap.set("n", "<C-Up>", "4<Up>")
vim.keymap.set("n", "<C-Left>", "b")
vim.keymap.set("n", "<C-Right>", "e")

-- For visual mode: x[nore]map
vim.keymap.set("x", "<C-j>", "4j")
vim.keymap.set("x", "<C-k>", "4k")
vim.keymap.set("x", "<C-h>", "4h")
vim.keymap.set("x", "<C-l>", "4l")
vim.keymap.set("x", "<C-Down>", "4<Down>")
vim.keymap.set("x", "<C-Up>", "4<Up>")
vim.keymap.set("x", "<C-Left>", "b")
vim.keymap.set("x", "<C-Right>", "e")

-- Find and replace
vim.keymap.set("n", "S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Git
vim.keymap.set("n", "<Leader>b", ":Git blame<CR>")
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- Explore
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>s", vim.cmd.Vexplore)
vim.keymap.set("n", "<leader>S", vim.cmd.Hexplore)
vim.keymap.set("n", "<leader>T", vim.cmd.Texplore)

-- Noh
vim.keymap.set("n", "<Leader><space>", ":noh<CR>")

-- Autopairs
require("nvim-autopairs").setup({
  disable_filetype = { "vim" },
})

-- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Zen
require("zen-mode").setup { window = { width = 85, }, }
vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").toggle()
    vim.cmd.GitGutterToggle()
end)

-- Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

-- Mason
require("mason").setup()

-- Dap
local dap = require("dap")
vim.keymap.set("n", "<space>db", vim.cmd.DapToggleBreakpoint)
vim.keymap.set("n", "<space>dus", function()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open()
    end
)
vim.keymap.set("n", "<space>dn", vim.cmd.DapStepOver)
vim.keymap.set("n", "<space>dN", vim.cmd.DapStepOut)

-- C/CPP
dap.adapters.lldb = {
  type = "executable",
  command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
  name = "lldb"
}
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {}
  },
}

-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- Rust
dap.configurations.rust = {
  {
    -- ... the previous config goes here ...,
    initCommands = function()
      -- Find out where to look for the pretty printer Python module
      local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

      local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
      local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

      local commands = {}
      local file = io.open(commands_file, 'r')
      if file then
        for line in file:lines() do
          table.insert(commands, line)
        end
        file:close()
      end
      table.insert(commands, 1, script_import)

      return commands
    end,
    -- ...,
  }
}

-- Go
dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = {'dap', '-l', '127.0.0.1:${port}'},
  }
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  -- works with go.mod packages and sub packages 
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  } 
}

-- Bash
dap.adapters.bashdb = {
  type = 'executable';
  command = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/bash-debug-adapter';
  name = 'bashdb';
}

dap.configurations.sh = {
  {
    type = 'bashdb';
    request = 'launch';
    name = "Launch file";
    showDebugOutput = true;
    pathBashdb = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb';
    pathBashdbLib = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir';
    trace = true;
    file = "${file}";
    program = "${file}";
    cwd = '${workspaceFolder}';
    pathCat = "cat";
    pathBash = "/bin/bash";
    pathMkfifo = "mkfifo";
    pathPkill = "pkill";
    args = {};
    env = {};
    terminalKind = "integrated";
  }
}

-- Python
dap.adapters.python = function(cb, config)
  if config.request == 'attach' then
    ---@diagnostic disable-next-line: undefined-field
    local port = (config.connect or config).port
    ---@diagnostic disable-next-line: undefined-field
    local host = (config.connect or config).host or '127.0.0.1'
    cb({
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
      options = {
        source_filetype = 'python',
      },
    })
  else
    cb({
      type = 'executable',
      command = vim.fn.stdpath("data") .. '/mason/packages/debugpy/venv/bin/python',
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    })
  end
end

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

require('go').setup()
