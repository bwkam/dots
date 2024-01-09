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
      ];
    };
    #
    home.packages = with pkgs; [ haskell-language-server ghc stylua lua-language-server ];
  };
}
