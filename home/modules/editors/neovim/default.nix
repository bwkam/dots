{ config, lib, pkgs, ... }:
let
  cfg = config.modules.editors.nvim;
  languages = (p: map (x: p.${x}) [ "haskell" "nix" "lua" ]);
in {
  options.modules.editors.nvim.enable = lib.mkEnableOption "nvim";

  config = lib.mkIf cfg.enable {
    xdg.configFile = {
      "nvim/lua".source = ./lua;
      "nvim/init.lua".source = ./init.lua;
    };
    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        markdown-preview-nvim
        catppuccin-nvim
        nvim-cmp
        luasnip
        cmp_luasnip
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        nvim-lspconfig
        telescope-nvim
        telescope-media-files-nvim
        (nvim-treesitter.withPlugins languages)
        nvim-autopairs
        comment-nvim
        nvim-ts-context-commentstring
        gitsigns-nvim
        nvim-tree-lua
        nvim-web-devicons
        bufferline-nvim
        alpha-nvim
        dashboard-nvim
        null-ls-nvim
        impatient-nvim
        toggleterm-nvim
        which-key-nvim
        haskell-tools-nvim
        rustaceanvim
      ];
    };
    #
    home.packages = with pkgs; [
      haskell-language-server
      ghc
      stylua
      lua-language-server
    ];

    xdg.configFile = {
      "nvim/after/ftplugin/haskell.lua".text = "
                local ht = require('haskell-tools')
        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { noremap = true, silent = true, buffer = bufnr, }
        -- haskell-language-server relies heavily on codeLenses,
        -- so auto-refresh (see advanced configuration) is enabled by default
        vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, opts)
        -- Hoogle search for the type signature of the definition under the cursor
        vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
        -- Evaluate all code snippets
        vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
        -- Toggle a GHCi repl for the current package
        vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)
        -- Toggle a GHCi repl for the current buffer
        vim.keymap.set('n', '<leader>rf', function()
          ht.repl.toggle(vim.api.nvim_buf_get_name(0))
        end, opts)
        vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)
      ";
    };
  };
}
