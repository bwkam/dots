{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.editors.nvim;
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
      ];
    };

    home.packages = with pkgs; [
      haskell-language-server
      ghc
    ];
  };
}
