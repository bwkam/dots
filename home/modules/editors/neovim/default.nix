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
        plenary-nvim
        impatient-nvim
        toggleterm-nvim
        which-key-nvim
        rustaceanvim
        (haskell-tools-nvim.overrideAttrs (self: super: {
          src = pkgs.fetchFromGitHub {
            owner = "MrcJkb";
            repo = "haskell-tools.nvim";
            rev = "f6a12216f33ca234586e61e9153b6b3244bfa801";
            sha256 = "sha256-wLp24x8aKZyi3yRUZJ3uff3YCy3x7pg14KdxcFDJQc0=";
          };
        }))
        lualine-nvim
        presence-nvim
        fidget-nvim
      ];
    };
    #
    home.packages = with pkgs; [
      haskell-language-server
      ghc
      stylua
      lua-language-server
      curl
    ];

    xdg.configFile = {
      "nvim/after/ftplugin/haskell.lua".text =
        "\n                local ht = require('haskell-tools')\n        local bufnr = vim.api.nvim_get_current_buf()\n        local opts = { noremap = true, silent = true, buffer = bufnr, }\n        -- haskell-language-server relies heavily on codeLenses,\n        -- so auto-refresh (see advanced configuration) is enabled by default\n        vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, opts)\n        -- Hoogle search for the type signature of the definition under the cursor\n        vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)\n        -- Evaluate all code snippets\n        vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)\n        -- Toggle a GHCi repl for the current package\n        vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)\n        -- Toggle a GHCi repl for the current buffer\n        vim.keymap.set('n', '<leader>rf', function()\n          ht.repl.toggle(vim.api.nvim_buf_get_name(0))\n        end, opts)\n        vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)\n      ";
    };
  };
}
