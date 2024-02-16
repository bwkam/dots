{ config, lib, pkgs, ... }:
let
  cfg = config.modules.editors.nvim;
  languages = (p:
    map (x: p.${x}) [
      "haskell"
      "nix"
      "lua"
      "typescript"
      "javascript"
      "latex"
    ]);
  vaxe = pkgs.vimUtils.buildVimPlugin {
    name = "haxe.vim";
    src = pkgs.fetchFromGitHub {
      owner = "kLabz";
      repo = "haxe.vim";
      rev = "5fe5ff115675ad46334b65406a386a48a8f2238e";
      sha256 = "sha256-4qfkd4Kbq6qz6x98fD3RdUQuo28wsZmbgJkHWh2epOY=";
    };
  };

  cellular-automaton = pkgs.vimUtils.buildVimPlugin {
    name = "cellular-automaton.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "Eandrju";
      repo = "cellular-automaton.nvim";
      rev = "b7d056dab963b5d3f2c560d92937cb51db61cb5b";
      sha256 = "sha256-szbd6m7hH7NFI0UzjWF83xkpSJeUWCbn9c+O8F8S/Fg=";
    };
  };

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
        cellular-automaton
        cmp-buffer
        cmp-path
        copilot-lua
        copilot-cmp
        nvim-lspconfig
        wilder-nvim
        telescope-nvim
        telescope-media-files-nvim
        (nvim-treesitter.withPlugins languages)
        nvim-autopairs
        comment-nvim
        nvim-ts-context-commentstring
        gitsigns-nvim
        nvim-tree-lua
        trouble-nvim
        vimtex
        (nvim-web-devicons.overrideAttrs (self: super: {
          src = pkgs.fetchFromGitHub {
            owner = "nvim-tree";
            repo = "nvim-web-devicons";
            rev = "7f30f2da3c3641841ceb0e2c150281f624445e8f";
            sha256 = "sha256-Z2uIDeXKInS6qQZxZrpmCuwpT5h0LEOt/Tc+h0LXOus=";
          };
        }))
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
        vaxe
        lualine-nvim
        presence-nvim
        zen-mode-nvim
        (fidget-nvim.overrideAttrs (self: super: {
          src = pkgs.fetchFromGitHub {
            owner = "j-hui";
            repo = "fidget.nvim";
            rev = "1d1042d418ee8cb70d68f1e38db639844331c093";
            sha256 = "sha256-pFXoaqYzYrOmHV3EQycEIRZMe/VA7+T4JR227AOWUNg=";
          };
        }))
      ];
    };
    #
    home.packages = with pkgs; [
      haskell-language-server
      texlab
      neovide
      ghc
      stylua
      lua-language-server
      curl
      nodePackages.typescript-language-server
      typescript
    ];

    xdg.configFile = {
      "nvim/after/ftplugin/haskell.lua".text =
        "\n                local ht = require('haskell-tools')\n        local bufnr = vim.api.nvim_get_current_buf()\n        local opts = { noremap = true, silent = true, buffer = bufnr, }\n        -- haskell-language-server relies heavily on codeLenses,\n        -- so auto-refresh (see advanced configuration) is enabled by default\n        vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, opts)\n        -- Hoogle search for the type signature of the definition under the cursor\n        vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)\n        -- Evaluate all code snippets\n        vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)\n        -- Toggle a GHCi repl for the current package\n        vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)\n        -- Toggle a GHCi repl for the current buffer\n        vim.keymap.set('n', '<leader>rf', function()\n          ht.repl.toggle(vim.api.nvim_buf_get_name(0))\n        end, opts)\n        vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)\n      ";
    };
  };
}