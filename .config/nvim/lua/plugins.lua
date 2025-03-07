local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "folke/tokyonight.nvim", lazy = false },
    { "nvim-tree/nvim-tree.lua", lazy = false },
    { "williamboman/mason.nvim", config = true },
    { "williamboman/mason-lspconfig.nvim", config = true },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },
    { "github/copilot.vim" },
    { "kdheepak/lazygit.nvim" },
})
