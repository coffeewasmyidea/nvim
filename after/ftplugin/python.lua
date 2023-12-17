vim.keymap.set("n", "<F5>", ":Black<CR>")
vim.keymap.set("n", "<Leader>x", ":!python %<CR>")
vim.opt.wrap = false
-- vim.opt.textwidth = 0
-- vim.opt.textwidth=100
require("dap-python").resolve_python = function()
  return "/usr/bin/python"
end

-- local dap = require("dap")
-- dap.configurations.python = {
--   {
--     type = "python";
--     request = "launch";
--     name = "Launch file";
--     program = "${file}";
--     pythonPath = function()
--       return "/usr/bin/python"
--     end;
--   },
-- }
