vim.api.nvim_create_user_command('CD', "cd %:p:h", {})
vim.api.nvim_create_user_command('Q', "q<bang>", { bang = true })
vim.api.nvim_create_user_command('W', "w<bang>", { bang = true })
