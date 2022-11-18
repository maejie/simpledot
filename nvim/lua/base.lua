vim.cmd("autocmd!")
vim.scriptencoding = "utf-8"
vim.wo.number = true

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])

-- set netrw(explorer) variable
vim.api.nvim_set_var("netrw_liststyle", 3)  -- tree mode
vim.api.nvim_set_var("netrw_altv", 1)  -- v key open file in right window
vim.api.nvim_set_var("netrw_alto", 1)  -- o key open file in below window
