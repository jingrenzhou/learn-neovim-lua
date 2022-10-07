local lspconfig = require("lspconfig")

-- see : help mason-lspconfig-dynamic-server-setup to detail
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {"clangd"},
})
require("mason-lspconfig").setup_handlers {
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function (server_name) -- default handler (optional)
		lspconfig[server_name].setup {}
	end,
	-- Next, you can provide targeted overrides for specific servers.
	["clangd"] = function ()
		lspconfig['clangd'].setup {
			require("lsp.config.clangd")
		}
	end
}
