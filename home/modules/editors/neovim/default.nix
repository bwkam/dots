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
        telescope-nvim
        telescope-media-files-nvim
        (nvim-treesitter.withPlugins (
          plugins:
            with plugins; [
              haskell
              nix
            ]
        ))
        nvim-autopairs
        comment-nvim
        nvim-ts-context-commentstring
        gitsigns-nvim
        nvim-tree-lua
        nvim-web-devicons
        bufferline-nvim
        alpha-nvim
];
    };
    #
    home.packages = with pkgs; [
      haskell-language-server
      ghc
    ];
  };
}
