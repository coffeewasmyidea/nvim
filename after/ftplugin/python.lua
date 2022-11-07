vim.keymap.set("n", "<F5>", ":Black<CR>")
vim.keymap.set("n", "<Leader>x", ":!python %<CR>")

vim.opt.textwidth = 0

require("dap-python").resolve_python = function()
  return "/usr/bin/python3.10"
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
