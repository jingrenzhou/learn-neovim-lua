local common = require("lsp.common-config")

local opts = {
  flags = common.flags,
  on_attach = function(client, bufnr)
    -- common.disableFormat(client)
  common.keyAttach(bufnr)
  end,
}

return {
  setup = function(server)
    server.setup(opts)
  end

}
