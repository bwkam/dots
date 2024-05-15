{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.modules.editors.nvim;
in {
  options.modules.editors.nvim.enable = lib.mkEnableOption "nvim";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      inputs.neovim.packages.${pkgs.system}.neovim
      # haskell-language-server
      nixfmt-rfc-style
      # texlab
      # ghc
      # stylua
      # lua-language-server
      # asm-lsp
      # curl
      # nodePackages.typescript-language-server
      # nodePackages.bash-language-server
      # typescript
    ];

    # xdg.configFile = {
    #   "nvim/after/ftplugin/haskell.lua".text = "\n                local ht = require('haskell-tools')\n        local bufnr = vim.api.nvim_get_current_buf()\n        local opts = { noremap = true, silent = true, buffer = bufnr, }\n        -- haskell-language-server relies heavily on codeLenses,\n        -- so auto-refresh (see advanced configuration) is enabled by default\n        vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, opts)\n        -- Hoogle search for the type signature of the definition under the cursor\n        vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)\n        -- Evaluate all code snippets\n        vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)\n        -- Toggle a GHCi repl for the current package\n        vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)\n        -- Toggle a GHCi repl for the current buffer\n        vim.keymap.set('n', '<leader>rf', function()\n          ht.repl.toggle(vim.api.nvim_buf_get_name(0))\n        end, opts)\n        vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)\n      ";
    # };
  };
}
