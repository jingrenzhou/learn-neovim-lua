-- see : help mason-lspconfig-dynamic-server-setup to detail
local lspconfig = require("lspconfig")

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {"clangd", "sumneko_lua", "gopls"},
})
require("mason-lspconfig").setup_handlers ({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function (server) -- default handler (optional)
    local config = require("lsp.config."..server)
    config.setup(lspconfig[server])
	end,
	-- Next, you can provide targeted overrides for specific servers.
  -- example:
	--["clangd"] = function ()
	--		require("lsp.config.clangd").setup() -- must be function
  --end,
})
