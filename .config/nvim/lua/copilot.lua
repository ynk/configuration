vim.g.copilot_no_tab_map = true
vim.cmd("autocmd FileType * lua require'copilot'.setup {}")