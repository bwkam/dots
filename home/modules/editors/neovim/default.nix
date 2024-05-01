{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.modules.editors.nvim;
  languages = (p:
    map (x: p.${x}) [
      "haskell"
      "nix"
      "lua"
      "norg"
      "typescript"
      "javascript"
      "latex"
      "markdown"
      "asm"
    ]);

  vimPluginsLatest =
    inputs.nixpkgs-unstable.legacyPackages."x86_64-linux".vimPlugins;

  catppuccin-nvim =
    inputs.nixpkgs-unstable.legacyPackages."x86_64-linux".vimPlugins.catppuccin-nvim;
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

  coal = pkgs.fetchFromGitHub {
    owner = "cranberry-clockworks";
    repo = "coal.nvim";
    rev = "2a1aaad91fbe795a913fc4b402c82b961cf5aa31";
    hash = "sha256-Mcdf0sx0hBDdTimwWJiLU6lMcqPOmODuCCelhwwAgso=";
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
      # extraLuaConfig = ''
      #   vim.g.nix_plugins_dir = "${pkgs.vimUtils.packDirconfig.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start"
      # '';
      plugins = with vimPluginsLatest; [
        markdown-preview-nvim
        nvim-cmp
        # lazy-nvim
        luasnip
        coal
        cmp_luasnip
        cmp-nvim-lsp
        cellular-automaton
        vim-prettier
        cmp-buffer
        cmp-path
        copilot-lua
        hover-nvim
        nvim-ufo
        copilot-cmp
        nvim-lspconfig
        nvim-colorizer-lua
        bufdelete-nvim
        telescope-nvim
        flash-nvim
        vim-repeat
        telescope-media-files-nvim
        neorg
        vim-fugitive
        neorg-telescope
        (nvim-treesitter.withPlugins languages)
        nvim-autopairs
        comment-nvim
        nvim-ts-context-commentstring
        gitsigns-nvim
        nvim-tree-lua
        trouble-nvim
        vimtex
        nvim-web-devicons
        bufferline-nvim
        dashboard-nvim
        null-ls-nvim
        plenary-nvim
        impatient-nvim
        toggleterm-nvim
        which-key-nvim
        rustaceanvim
        haskell-tools-nvim
        vaxe
        lualine-nvim
        presence-nvim
        zen-mode-nvim
        fidget-nvim
      ];
    };
    #11
    home.packages = with pkgs; [
      haskell-language-server
      texlab
      # neovide
      ghc
      stylua
      lua-language-server
      asm-lsp
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
