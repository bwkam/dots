-- credits for adding lsp servers: https://github.com/Misterio77/nix-config/blob/ec4bd4983695521e8d1016093f3d092ffbe5ca6e/home/misterio/features/nvim/lsp.nix
local servers = {
	"hls",
	"nil_ls",
	"rust_analyzer",
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local function add_lsp(server, options)
	if options["cmd"] ~= nil then
		binary = options["cmd"][1]
	else
		binary = server["document_config"]["default_config"]["cmd"][1]
	end
	if vim.fn.executable(binary) == 1 then
		server.setup(options)
	end
end

add_lsp(lspconfig.bashls, {})
add_lsp(lspconfig.clangd, {})
add_lsp(lspconfig.nil_ls, {})
-- add_lsp(lspconfig.hls, {})
add_lsp(lspconfig.lua_ls, {})
add_lsp(lspconfig.tsserver, {
	cmd = { "tsserver", "--stdio" },
})

local opts = {}


for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
