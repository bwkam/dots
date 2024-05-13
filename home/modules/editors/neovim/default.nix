{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.modules.editors.nvim;
  languages = (
    p:
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
      "bash"
    ]
  );

  vaxe = pkgs.vimUtils.buildVimPlugin {
    name = "haxe.vim";
    src = pkgs.fetchFromGitHub {
      owner = "kLabz";
      repo = "haxe.vim";
      rev = "5fe5ff115675ad46334b65406a386a48a8f2238e";
      sha256 = "sha256-4qfkd4Kbq6qz6x98fD3RdUQuo28wsZmbgJkHWh2epOY=";
    };
  };

  coal = pkgs.fetchFromGitHub {
    owner = "cranberry-clockworks";
    repo = "coal.nvim";
    rev = "2a1aaad91fbe795a913fc4b402c82b961cf5aa31";
    hash = "sha256-Mcdf0sx0hBDdTimwWJiLU6lMcqPOmODuCCelhwwAgso=";
  };
in
{
  options.modules.editors.nvim.enable = lib.mkEnableOption "nvim";

  config = lib.mkIf cfg.enable {
    xdg.configFile = {
      "nvim/lua".source = ./lua;
      "nvim/init.lua".source = ./init.lua;
    };
    programs.neovim = {
      enable = true;
      # extraLuaConfig = ''
      #   vim.g.nix_plugins_dir = "${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start"
      # '';
      plugins = with pkgs.vimPlugins; [
        nvim-cmp
        luasnip
        coal
        cmp_luasnip
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        # hover-nvim
        nvim-ufo
        nvim-lspconfig
        nvim-colorizer-lua
        bufdelete-nvim
        telescope-nvim
        flash-nvim
        # neorg
        # neorg-telescope
        vim-fugitive
        (nvim-treesitter.withPlugins languages)
        nvim-autopairs
        comment-nvim
        nvim-ts-context-commentstring
        gitsigns-nvim
        nvim-tree-lua
        vimtex
        nvim-web-devicons
        (bufferline-nvim.overrideAttrs (
          final: prev: {
            src = pkgs.fetchFromGitHub {
              owner = "akinsho";
              repo = "bufferline.nvim";
              rev = "73540cb95f8d95aa1af3ed57713c6720c78af915";
              hash = "sha256-bHlmaNXfZTlTm/8v48FwCde9ljZFLv25efYF5355bnw=";
            };
          }
        ))
        dashboard-nvim
        null-ls-nvim
        which-key-nvim
        vaxe
        lualine-nvim
      ];
    };
    #11
    home.packages = with pkgs; [
      haskell-language-server
      nil
      nixfmt-rfc-style
      texlab
      ghc
      stylua
      lua-language-server
      asm-lsp
      curl
      nodePackages.typescript-language-server
      nodePackages.bash-language-server
      typescript
    ];

    xdg.configFile = {
      "nvim/after/ftplugin/haskell.lua".text = "\n                local ht = require('haskell-tools')\n        local bufnr = vim.api.nvim_get_current_buf()\n        local opts = { noremap = true, silent = true, buffer = bufnr, }\n        -- haskell-language-server relies heavily on codeLenses,\n        -- so auto-refresh (see advanced configuration) is enabled by default\n        vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, opts)\n        -- Hoogle search for the type signature of the definition under the cursor\n        vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)\n        -- Evaluate all code snippets\n        vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)\n        -- Toggle a GHCi repl for the current package\n        vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)\n        -- Toggle a GHCi repl for the current buffer\n        vim.keymap.set('n', '<leader>rf', function()\n          ht.repl.toggle(vim.api.nvim_buf_get_name(0))\n        end, opts)\n        vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)\n      ";
    };
  };
}
