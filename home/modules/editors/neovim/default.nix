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

  pets = pkgs.vimUtils.buildVimPlugin {
    name = "pets.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "giusgad";
      repo = "pets.nvim";
      rev = "747eb5e54fe8b10f4c7ce2881637d1c17b04f229";
      sha256 = "sha256-77+mDpI51L8jjyOGURzruDdXwkc855tc/Mv+CfnX2io=";
    };
  };

  hologram = pkgs.vimUtils.buildVimPlugin {
    name = "hologram.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "giusgad";
      repo = "hologram.nvim";
      rev = "c91aa77121162d8ff554b18a487a3f60677447f2";
      sha256 = "sha256-rNffTS63oSTuBEjN86SijQTrbloQZySfFYy7N0Oyw/8=";
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
      plugins = with vimPluginsLatest; [
        markdown-preview-nvim
        (catppuccin-nvim.overrideAttrs (self: super: {
          postPatch = ''
            substituteInPlace ./lua/catppuccin/groups/integrations/treesitter.lua --replace '["@markup.underline"] = { link = "Underline" }' '["@markup.underline"] = { link = "Underlined" }'
          '';
        }))
        nvim-cmp
        luasnip
        cmp_luasnip
        cmp-nvim-lsp
        cellular-automaton
        dropbar-nvim
        cmp-buffer
        cmp-path
        copilot-lua
        copilot-cmp
        nvim-lspconfig
        pets
        dropbar-nvim
        firenvim
        bufdelete-nvim
        noice-nvim
        hologram
        nui-nvim
        wilder-nvim
        telescope-nvim
        (leap-nvim.overrideAttrs (self: super: {
          src = pkgs.fetchFromGitHub {
            owner = "ggandor";
            repo = "leap.nvim";
            rev = "52f7ce4fcc1764caac77cf4d43c2c4f5fb42d517";
            sha256 = "sha256-I0T+qRgQtiofWjBv55tvf1CmB7QdqvA2YNUcXO+R77Y=";
          };
        }))
        vim-repeat
        telescope-media-files-nvim
        neorg
        image-nvim
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
        alpha-nvim
        nvim-notify
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
        feline-nvim
        presence-nvim
        zen-mode-nvim
        fidget-nvim
      ];
    };
    #11
    home.packages = with pkgs; [
      haskell-language-server
      texlab
      neovide
      ghc
      stylua
      lua-language-server
      curl
      ueberzugpp
      imagemagick
      nodePackages.typescript-language-server
      typescript
    ];

    xdg.configFile = {
      "nvim/after/ftplugin/haskell.lua".text =
        "\n                local ht = require('haskell-tools')\n        local bufnr = vim.api.nvim_get_current_buf()\n        local opts = { noremap = true, silent = true, buffer = bufnr, }\n        -- haskell-language-server relies heavily on codeLenses,\n        -- so auto-refresh (see advanced configuration) is enabled by default\n        vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, opts)\n        -- Hoogle search for the type signature of the definition under the cursor\n        vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)\n        -- Evaluate all code snippets\n        vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)\n        -- Toggle a GHCi repl for the current package\n        vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)\n        -- Toggle a GHCi repl for the current buffer\n        vim.keymap.set('n', '<leader>rf', function()\n          ht.repl.toggle(vim.api.nvim_buf_get_name(0))\n        end, opts)\n        vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)\n      ";
    };
  };
}
