require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "pyright", "rust_analyzer", "gopls", "intelephense" },
}
local lspconfig = require("lspconfig")
lspconfig.pyright.setup {}
lspconfig.rust_analyzer.setup {}
lspconfig.gopls.setup {}
lspconfig.intelephense.setup {}
