-- https://github.com/Misterio77/nix-config/blob/ec4bd4983695521e8d1016093f3d092ffbe5ca6e/home/misterio/features/nvim/lsp.nix

local lspconfig = require('lspconfig')
function add_lsp(server, options)
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
add_lsp(lspconfig.hls, {})
add_lsp(lspconfig.lua_ls, {})
add_lsp(lspconfig.tsserver, {
    cmd = { "tsserver", "--stdio" }
})
